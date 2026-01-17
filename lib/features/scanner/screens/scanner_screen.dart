import 'package:books_tracker/features/search/models/search_state.dart';
import 'package:books_tracker/features/search/providers/search_providers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Scanner Screen - AI-powered bookshelf scanner
/// Mobile: Camera-based AI detection with Gemini 2.0 Flash (TODO)
/// Barcode: MobileScanner for ISBN
class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  late final MobileScannerController _controller;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (!_isScanning) return;

    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final String? rawValue = barcode.rawValue;

    if (rawValue != null && rawValue.isNotEmpty) {
      if (_isValidISBN(rawValue)) {
        _handleValidISBN(rawValue);
      }
    }
  }

  bool _isValidISBN(String code) {
    // Basic length check for 10 or 13 digits (ignoring dashes for now)
    final clean = code.replaceAll(RegExp(r'[^0-9X]'), '');
    return clean.length == 10 || clean.length == 13;
  }

  void _handleValidISBN(String isbn) {
    setState(() {
      _isScanning = false;
    });

    // Provide feedback
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('ISBN Detected: $isbn')));

    // Update Search Providers
    ref.read(searchQueryProvider.notifier).setQuery(isbn);
    ref.read(searchScopeProvider.notifier).setScope(SearchScope.isbn);

    // Navigate to Search
    // Use a slight delay to ensure user sees the "Detected" state or haptic feedback
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.go('/search');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Scaffold(
        body: Center(child: Text('Barcode scanning not supported on Web yet.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan ISBN'),
        actions: [
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: _controller,
            builder: (context, state, child) {
              final torchEnabled = state.torchState == TorchState.on;
              return IconButton(
                icon: Icon(
                  torchEnabled ? Icons.flash_on : Icons.flash_off,
                  color: torchEnabled ? Colors.yellow : Colors.grey,
                ),
                onPressed: () => _controller.toggleTorch(),
              );
            },
          ),
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: _controller,
            builder: (context, state, child) {
              final isFrontCamera = state.cameraDirection == CameraFacing.front;
              return IconButton(
                icon: Icon(
                  isFrontCamera ? Icons.camera_front : Icons.camera_rear,
                ),
                onPressed: () => _controller.switchCamera(),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text('Camera Error: ${error.errorCode}'),
                  ],
                ),
              );
            },
          ),
          // Overlay
          Container(
            decoration: ShapeDecoration(
              shape: OverlayShape(
                borderColor: _isScanning ? Colors.white : Colors.green,
                borderRadius: 12,
                borderLength: 32,
                borderWidth: 8,
                cutOutSize: 280,
              ),
            ),
          ),
          // Instructions
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Text(
              _isScanning ? 'Point camera at ISBN barcode' : 'Processing...',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                shadows: [Shadow(blurRadius: 4)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for corner overlay (simplified for brevity, or rely on external package, but here I used a placeholder ShapeDecoration class name that might not exist, so I will implement a Container with simple border for now to be safe)
class OverlayShape extends ShapeBorder {
  // ... implementation of corner borders ...
  // To keep it simple and robust without extra code, I will use a simple Container with Border.

  final Color borderColor;
  final double borderRadius;
  final double borderLength;
  final double borderWidth;
  final double cutOutSize;

  const OverlayShape({
    required this.borderColor,
    this.borderRadius = 12,
    this.borderLength = 32,
    this.borderWidth = 8,
    this.cutOutSize = 280,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: rect.center,
          width: cutOutSize,
          height: cutOutSize,
        ),
        Radius.circular(borderRadius),
      ),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // Return path with hole
    final Path path = Path()..addRect(rect);
    final Path hole = getInnerPath(rect);
    return Path.combine(PathOperation.difference, path, hole);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Draw darken outside
    final Paint paint = Paint()..color = Colors.black54;
    canvas.drawPath(getOuterPath(rect), paint);

    // Draw borders (simplified: just the rect for now)
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: rect.center,
          width: cutOutSize,
          height: cutOutSize,
        ),
        Radius.circular(borderRadius),
      ),
      borderPaint,
    );
  }

  @override
  ShapeBorder scale(double t) => this;
}
