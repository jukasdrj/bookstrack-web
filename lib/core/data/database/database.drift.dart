// dart format width=80
// ignore_for_file: type=lint
part of 'database.dart';

class $WorksTable extends Works with TableInfo<$WorksTable, Work> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtitleMeta =
      const VerificationMeta('subtitle');
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
      'subtitle', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> authorIds =
      GeneratedColumn<String>('author_ids', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($WorksTable.$converterauthorIds);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      subjectTags = GeneratedColumn<String>('subject_tags', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($WorksTable.$convertersubjectTags);
  static const VerificationMeta _syntheticMeta =
      const VerificationMeta('synthetic');
  @override
  late final GeneratedColumn<bool> synthetic = GeneratedColumn<bool>(
      'synthetic', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synthetic" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _reviewStatusMeta =
      const VerificationMeta('reviewStatus');
  @override
  late final GeneratedColumn<String> reviewStatus = GeneratedColumn<String>(
      'review_status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _workKeyMeta =
      const VerificationMeta('workKey');
  @override
  late final GeneratedColumn<String> workKey = GeneratedColumn<String>(
      'work_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<DataProvider?, String> provider =
      GeneratedColumn<String>('provider', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<DataProvider?>($WorksTable.$converterprovider);
  static const VerificationMeta _qualityScoreMeta =
      const VerificationMeta('qualityScore');
  @override
  late final GeneratedColumn<int> qualityScore = GeneratedColumn<int>(
      'quality_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> categories =
      GeneratedColumn<String>('categories', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($WorksTable.$convertercategories);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        subtitle,
        description,
        author,
        authorIds,
        subjectTags,
        synthetic,
        reviewStatus,
        workKey,
        provider,
        qualityScore,
        categories,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'works';
  @override
  VerificationContext validateIntegrity(Insertable<Work> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('synthetic')) {
      context.handle(_syntheticMeta,
          synthetic.isAcceptableOrUnknown(data['synthetic']!, _syntheticMeta));
    }
    if (data.containsKey('review_status')) {
      context.handle(
          _reviewStatusMeta,
          reviewStatus.isAcceptableOrUnknown(
              data['review_status']!, _reviewStatusMeta));
    }
    if (data.containsKey('work_key')) {
      context.handle(_workKeyMeta,
          workKey.isAcceptableOrUnknown(data['work_key']!, _workKeyMeta));
    }
    if (data.containsKey('quality_score')) {
      context.handle(
          _qualityScoreMeta,
          qualityScore.isAcceptableOrUnknown(
              data['quality_score']!, _qualityScoreMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Work map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Work(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subtitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subtitle']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author']),
      authorIds: $WorksTable.$converterauthorIds.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_ids'])!),
      subjectTags: $WorksTable.$convertersubjectTags.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_tags'])!),
      synthetic: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synthetic'])!,
      reviewStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_status']),
      workKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_key']),
      provider: $WorksTable.$converterprovider.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider'])),
      qualityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quality_score']),
      categories: $WorksTable.$convertercategories.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categories'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $WorksTable createAlias(String alias) {
    return $WorksTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterauthorIds =
      const ListConverter();
  static TypeConverter<List<String>, String> $convertersubjectTags =
      const ListConverter();
  static TypeConverter<DataProvider?, String?> $converterprovider =
      const DataProviderConverter();
  static TypeConverter<List<String>, String> $convertercategories =
      const ListConverter();
}

class Work extends DataClass implements Insertable<Work> {
  final String id;
  final String title;
  final String? subtitle;
  final String? description;
  final String? author;
  final List<String> authorIds;
  final List<String> subjectTags;
  final bool synthetic;
  final String? reviewStatus;
  final String? workKey;
  final DataProvider? provider;
  final int? qualityScore;
  final List<String> categories;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Work(
      {required this.id,
      required this.title,
      this.subtitle,
      this.description,
      this.author,
      required this.authorIds,
      required this.subjectTags,
      required this.synthetic,
      this.reviewStatus,
      this.workKey,
      this.provider,
      this.qualityScore,
      required this.categories,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    {
      map['author_ids'] =
          Variable<String>($WorksTable.$converterauthorIds.toSql(authorIds));
    }
    {
      map['subject_tags'] = Variable<String>(
          $WorksTable.$convertersubjectTags.toSql(subjectTags));
    }
    map['synthetic'] = Variable<bool>(synthetic);
    if (!nullToAbsent || reviewStatus != null) {
      map['review_status'] = Variable<String>(reviewStatus);
    }
    if (!nullToAbsent || workKey != null) {
      map['work_key'] = Variable<String>(workKey);
    }
    if (!nullToAbsent || provider != null) {
      map['provider'] =
          Variable<String>($WorksTable.$converterprovider.toSql(provider));
    }
    if (!nullToAbsent || qualityScore != null) {
      map['quality_score'] = Variable<int>(qualityScore);
    }
    {
      map['categories'] =
          Variable<String>($WorksTable.$convertercategories.toSql(categories));
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  WorksCompanion toCompanion(bool nullToAbsent) {
    return WorksCompanion(
      id: Value(id),
      title: Value(title),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      authorIds: Value(authorIds),
      subjectTags: Value(subjectTags),
      synthetic: Value(synthetic),
      reviewStatus: reviewStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewStatus),
      workKey: workKey == null && nullToAbsent
          ? const Value.absent()
          : Value(workKey),
      provider: provider == null && nullToAbsent
          ? const Value.absent()
          : Value(provider),
      qualityScore: qualityScore == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityScore),
      categories: Value(categories),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Work.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Work(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      description: serializer.fromJson<String?>(json['description']),
      author: serializer.fromJson<String?>(json['author']),
      authorIds: serializer.fromJson<List<String>>(json['authorIds']),
      subjectTags: serializer.fromJson<List<String>>(json['subjectTags']),
      synthetic: serializer.fromJson<bool>(json['synthetic']),
      reviewStatus: serializer.fromJson<String?>(json['reviewStatus']),
      workKey: serializer.fromJson<String?>(json['workKey']),
      provider: serializer.fromJson<DataProvider?>(json['provider']),
      qualityScore: serializer.fromJson<int?>(json['qualityScore']),
      categories: serializer.fromJson<List<String>>(json['categories']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String?>(subtitle),
      'description': serializer.toJson<String?>(description),
      'author': serializer.toJson<String?>(author),
      'authorIds': serializer.toJson<List<String>>(authorIds),
      'subjectTags': serializer.toJson<List<String>>(subjectTags),
      'synthetic': serializer.toJson<bool>(synthetic),
      'reviewStatus': serializer.toJson<String?>(reviewStatus),
      'workKey': serializer.toJson<String?>(workKey),
      'provider': serializer.toJson<DataProvider?>(provider),
      'qualityScore': serializer.toJson<int?>(qualityScore),
      'categories': serializer.toJson<List<String>>(categories),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Work copyWith(
          {String? id,
          String? title,
          Value<String?> subtitle = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> author = const Value.absent(),
          List<String>? authorIds,
          List<String>? subjectTags,
          bool? synthetic,
          Value<String?> reviewStatus = const Value.absent(),
          Value<String?> workKey = const Value.absent(),
          Value<DataProvider?> provider = const Value.absent(),
          Value<int?> qualityScore = const Value.absent(),
          List<String>? categories,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Work(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle.present ? subtitle.value : this.subtitle,
        description: description.present ? description.value : this.description,
        author: author.present ? author.value : this.author,
        authorIds: authorIds ?? this.authorIds,
        subjectTags: subjectTags ?? this.subjectTags,
        synthetic: synthetic ?? this.synthetic,
        reviewStatus:
            reviewStatus.present ? reviewStatus.value : this.reviewStatus,
        workKey: workKey.present ? workKey.value : this.workKey,
        provider: provider.present ? provider.value : this.provider,
        qualityScore:
            qualityScore.present ? qualityScore.value : this.qualityScore,
        categories: categories ?? this.categories,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Work copyWithCompanion(WorksCompanion data) {
    return Work(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      description:
          data.description.present ? data.description.value : this.description,
      author: data.author.present ? data.author.value : this.author,
      authorIds: data.authorIds.present ? data.authorIds.value : this.authorIds,
      subjectTags:
          data.subjectTags.present ? data.subjectTags.value : this.subjectTags,
      synthetic: data.synthetic.present ? data.synthetic.value : this.synthetic,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
      workKey: data.workKey.present ? data.workKey.value : this.workKey,
      provider: data.provider.present ? data.provider.value : this.provider,
      qualityScore: data.qualityScore.present
          ? data.qualityScore.value
          : this.qualityScore,
      categories:
          data.categories.present ? data.categories.value : this.categories,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Work(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('authorIds: $authorIds, ')
          ..write('subjectTags: $subjectTags, ')
          ..write('synthetic: $synthetic, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('workKey: $workKey, ')
          ..write('provider: $provider, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('categories: $categories, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      subtitle,
      description,
      author,
      authorIds,
      subjectTags,
      synthetic,
      reviewStatus,
      workKey,
      provider,
      qualityScore,
      categories,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Work &&
          other.id == this.id &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.description == this.description &&
          other.author == this.author &&
          other.authorIds == this.authorIds &&
          other.subjectTags == this.subjectTags &&
          other.synthetic == this.synthetic &&
          other.reviewStatus == this.reviewStatus &&
          other.workKey == this.workKey &&
          other.provider == this.provider &&
          other.qualityScore == this.qualityScore &&
          other.categories == this.categories &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorksCompanion extends UpdateCompanion<Work> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> subtitle;
  final Value<String?> description;
  final Value<String?> author;
  final Value<List<String>> authorIds;
  final Value<List<String>> subjectTags;
  final Value<bool> synthetic;
  final Value<String?> reviewStatus;
  final Value<String?> workKey;
  final Value<DataProvider?> provider;
  final Value<int?> qualityScore;
  final Value<List<String>> categories;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const WorksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.authorIds = const Value.absent(),
    this.subjectTags = const Value.absent(),
    this.synthetic = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.workKey = const Value.absent(),
    this.provider = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.categories = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorksCompanion.insert({
    required String id,
    required String title,
    this.subtitle = const Value.absent(),
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    required List<String> authorIds,
    required List<String> subjectTags,
    this.synthetic = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.workKey = const Value.absent(),
    this.provider = const Value.absent(),
    this.qualityScore = const Value.absent(),
    required List<String> categories,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        authorIds = Value(authorIds),
        subjectTags = Value(subjectTags),
        categories = Value(categories);
  static Insertable<Work> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? description,
    Expression<String>? author,
    Expression<String>? authorIds,
    Expression<String>? subjectTags,
    Expression<bool>? synthetic,
    Expression<String>? reviewStatus,
    Expression<String>? workKey,
    Expression<String>? provider,
    Expression<int>? qualityScore,
    Expression<String>? categories,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (description != null) 'description': description,
      if (author != null) 'author': author,
      if (authorIds != null) 'author_ids': authorIds,
      if (subjectTags != null) 'subject_tags': subjectTags,
      if (synthetic != null) 'synthetic': synthetic,
      if (reviewStatus != null) 'review_status': reviewStatus,
      if (workKey != null) 'work_key': workKey,
      if (provider != null) 'provider': provider,
      if (qualityScore != null) 'quality_score': qualityScore,
      if (categories != null) 'categories': categories,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorksCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? subtitle,
      Value<String?>? description,
      Value<String?>? author,
      Value<List<String>>? authorIds,
      Value<List<String>>? subjectTags,
      Value<bool>? synthetic,
      Value<String?>? reviewStatus,
      Value<String?>? workKey,
      Value<DataProvider?>? provider,
      Value<int?>? qualityScore,
      Value<List<String>>? categories,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return WorksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      author: author ?? this.author,
      authorIds: authorIds ?? this.authorIds,
      subjectTags: subjectTags ?? this.subjectTags,
      synthetic: synthetic ?? this.synthetic,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      workKey: workKey ?? this.workKey,
      provider: provider ?? this.provider,
      qualityScore: qualityScore ?? this.qualityScore,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (authorIds.present) {
      map['author_ids'] = Variable<String>(
          $WorksTable.$converterauthorIds.toSql(authorIds.value));
    }
    if (subjectTags.present) {
      map['subject_tags'] = Variable<String>(
          $WorksTable.$convertersubjectTags.toSql(subjectTags.value));
    }
    if (synthetic.present) {
      map['synthetic'] = Variable<bool>(synthetic.value);
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<String>(reviewStatus.value);
    }
    if (workKey.present) {
      map['work_key'] = Variable<String>(workKey.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(
          $WorksTable.$converterprovider.toSql(provider.value));
    }
    if (qualityScore.present) {
      map['quality_score'] = Variable<int>(qualityScore.value);
    }
    if (categories.present) {
      map['categories'] = Variable<String>(
          $WorksTable.$convertercategories.toSql(categories.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('authorIds: $authorIds, ')
          ..write('subjectTags: $subjectTags, ')
          ..write('synthetic: $synthetic, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('workKey: $workKey, ')
          ..write('provider: $provider, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('categories: $categories, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EditionsTable extends Editions with TableInfo<$EditionsTable, Edition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EditionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES works (id)'));
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
      'isbn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isbn10Meta = const VerificationMeta('isbn10');
  @override
  late final GeneratedColumn<String> isbn10 = GeneratedColumn<String>(
      'isbn10', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isbn13Meta = const VerificationMeta('isbn13');
  @override
  late final GeneratedColumn<String> isbn13 = GeneratedColumn<String>(
      'isbn13', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtitleMeta =
      const VerificationMeta('subtitle');
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
      'subtitle', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publisherMeta =
      const VerificationMeta('publisher');
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
      'publisher', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publishedYearMeta =
      const VerificationMeta('publishedYear');
  @override
  late final GeneratedColumn<int> publishedYear = GeneratedColumn<int>(
      'published_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _coverImageURLMeta =
      const VerificationMeta('coverImageURL');
  @override
  late final GeneratedColumn<String> coverImageURL = GeneratedColumn<String>(
      'cover_image_u_r_l', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thumbnailURLMeta =
      const VerificationMeta('thumbnailURL');
  @override
  late final GeneratedColumn<String> thumbnailURL = GeneratedColumn<String>(
      'thumbnail_u_r_l', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
      'format', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pageCountMeta =
      const VerificationMeta('pageCount');
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
      'page_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _editionKeyMeta =
      const VerificationMeta('editionKey');
  @override
  late final GeneratedColumn<String> editionKey = GeneratedColumn<String>(
      'edition_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> categories =
      GeneratedColumn<String>('categories', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($EditionsTable.$convertercategories);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workId,
        isbn,
        isbn10,
        isbn13,
        subtitle,
        publisher,
        publishedYear,
        coverImageURL,
        thumbnailURL,
        description,
        format,
        pageCount,
        language,
        editionKey,
        categories,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'editions';
  @override
  VerificationContext validateIntegrity(Insertable<Edition> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('isbn')) {
      context.handle(
          _isbnMeta, isbn.isAcceptableOrUnknown(data['isbn']!, _isbnMeta));
    }
    if (data.containsKey('isbn10')) {
      context.handle(_isbn10Meta,
          isbn10.isAcceptableOrUnknown(data['isbn10']!, _isbn10Meta));
    }
    if (data.containsKey('isbn13')) {
      context.handle(_isbn13Meta,
          isbn13.isAcceptableOrUnknown(data['isbn13']!, _isbn13Meta));
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta));
    }
    if (data.containsKey('publisher')) {
      context.handle(_publisherMeta,
          publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta));
    }
    if (data.containsKey('published_year')) {
      context.handle(
          _publishedYearMeta,
          publishedYear.isAcceptableOrUnknown(
              data['published_year']!, _publishedYearMeta));
    }
    if (data.containsKey('cover_image_u_r_l')) {
      context.handle(
          _coverImageURLMeta,
          coverImageURL.isAcceptableOrUnknown(
              data['cover_image_u_r_l']!, _coverImageURLMeta));
    }
    if (data.containsKey('thumbnail_u_r_l')) {
      context.handle(
          _thumbnailURLMeta,
          thumbnailURL.isAcceptableOrUnknown(
              data['thumbnail_u_r_l']!, _thumbnailURLMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    }
    if (data.containsKey('page_count')) {
      context.handle(_pageCountMeta,
          pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('edition_key')) {
      context.handle(
          _editionKeyMeta,
          editionKey.isAcceptableOrUnknown(
              data['edition_key']!, _editionKeyMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Edition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Edition(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      isbn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isbn']),
      isbn10: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isbn10']),
      isbn13: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isbn13']),
      subtitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subtitle']),
      publisher: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}publisher']),
      publishedYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}published_year']),
      coverImageURL: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cover_image_u_r_l']),
      thumbnailURL: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail_u_r_l']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format']),
      pageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_count']),
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language']),
      editionKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}edition_key']),
      categories: $EditionsTable.$convertercategories.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categories'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $EditionsTable createAlias(String alias) {
    return $EditionsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertercategories =
      const ListConverter();
}

class Edition extends DataClass implements Insertable<Edition> {
  final String id;
  final String workId;
  final String? isbn;
  final String? isbn10;
  final String? isbn13;
  final String? subtitle;
  final String? publisher;
  final int? publishedYear;
  final String? coverImageURL;
  final String? thumbnailURL;
  final String? description;
  final String? format;
  final int? pageCount;
  final String? language;
  final String? editionKey;
  final List<String> categories;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Edition(
      {required this.id,
      required this.workId,
      this.isbn,
      this.isbn10,
      this.isbn13,
      this.subtitle,
      this.publisher,
      this.publishedYear,
      this.coverImageURL,
      this.thumbnailURL,
      this.description,
      this.format,
      this.pageCount,
      this.language,
      this.editionKey,
      required this.categories,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    if (!nullToAbsent || isbn != null) {
      map['isbn'] = Variable<String>(isbn);
    }
    if (!nullToAbsent || isbn10 != null) {
      map['isbn10'] = Variable<String>(isbn10);
    }
    if (!nullToAbsent || isbn13 != null) {
      map['isbn13'] = Variable<String>(isbn13);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || publishedYear != null) {
      map['published_year'] = Variable<int>(publishedYear);
    }
    if (!nullToAbsent || coverImageURL != null) {
      map['cover_image_u_r_l'] = Variable<String>(coverImageURL);
    }
    if (!nullToAbsent || thumbnailURL != null) {
      map['thumbnail_u_r_l'] = Variable<String>(thumbnailURL);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || format != null) {
      map['format'] = Variable<String>(format);
    }
    if (!nullToAbsent || pageCount != null) {
      map['page_count'] = Variable<int>(pageCount);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    if (!nullToAbsent || editionKey != null) {
      map['edition_key'] = Variable<String>(editionKey);
    }
    {
      map['categories'] = Variable<String>(
          $EditionsTable.$convertercategories.toSql(categories));
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  EditionsCompanion toCompanion(bool nullToAbsent) {
    return EditionsCompanion(
      id: Value(id),
      workId: Value(workId),
      isbn: isbn == null && nullToAbsent ? const Value.absent() : Value(isbn),
      isbn10:
          isbn10 == null && nullToAbsent ? const Value.absent() : Value(isbn10),
      isbn13:
          isbn13 == null && nullToAbsent ? const Value.absent() : Value(isbn13),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      publisher: publisher == null && nullToAbsent
          ? const Value.absent()
          : Value(publisher),
      publishedYear: publishedYear == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedYear),
      coverImageURL: coverImageURL == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImageURL),
      thumbnailURL: thumbnailURL == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailURL),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      format:
          format == null && nullToAbsent ? const Value.absent() : Value(format),
      pageCount: pageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(pageCount),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      editionKey: editionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(editionKey),
      categories: Value(categories),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Edition.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Edition(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      isbn: serializer.fromJson<String?>(json['isbn']),
      isbn10: serializer.fromJson<String?>(json['isbn10']),
      isbn13: serializer.fromJson<String?>(json['isbn13']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      publishedYear: serializer.fromJson<int?>(json['publishedYear']),
      coverImageURL: serializer.fromJson<String?>(json['coverImageURL']),
      thumbnailURL: serializer.fromJson<String?>(json['thumbnailURL']),
      description: serializer.fromJson<String?>(json['description']),
      format: serializer.fromJson<String?>(json['format']),
      pageCount: serializer.fromJson<int?>(json['pageCount']),
      language: serializer.fromJson<String?>(json['language']),
      editionKey: serializer.fromJson<String?>(json['editionKey']),
      categories: serializer.fromJson<List<String>>(json['categories']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'isbn': serializer.toJson<String?>(isbn),
      'isbn10': serializer.toJson<String?>(isbn10),
      'isbn13': serializer.toJson<String?>(isbn13),
      'subtitle': serializer.toJson<String?>(subtitle),
      'publisher': serializer.toJson<String?>(publisher),
      'publishedYear': serializer.toJson<int?>(publishedYear),
      'coverImageURL': serializer.toJson<String?>(coverImageURL),
      'thumbnailURL': serializer.toJson<String?>(thumbnailURL),
      'description': serializer.toJson<String?>(description),
      'format': serializer.toJson<String?>(format),
      'pageCount': serializer.toJson<int?>(pageCount),
      'language': serializer.toJson<String?>(language),
      'editionKey': serializer.toJson<String?>(editionKey),
      'categories': serializer.toJson<List<String>>(categories),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Edition copyWith(
          {String? id,
          String? workId,
          Value<String?> isbn = const Value.absent(),
          Value<String?> isbn10 = const Value.absent(),
          Value<String?> isbn13 = const Value.absent(),
          Value<String?> subtitle = const Value.absent(),
          Value<String?> publisher = const Value.absent(),
          Value<int?> publishedYear = const Value.absent(),
          Value<String?> coverImageURL = const Value.absent(),
          Value<String?> thumbnailURL = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> format = const Value.absent(),
          Value<int?> pageCount = const Value.absent(),
          Value<String?> language = const Value.absent(),
          Value<String?> editionKey = const Value.absent(),
          List<String>? categories,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Edition(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        isbn: isbn.present ? isbn.value : this.isbn,
        isbn10: isbn10.present ? isbn10.value : this.isbn10,
        isbn13: isbn13.present ? isbn13.value : this.isbn13,
        subtitle: subtitle.present ? subtitle.value : this.subtitle,
        publisher: publisher.present ? publisher.value : this.publisher,
        publishedYear:
            publishedYear.present ? publishedYear.value : this.publishedYear,
        coverImageURL:
            coverImageURL.present ? coverImageURL.value : this.coverImageURL,
        thumbnailURL:
            thumbnailURL.present ? thumbnailURL.value : this.thumbnailURL,
        description: description.present ? description.value : this.description,
        format: format.present ? format.value : this.format,
        pageCount: pageCount.present ? pageCount.value : this.pageCount,
        language: language.present ? language.value : this.language,
        editionKey: editionKey.present ? editionKey.value : this.editionKey,
        categories: categories ?? this.categories,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Edition copyWithCompanion(EditionsCompanion data) {
    return Edition(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      isbn: data.isbn.present ? data.isbn.value : this.isbn,
      isbn10: data.isbn10.present ? data.isbn10.value : this.isbn10,
      isbn13: data.isbn13.present ? data.isbn13.value : this.isbn13,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      publishedYear: data.publishedYear.present
          ? data.publishedYear.value
          : this.publishedYear,
      coverImageURL: data.coverImageURL.present
          ? data.coverImageURL.value
          : this.coverImageURL,
      thumbnailURL: data.thumbnailURL.present
          ? data.thumbnailURL.value
          : this.thumbnailURL,
      description:
          data.description.present ? data.description.value : this.description,
      format: data.format.present ? data.format.value : this.format,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      language: data.language.present ? data.language.value : this.language,
      editionKey:
          data.editionKey.present ? data.editionKey.value : this.editionKey,
      categories:
          data.categories.present ? data.categories.value : this.categories,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Edition(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('isbn: $isbn, ')
          ..write('isbn10: $isbn10, ')
          ..write('isbn13: $isbn13, ')
          ..write('subtitle: $subtitle, ')
          ..write('publisher: $publisher, ')
          ..write('publishedYear: $publishedYear, ')
          ..write('coverImageURL: $coverImageURL, ')
          ..write('thumbnailURL: $thumbnailURL, ')
          ..write('description: $description, ')
          ..write('format: $format, ')
          ..write('pageCount: $pageCount, ')
          ..write('language: $language, ')
          ..write('editionKey: $editionKey, ')
          ..write('categories: $categories, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      workId,
      isbn,
      isbn10,
      isbn13,
      subtitle,
      publisher,
      publishedYear,
      coverImageURL,
      thumbnailURL,
      description,
      format,
      pageCount,
      language,
      editionKey,
      categories,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Edition &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.isbn == this.isbn &&
          other.isbn10 == this.isbn10 &&
          other.isbn13 == this.isbn13 &&
          other.subtitle == this.subtitle &&
          other.publisher == this.publisher &&
          other.publishedYear == this.publishedYear &&
          other.coverImageURL == this.coverImageURL &&
          other.thumbnailURL == this.thumbnailURL &&
          other.description == this.description &&
          other.format == this.format &&
          other.pageCount == this.pageCount &&
          other.language == this.language &&
          other.editionKey == this.editionKey &&
          other.categories == this.categories &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EditionsCompanion extends UpdateCompanion<Edition> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String?> isbn;
  final Value<String?> isbn10;
  final Value<String?> isbn13;
  final Value<String?> subtitle;
  final Value<String?> publisher;
  final Value<int?> publishedYear;
  final Value<String?> coverImageURL;
  final Value<String?> thumbnailURL;
  final Value<String?> description;
  final Value<String?> format;
  final Value<int?> pageCount;
  final Value<String?> language;
  final Value<String?> editionKey;
  final Value<List<String>> categories;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const EditionsCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.isbn = const Value.absent(),
    this.isbn10 = const Value.absent(),
    this.isbn13 = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedYear = const Value.absent(),
    this.coverImageURL = const Value.absent(),
    this.thumbnailURL = const Value.absent(),
    this.description = const Value.absent(),
    this.format = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.language = const Value.absent(),
    this.editionKey = const Value.absent(),
    this.categories = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EditionsCompanion.insert({
    required String id,
    required String workId,
    this.isbn = const Value.absent(),
    this.isbn10 = const Value.absent(),
    this.isbn13 = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedYear = const Value.absent(),
    this.coverImageURL = const Value.absent(),
    this.thumbnailURL = const Value.absent(),
    this.description = const Value.absent(),
    this.format = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.language = const Value.absent(),
    this.editionKey = const Value.absent(),
    required List<String> categories,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        categories = Value(categories);
  static Insertable<Edition> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? isbn,
    Expression<String>? isbn10,
    Expression<String>? isbn13,
    Expression<String>? subtitle,
    Expression<String>? publisher,
    Expression<int>? publishedYear,
    Expression<String>? coverImageURL,
    Expression<String>? thumbnailURL,
    Expression<String>? description,
    Expression<String>? format,
    Expression<int>? pageCount,
    Expression<String>? language,
    Expression<String>? editionKey,
    Expression<String>? categories,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (isbn != null) 'isbn': isbn,
      if (isbn10 != null) 'isbn10': isbn10,
      if (isbn13 != null) 'isbn13': isbn13,
      if (subtitle != null) 'subtitle': subtitle,
      if (publisher != null) 'publisher': publisher,
      if (publishedYear != null) 'published_year': publishedYear,
      if (coverImageURL != null) 'cover_image_u_r_l': coverImageURL,
      if (thumbnailURL != null) 'thumbnail_u_r_l': thumbnailURL,
      if (description != null) 'description': description,
      if (format != null) 'format': format,
      if (pageCount != null) 'page_count': pageCount,
      if (language != null) 'language': language,
      if (editionKey != null) 'edition_key': editionKey,
      if (categories != null) 'categories': categories,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EditionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String?>? isbn,
      Value<String?>? isbn10,
      Value<String?>? isbn13,
      Value<String?>? subtitle,
      Value<String?>? publisher,
      Value<int?>? publishedYear,
      Value<String?>? coverImageURL,
      Value<String?>? thumbnailURL,
      Value<String?>? description,
      Value<String?>? format,
      Value<int?>? pageCount,
      Value<String?>? language,
      Value<String?>? editionKey,
      Value<List<String>>? categories,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return EditionsCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      isbn: isbn ?? this.isbn,
      isbn10: isbn10 ?? this.isbn10,
      isbn13: isbn13 ?? this.isbn13,
      subtitle: subtitle ?? this.subtitle,
      publisher: publisher ?? this.publisher,
      publishedYear: publishedYear ?? this.publishedYear,
      coverImageURL: coverImageURL ?? this.coverImageURL,
      thumbnailURL: thumbnailURL ?? this.thumbnailURL,
      description: description ?? this.description,
      format: format ?? this.format,
      pageCount: pageCount ?? this.pageCount,
      language: language ?? this.language,
      editionKey: editionKey ?? this.editionKey,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (isbn.present) {
      map['isbn'] = Variable<String>(isbn.value);
    }
    if (isbn10.present) {
      map['isbn10'] = Variable<String>(isbn10.value);
    }
    if (isbn13.present) {
      map['isbn13'] = Variable<String>(isbn13.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (publishedYear.present) {
      map['published_year'] = Variable<int>(publishedYear.value);
    }
    if (coverImageURL.present) {
      map['cover_image_u_r_l'] = Variable<String>(coverImageURL.value);
    }
    if (thumbnailURL.present) {
      map['thumbnail_u_r_l'] = Variable<String>(thumbnailURL.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (editionKey.present) {
      map['edition_key'] = Variable<String>(editionKey.value);
    }
    if (categories.present) {
      map['categories'] = Variable<String>(
          $EditionsTable.$convertercategories.toSql(categories.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EditionsCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('isbn: $isbn, ')
          ..write('isbn10: $isbn10, ')
          ..write('isbn13: $isbn13, ')
          ..write('subtitle: $subtitle, ')
          ..write('publisher: $publisher, ')
          ..write('publishedYear: $publishedYear, ')
          ..write('coverImageURL: $coverImageURL, ')
          ..write('thumbnailURL: $thumbnailURL, ')
          ..write('description: $description, ')
          ..write('format: $format, ')
          ..write('pageCount: $pageCount, ')
          ..write('language: $language, ')
          ..write('editionKey: $editionKey, ')
          ..write('categories: $categories, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuthorsTable extends Authors with TableInfo<$AuthorsTable, Author> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _culturalRegionMeta =
      const VerificationMeta('culturalRegion');
  @override
  late final GeneratedColumn<String> culturalRegion = GeneratedColumn<String>(
      'cultural_region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _openLibraryIdMeta =
      const VerificationMeta('openLibraryId');
  @override
  late final GeneratedColumn<String> openLibraryId = GeneratedColumn<String>(
      'open_library_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _goodreadsIdMeta =
      const VerificationMeta('goodreadsId');
  @override
  late final GeneratedColumn<String> goodreadsId = GeneratedColumn<String>(
      'goodreads_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        gender,
        culturalRegion,
        openLibraryId,
        goodreadsId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'authors';
  @override
  VerificationContext validateIntegrity(Insertable<Author> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('cultural_region')) {
      context.handle(
          _culturalRegionMeta,
          culturalRegion.isAcceptableOrUnknown(
              data['cultural_region']!, _culturalRegionMeta));
    }
    if (data.containsKey('open_library_id')) {
      context.handle(
          _openLibraryIdMeta,
          openLibraryId.isAcceptableOrUnknown(
              data['open_library_id']!, _openLibraryIdMeta));
    }
    if (data.containsKey('goodreads_id')) {
      context.handle(
          _goodreadsIdMeta,
          goodreadsId.isAcceptableOrUnknown(
              data['goodreads_id']!, _goodreadsIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Author map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Author(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      culturalRegion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cultural_region']),
      openLibraryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}open_library_id']),
      goodreadsId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goodreads_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $AuthorsTable createAlias(String alias) {
    return $AuthorsTable(attachedDatabase, alias);
  }
}

class Author extends DataClass implements Insertable<Author> {
  final String id;
  final String name;
  final String? gender;
  final String? culturalRegion;
  final String? openLibraryId;
  final String? goodreadsId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Author(
      {required this.id,
      required this.name,
      this.gender,
      this.culturalRegion,
      this.openLibraryId,
      this.goodreadsId,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || culturalRegion != null) {
      map['cultural_region'] = Variable<String>(culturalRegion);
    }
    if (!nullToAbsent || openLibraryId != null) {
      map['open_library_id'] = Variable<String>(openLibraryId);
    }
    if (!nullToAbsent || goodreadsId != null) {
      map['goodreads_id'] = Variable<String>(goodreadsId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  AuthorsCompanion toCompanion(bool nullToAbsent) {
    return AuthorsCompanion(
      id: Value(id),
      name: Value(name),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      culturalRegion: culturalRegion == null && nullToAbsent
          ? const Value.absent()
          : Value(culturalRegion),
      openLibraryId: openLibraryId == null && nullToAbsent
          ? const Value.absent()
          : Value(openLibraryId),
      goodreadsId: goodreadsId == null && nullToAbsent
          ? const Value.absent()
          : Value(goodreadsId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Author.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Author(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      gender: serializer.fromJson<String?>(json['gender']),
      culturalRegion: serializer.fromJson<String?>(json['culturalRegion']),
      openLibraryId: serializer.fromJson<String?>(json['openLibraryId']),
      goodreadsId: serializer.fromJson<String?>(json['goodreadsId']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<String?>(gender),
      'culturalRegion': serializer.toJson<String?>(culturalRegion),
      'openLibraryId': serializer.toJson<String?>(openLibraryId),
      'goodreadsId': serializer.toJson<String?>(goodreadsId),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Author copyWith(
          {String? id,
          String? name,
          Value<String?> gender = const Value.absent(),
          Value<String?> culturalRegion = const Value.absent(),
          Value<String?> openLibraryId = const Value.absent(),
          Value<String?> goodreadsId = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Author(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender.present ? gender.value : this.gender,
        culturalRegion:
            culturalRegion.present ? culturalRegion.value : this.culturalRegion,
        openLibraryId:
            openLibraryId.present ? openLibraryId.value : this.openLibraryId,
        goodreadsId: goodreadsId.present ? goodreadsId.value : this.goodreadsId,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Author copyWithCompanion(AuthorsCompanion data) {
    return Author(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      culturalRegion: data.culturalRegion.present
          ? data.culturalRegion.value
          : this.culturalRegion,
      openLibraryId: data.openLibraryId.present
          ? data.openLibraryId.value
          : this.openLibraryId,
      goodreadsId:
          data.goodreadsId.present ? data.goodreadsId.value : this.goodreadsId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Author(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('culturalRegion: $culturalRegion, ')
          ..write('openLibraryId: $openLibraryId, ')
          ..write('goodreadsId: $goodreadsId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, gender, culturalRegion,
      openLibraryId, goodreadsId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Author &&
          other.id == this.id &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.culturalRegion == this.culturalRegion &&
          other.openLibraryId == this.openLibraryId &&
          other.goodreadsId == this.goodreadsId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AuthorsCompanion extends UpdateCompanion<Author> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> gender;
  final Value<String?> culturalRegion;
  final Value<String?> openLibraryId;
  final Value<String?> goodreadsId;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const AuthorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.culturalRegion = const Value.absent(),
    this.openLibraryId = const Value.absent(),
    this.goodreadsId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthorsCompanion.insert({
    required String id,
    required String name,
    this.gender = const Value.absent(),
    this.culturalRegion = const Value.absent(),
    this.openLibraryId = const Value.absent(),
    this.goodreadsId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Author> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? gender,
    Expression<String>? culturalRegion,
    Expression<String>? openLibraryId,
    Expression<String>? goodreadsId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (culturalRegion != null) 'cultural_region': culturalRegion,
      if (openLibraryId != null) 'open_library_id': openLibraryId,
      if (goodreadsId != null) 'goodreads_id': goodreadsId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthorsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? gender,
      Value<String?>? culturalRegion,
      Value<String?>? openLibraryId,
      Value<String?>? goodreadsId,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return AuthorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      culturalRegion: culturalRegion ?? this.culturalRegion,
      openLibraryId: openLibraryId ?? this.openLibraryId,
      goodreadsId: goodreadsId ?? this.goodreadsId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (culturalRegion.present) {
      map['cultural_region'] = Variable<String>(culturalRegion.value);
    }
    if (openLibraryId.present) {
      map['open_library_id'] = Variable<String>(openLibraryId.value);
    }
    if (goodreadsId.present) {
      map['goodreads_id'] = Variable<String>(goodreadsId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('culturalRegion: $culturalRegion, ')
          ..write('openLibraryId: $openLibraryId, ')
          ..write('goodreadsId: $goodreadsId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkAuthorsTable extends WorkAuthors
    with TableInfo<$WorkAuthorsTable, WorkAuthor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkAuthorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES works (id)'));
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
      'author_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES authors (id)'));
  @override
  List<GeneratedColumn> get $columns => [workId, authorId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_authors';
  @override
  VerificationContext validateIntegrity(Insertable<WorkAuthor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workId, authorId};
  @override
  WorkAuthor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkAuthor(
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_id'])!,
    );
  }

  @override
  $WorkAuthorsTable createAlias(String alias) {
    return $WorkAuthorsTable(attachedDatabase, alias);
  }
}

class WorkAuthor extends DataClass implements Insertable<WorkAuthor> {
  final String workId;
  final String authorId;
  const WorkAuthor({required this.workId, required this.authorId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['work_id'] = Variable<String>(workId);
    map['author_id'] = Variable<String>(authorId);
    return map;
  }

  WorkAuthorsCompanion toCompanion(bool nullToAbsent) {
    return WorkAuthorsCompanion(
      workId: Value(workId),
      authorId: Value(authorId),
    );
  }

  factory WorkAuthor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkAuthor(
      workId: serializer.fromJson<String>(json['workId']),
      authorId: serializer.fromJson<String>(json['authorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'authorId': serializer.toJson<String>(authorId),
    };
  }

  WorkAuthor copyWith({String? workId, String? authorId}) => WorkAuthor(
        workId: workId ?? this.workId,
        authorId: authorId ?? this.authorId,
      );
  WorkAuthor copyWithCompanion(WorkAuthorsCompanion data) {
    return WorkAuthor(
      workId: data.workId.present ? data.workId.value : this.workId,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkAuthor(')
          ..write('workId: $workId, ')
          ..write('authorId: $authorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, authorId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkAuthor &&
          other.workId == this.workId &&
          other.authorId == this.authorId);
}

class WorkAuthorsCompanion extends UpdateCompanion<WorkAuthor> {
  final Value<String> workId;
  final Value<String> authorId;
  final Value<int> rowid;
  const WorkAuthorsCompanion({
    this.workId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkAuthorsCompanion.insert({
    required String workId,
    required String authorId,
    this.rowid = const Value.absent(),
  })  : workId = Value(workId),
        authorId = Value(authorId);
  static Insertable<WorkAuthor> custom({
    Expression<String>? workId,
    Expression<String>? authorId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'work_id': workId,
      if (authorId != null) 'author_id': authorId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkAuthorsCompanion copyWith(
      {Value<String>? workId, Value<String>? authorId, Value<int>? rowid}) {
    return WorkAuthorsCompanion(
      workId: workId ?? this.workId,
      authorId: authorId ?? this.authorId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkAuthorsCompanion(')
          ..write('workId: $workId, ')
          ..write('authorId: $authorId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserLibraryEntriesTable extends UserLibraryEntries
    with TableInfo<$UserLibraryEntriesTable, UserLibraryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserLibraryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES works (id)'));
  static const VerificationMeta _editionIdMeta =
      const VerificationMeta('editionId');
  @override
  late final GeneratedColumn<String> editionId = GeneratedColumn<String>(
      'edition_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES editions (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<ReadingStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ReadingStatus>(
              $UserLibraryEntriesTable.$converterstatus);
  static const VerificationMeta _currentPageMeta =
      const VerificationMeta('currentPage');
  @override
  late final GeneratedColumn<int> currentPage = GeneratedColumn<int>(
      'current_page', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _personalRatingMeta =
      const VerificationMeta('personalRating');
  @override
  late final GeneratedColumn<int> personalRating = GeneratedColumn<int>(
      'personal_rating', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workId,
        editionId,
        status,
        currentPage,
        personalRating,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_library_entries';
  @override
  VerificationContext validateIntegrity(Insertable<UserLibraryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('edition_id')) {
      context.handle(_editionIdMeta,
          editionId.isAcceptableOrUnknown(data['edition_id']!, _editionIdMeta));
    }
    if (data.containsKey('current_page')) {
      context.handle(
          _currentPageMeta,
          currentPage.isAcceptableOrUnknown(
              data['current_page']!, _currentPageMeta));
    }
    if (data.containsKey('personal_rating')) {
      context.handle(
          _personalRatingMeta,
          personalRating.isAcceptableOrUnknown(
              data['personal_rating']!, _personalRatingMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserLibraryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserLibraryEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      editionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}edition_id']),
      status: $UserLibraryEntriesTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      currentPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_page']),
      personalRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}personal_rating']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $UserLibraryEntriesTable createAlias(String alias) {
    return $UserLibraryEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReadingStatus, int, int> $converterstatus =
      const EnumIndexConverter<ReadingStatus>(ReadingStatus.values);
}

class UserLibraryEntry extends DataClass
    implements Insertable<UserLibraryEntry> {
  final String id;
  final String workId;
  final String? editionId;
  final ReadingStatus status;
  final int? currentPage;
  final int? personalRating;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const UserLibraryEntry(
      {required this.id,
      required this.workId,
      this.editionId,
      required this.status,
      this.currentPage,
      this.personalRating,
      this.notes,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    if (!nullToAbsent || editionId != null) {
      map['edition_id'] = Variable<String>(editionId);
    }
    {
      map['status'] = Variable<int>(
          $UserLibraryEntriesTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || currentPage != null) {
      map['current_page'] = Variable<int>(currentPage);
    }
    if (!nullToAbsent || personalRating != null) {
      map['personal_rating'] = Variable<int>(personalRating);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  UserLibraryEntriesCompanion toCompanion(bool nullToAbsent) {
    return UserLibraryEntriesCompanion(
      id: Value(id),
      workId: Value(workId),
      editionId: editionId == null && nullToAbsent
          ? const Value.absent()
          : Value(editionId),
      status: Value(status),
      currentPage: currentPage == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPage),
      personalRating: personalRating == null && nullToAbsent
          ? const Value.absent()
          : Value(personalRating),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory UserLibraryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserLibraryEntry(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      editionId: serializer.fromJson<String?>(json['editionId']),
      status: $UserLibraryEntriesTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      currentPage: serializer.fromJson<int?>(json['currentPage']),
      personalRating: serializer.fromJson<int?>(json['personalRating']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'editionId': serializer.toJson<String?>(editionId),
      'status': serializer.toJson<int>(
          $UserLibraryEntriesTable.$converterstatus.toJson(status)),
      'currentPage': serializer.toJson<int?>(currentPage),
      'personalRating': serializer.toJson<int?>(personalRating),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  UserLibraryEntry copyWith(
          {String? id,
          String? workId,
          Value<String?> editionId = const Value.absent(),
          ReadingStatus? status,
          Value<int?> currentPage = const Value.absent(),
          Value<int?> personalRating = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      UserLibraryEntry(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        editionId: editionId.present ? editionId.value : this.editionId,
        status: status ?? this.status,
        currentPage: currentPage.present ? currentPage.value : this.currentPage,
        personalRating:
            personalRating.present ? personalRating.value : this.personalRating,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  UserLibraryEntry copyWithCompanion(UserLibraryEntriesCompanion data) {
    return UserLibraryEntry(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      editionId: data.editionId.present ? data.editionId.value : this.editionId,
      status: data.status.present ? data.status.value : this.status,
      currentPage:
          data.currentPage.present ? data.currentPage.value : this.currentPage,
      personalRating: data.personalRating.present
          ? data.personalRating.value
          : this.personalRating,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserLibraryEntry(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('editionId: $editionId, ')
          ..write('status: $status, ')
          ..write('currentPage: $currentPage, ')
          ..write('personalRating: $personalRating, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workId, editionId, status, currentPage,
      personalRating, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLibraryEntry &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.editionId == this.editionId &&
          other.status == this.status &&
          other.currentPage == this.currentPage &&
          other.personalRating == this.personalRating &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserLibraryEntriesCompanion extends UpdateCompanion<UserLibraryEntry> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String?> editionId;
  final Value<ReadingStatus> status;
  final Value<int?> currentPage;
  final Value<int?> personalRating;
  final Value<String?> notes;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const UserLibraryEntriesCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.editionId = const Value.absent(),
    this.status = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.personalRating = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserLibraryEntriesCompanion.insert({
    required String id,
    required String workId,
    this.editionId = const Value.absent(),
    required ReadingStatus status,
    this.currentPage = const Value.absent(),
    this.personalRating = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        status = Value(status);
  static Insertable<UserLibraryEntry> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? editionId,
    Expression<int>? status,
    Expression<int>? currentPage,
    Expression<int>? personalRating,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (editionId != null) 'edition_id': editionId,
      if (status != null) 'status': status,
      if (currentPage != null) 'current_page': currentPage,
      if (personalRating != null) 'personal_rating': personalRating,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserLibraryEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String?>? editionId,
      Value<ReadingStatus>? status,
      Value<int?>? currentPage,
      Value<int?>? personalRating,
      Value<String?>? notes,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return UserLibraryEntriesCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      editionId: editionId ?? this.editionId,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      personalRating: personalRating ?? this.personalRating,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (editionId.present) {
      map['edition_id'] = Variable<String>(editionId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
          $UserLibraryEntriesTable.$converterstatus.toSql(status.value));
    }
    if (currentPage.present) {
      map['current_page'] = Variable<int>(currentPage.value);
    }
    if (personalRating.present) {
      map['personal_rating'] = Variable<int>(personalRating.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserLibraryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('editionId: $editionId, ')
          ..write('status: $status, ')
          ..write('currentPage: $currentPage, ')
          ..write('personalRating: $personalRating, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScanSessionsTable extends ScanSessions
    with TableInfo<$ScanSessionsTable, ScanSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalDetectedMeta =
      const VerificationMeta('totalDetected');
  @override
  late final GeneratedColumn<int> totalDetected = GeneratedColumn<int>(
      'total_detected', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _reviewedCountMeta =
      const VerificationMeta('reviewedCount');
  @override
  late final GeneratedColumn<int> reviewedCount = GeneratedColumn<int>(
      'reviewed_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _acceptedCountMeta =
      const VerificationMeta('acceptedCount');
  @override
  late final GeneratedColumn<int> acceptedCount = GeneratedColumn<int>(
      'accepted_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rejectedCountMeta =
      const VerificationMeta('rejectedCount');
  @override
  late final GeneratedColumn<int> rejectedCount = GeneratedColumn<int>(
      'rejected_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        totalDetected,
        reviewedCount,
        acceptedCount,
        rejectedCount,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<ScanSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('total_detected')) {
      context.handle(
          _totalDetectedMeta,
          totalDetected.isAcceptableOrUnknown(
              data['total_detected']!, _totalDetectedMeta));
    } else if (isInserting) {
      context.missing(_totalDetectedMeta);
    }
    if (data.containsKey('reviewed_count')) {
      context.handle(
          _reviewedCountMeta,
          reviewedCount.isAcceptableOrUnknown(
              data['reviewed_count']!, _reviewedCountMeta));
    }
    if (data.containsKey('accepted_count')) {
      context.handle(
          _acceptedCountMeta,
          acceptedCount.isAcceptableOrUnknown(
              data['accepted_count']!, _acceptedCountMeta));
    }
    if (data.containsKey('rejected_count')) {
      context.handle(
          _rejectedCountMeta,
          rejectedCount.isAcceptableOrUnknown(
              data['rejected_count']!, _rejectedCountMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      totalDetected: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_detected'])!,
      reviewedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reviewed_count'])!,
      acceptedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accepted_count'])!,
      rejectedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rejected_count'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ScanSessionsTable createAlias(String alias) {
    return $ScanSessionsTable(attachedDatabase, alias);
  }
}

class ScanSession extends DataClass implements Insertable<ScanSession> {
  final String id;
  final int totalDetected;
  final int reviewedCount;
  final int acceptedCount;
  final int rejectedCount;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const ScanSession(
      {required this.id,
      required this.totalDetected,
      required this.reviewedCount,
      required this.acceptedCount,
      required this.rejectedCount,
      required this.status,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['total_detected'] = Variable<int>(totalDetected);
    map['reviewed_count'] = Variable<int>(reviewedCount);
    map['accepted_count'] = Variable<int>(acceptedCount);
    map['rejected_count'] = Variable<int>(rejectedCount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ScanSessionsCompanion toCompanion(bool nullToAbsent) {
    return ScanSessionsCompanion(
      id: Value(id),
      totalDetected: Value(totalDetected),
      reviewedCount: Value(reviewedCount),
      acceptedCount: Value(acceptedCount),
      rejectedCount: Value(rejectedCount),
      status: Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ScanSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanSession(
      id: serializer.fromJson<String>(json['id']),
      totalDetected: serializer.fromJson<int>(json['totalDetected']),
      reviewedCount: serializer.fromJson<int>(json['reviewedCount']),
      acceptedCount: serializer.fromJson<int>(json['acceptedCount']),
      rejectedCount: serializer.fromJson<int>(json['rejectedCount']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'totalDetected': serializer.toJson<int>(totalDetected),
      'reviewedCount': serializer.toJson<int>(reviewedCount),
      'acceptedCount': serializer.toJson<int>(acceptedCount),
      'rejectedCount': serializer.toJson<int>(rejectedCount),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ScanSession copyWith(
          {String? id,
          int? totalDetected,
          int? reviewedCount,
          int? acceptedCount,
          int? rejectedCount,
          String? status,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ScanSession(
        id: id ?? this.id,
        totalDetected: totalDetected ?? this.totalDetected,
        reviewedCount: reviewedCount ?? this.reviewedCount,
        acceptedCount: acceptedCount ?? this.acceptedCount,
        rejectedCount: rejectedCount ?? this.rejectedCount,
        status: status ?? this.status,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ScanSession copyWithCompanion(ScanSessionsCompanion data) {
    return ScanSession(
      id: data.id.present ? data.id.value : this.id,
      totalDetected: data.totalDetected.present
          ? data.totalDetected.value
          : this.totalDetected,
      reviewedCount: data.reviewedCount.present
          ? data.reviewedCount.value
          : this.reviewedCount,
      acceptedCount: data.acceptedCount.present
          ? data.acceptedCount.value
          : this.acceptedCount,
      rejectedCount: data.rejectedCount.present
          ? data.rejectedCount.value
          : this.rejectedCount,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanSession(')
          ..write('id: $id, ')
          ..write('totalDetected: $totalDetected, ')
          ..write('reviewedCount: $reviewedCount, ')
          ..write('acceptedCount: $acceptedCount, ')
          ..write('rejectedCount: $rejectedCount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, totalDetected, reviewedCount,
      acceptedCount, rejectedCount, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanSession &&
          other.id == this.id &&
          other.totalDetected == this.totalDetected &&
          other.reviewedCount == this.reviewedCount &&
          other.acceptedCount == this.acceptedCount &&
          other.rejectedCount == this.rejectedCount &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScanSessionsCompanion extends UpdateCompanion<ScanSession> {
  final Value<String> id;
  final Value<int> totalDetected;
  final Value<int> reviewedCount;
  final Value<int> acceptedCount;
  final Value<int> rejectedCount;
  final Value<String> status;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ScanSessionsCompanion({
    this.id = const Value.absent(),
    this.totalDetected = const Value.absent(),
    this.reviewedCount = const Value.absent(),
    this.acceptedCount = const Value.absent(),
    this.rejectedCount = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScanSessionsCompanion.insert({
    required String id,
    required int totalDetected,
    this.reviewedCount = const Value.absent(),
    this.acceptedCount = const Value.absent(),
    this.rejectedCount = const Value.absent(),
    required String status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        totalDetected = Value(totalDetected),
        status = Value(status);
  static Insertable<ScanSession> custom({
    Expression<String>? id,
    Expression<int>? totalDetected,
    Expression<int>? reviewedCount,
    Expression<int>? acceptedCount,
    Expression<int>? rejectedCount,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalDetected != null) 'total_detected': totalDetected,
      if (reviewedCount != null) 'reviewed_count': reviewedCount,
      if (acceptedCount != null) 'accepted_count': acceptedCount,
      if (rejectedCount != null) 'rejected_count': rejectedCount,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScanSessionsCompanion copyWith(
      {Value<String>? id,
      Value<int>? totalDetected,
      Value<int>? reviewedCount,
      Value<int>? acceptedCount,
      Value<int>? rejectedCount,
      Value<String>? status,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ScanSessionsCompanion(
      id: id ?? this.id,
      totalDetected: totalDetected ?? this.totalDetected,
      reviewedCount: reviewedCount ?? this.reviewedCount,
      acceptedCount: acceptedCount ?? this.acceptedCount,
      rejectedCount: rejectedCount ?? this.rejectedCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (totalDetected.present) {
      map['total_detected'] = Variable<int>(totalDetected.value);
    }
    if (reviewedCount.present) {
      map['reviewed_count'] = Variable<int>(reviewedCount.value);
    }
    if (acceptedCount.present) {
      map['accepted_count'] = Variable<int>(acceptedCount.value);
    }
    if (rejectedCount.present) {
      map['rejected_count'] = Variable<int>(rejectedCount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanSessionsCompanion(')
          ..write('id: $id, ')
          ..write('totalDetected: $totalDetected, ')
          ..write('reviewedCount: $reviewedCount, ')
          ..write('acceptedCount: $acceptedCount, ')
          ..write('rejectedCount: $rejectedCount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DetectedItemsTable extends DetectedItems
    with TableInfo<$DetectedItemsTable, DetectedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetectedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES scan_sessions (id)'));
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES works (id)'));
  static const VerificationMeta _titleGuessMeta =
      const VerificationMeta('titleGuess');
  @override
  late final GeneratedColumn<String> titleGuess = GeneratedColumn<String>(
      'title_guess', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorGuessMeta =
      const VerificationMeta('authorGuess');
  @override
  late final GeneratedColumn<String> authorGuess = GeneratedColumn<String>(
      'author_guess', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _confidenceMeta =
      const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
      'confidence', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _boundingBoxMeta =
      const VerificationMeta('boundingBox');
  @override
  late final GeneratedColumn<String> boundingBox = GeneratedColumn<String>(
      'bounding_box', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reviewStatusMeta =
      const VerificationMeta('reviewStatus');
  @override
  late final GeneratedColumn<String> reviewStatus = GeneratedColumn<String>(
      'review_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        workId,
        titleGuess,
        authorGuess,
        confidence,
        imagePath,
        boundingBox,
        reviewStatus,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detected_items';
  @override
  VerificationContext validateIntegrity(Insertable<DetectedItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    }
    if (data.containsKey('title_guess')) {
      context.handle(
          _titleGuessMeta,
          titleGuess.isAcceptableOrUnknown(
              data['title_guess']!, _titleGuessMeta));
    } else if (isInserting) {
      context.missing(_titleGuessMeta);
    }
    if (data.containsKey('author_guess')) {
      context.handle(
          _authorGuessMeta,
          authorGuess.isAcceptableOrUnknown(
              data['author_guess']!, _authorGuessMeta));
    }
    if (data.containsKey('confidence')) {
      context.handle(
          _confidenceMeta,
          confidence.isAcceptableOrUnknown(
              data['confidence']!, _confidenceMeta));
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('bounding_box')) {
      context.handle(
          _boundingBoxMeta,
          boundingBox.isAcceptableOrUnknown(
              data['bounding_box']!, _boundingBoxMeta));
    }
    if (data.containsKey('review_status')) {
      context.handle(
          _reviewStatusMeta,
          reviewStatus.isAcceptableOrUnknown(
              data['review_status']!, _reviewStatusMeta));
    } else if (isInserting) {
      context.missing(_reviewStatusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetectedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetectedItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id']),
      titleGuess: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_guess'])!,
      authorGuess: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_guess']),
      confidence: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}confidence'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      boundingBox: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bounding_box']),
      reviewStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $DetectedItemsTable createAlias(String alias) {
    return $DetectedItemsTable(attachedDatabase, alias);
  }
}

class DetectedItem extends DataClass implements Insertable<DetectedItem> {
  final String id;
  final String sessionId;
  final String? workId;
  final String titleGuess;
  final String? authorGuess;
  final double confidence;
  final String imagePath;
  final String? boundingBox;
  final String reviewStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const DetectedItem(
      {required this.id,
      required this.sessionId,
      this.workId,
      required this.titleGuess,
      this.authorGuess,
      required this.confidence,
      required this.imagePath,
      this.boundingBox,
      required this.reviewStatus,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || workId != null) {
      map['work_id'] = Variable<String>(workId);
    }
    map['title_guess'] = Variable<String>(titleGuess);
    if (!nullToAbsent || authorGuess != null) {
      map['author_guess'] = Variable<String>(authorGuess);
    }
    map['confidence'] = Variable<double>(confidence);
    map['image_path'] = Variable<String>(imagePath);
    if (!nullToAbsent || boundingBox != null) {
      map['bounding_box'] = Variable<String>(boundingBox);
    }
    map['review_status'] = Variable<String>(reviewStatus);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  DetectedItemsCompanion toCompanion(bool nullToAbsent) {
    return DetectedItemsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      workId:
          workId == null && nullToAbsent ? const Value.absent() : Value(workId),
      titleGuess: Value(titleGuess),
      authorGuess: authorGuess == null && nullToAbsent
          ? const Value.absent()
          : Value(authorGuess),
      confidence: Value(confidence),
      imagePath: Value(imagePath),
      boundingBox: boundingBox == null && nullToAbsent
          ? const Value.absent()
          : Value(boundingBox),
      reviewStatus: Value(reviewStatus),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DetectedItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetectedItem(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      workId: serializer.fromJson<String?>(json['workId']),
      titleGuess: serializer.fromJson<String>(json['titleGuess']),
      authorGuess: serializer.fromJson<String?>(json['authorGuess']),
      confidence: serializer.fromJson<double>(json['confidence']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      boundingBox: serializer.fromJson<String?>(json['boundingBox']),
      reviewStatus: serializer.fromJson<String>(json['reviewStatus']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'workId': serializer.toJson<String?>(workId),
      'titleGuess': serializer.toJson<String>(titleGuess),
      'authorGuess': serializer.toJson<String?>(authorGuess),
      'confidence': serializer.toJson<double>(confidence),
      'imagePath': serializer.toJson<String>(imagePath),
      'boundingBox': serializer.toJson<String?>(boundingBox),
      'reviewStatus': serializer.toJson<String>(reviewStatus),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DetectedItem copyWith(
          {String? id,
          String? sessionId,
          Value<String?> workId = const Value.absent(),
          String? titleGuess,
          Value<String?> authorGuess = const Value.absent(),
          double? confidence,
          String? imagePath,
          Value<String?> boundingBox = const Value.absent(),
          String? reviewStatus,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      DetectedItem(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        workId: workId.present ? workId.value : this.workId,
        titleGuess: titleGuess ?? this.titleGuess,
        authorGuess: authorGuess.present ? authorGuess.value : this.authorGuess,
        confidence: confidence ?? this.confidence,
        imagePath: imagePath ?? this.imagePath,
        boundingBox: boundingBox.present ? boundingBox.value : this.boundingBox,
        reviewStatus: reviewStatus ?? this.reviewStatus,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  DetectedItem copyWithCompanion(DetectedItemsCompanion data) {
    return DetectedItem(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      workId: data.workId.present ? data.workId.value : this.workId,
      titleGuess:
          data.titleGuess.present ? data.titleGuess.value : this.titleGuess,
      authorGuess:
          data.authorGuess.present ? data.authorGuess.value : this.authorGuess,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      boundingBox:
          data.boundingBox.present ? data.boundingBox.value : this.boundingBox,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetectedItem(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('workId: $workId, ')
          ..write('titleGuess: $titleGuess, ')
          ..write('authorGuess: $authorGuess, ')
          ..write('confidence: $confidence, ')
          ..write('imagePath: $imagePath, ')
          ..write('boundingBox: $boundingBox, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      sessionId,
      workId,
      titleGuess,
      authorGuess,
      confidence,
      imagePath,
      boundingBox,
      reviewStatus,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetectedItem &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.workId == this.workId &&
          other.titleGuess == this.titleGuess &&
          other.authorGuess == this.authorGuess &&
          other.confidence == this.confidence &&
          other.imagePath == this.imagePath &&
          other.boundingBox == this.boundingBox &&
          other.reviewStatus == this.reviewStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DetectedItemsCompanion extends UpdateCompanion<DetectedItem> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String?> workId;
  final Value<String> titleGuess;
  final Value<String?> authorGuess;
  final Value<double> confidence;
  final Value<String> imagePath;
  final Value<String?> boundingBox;
  final Value<String> reviewStatus;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const DetectedItemsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.workId = const Value.absent(),
    this.titleGuess = const Value.absent(),
    this.authorGuess = const Value.absent(),
    this.confidence = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.boundingBox = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DetectedItemsCompanion.insert({
    required String id,
    required String sessionId,
    this.workId = const Value.absent(),
    required String titleGuess,
    this.authorGuess = const Value.absent(),
    required double confidence,
    required String imagePath,
    this.boundingBox = const Value.absent(),
    required String reviewStatus,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        titleGuess = Value(titleGuess),
        confidence = Value(confidence),
        imagePath = Value(imagePath),
        reviewStatus = Value(reviewStatus);
  static Insertable<DetectedItem> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? workId,
    Expression<String>? titleGuess,
    Expression<String>? authorGuess,
    Expression<double>? confidence,
    Expression<String>? imagePath,
    Expression<String>? boundingBox,
    Expression<String>? reviewStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (workId != null) 'work_id': workId,
      if (titleGuess != null) 'title_guess': titleGuess,
      if (authorGuess != null) 'author_guess': authorGuess,
      if (confidence != null) 'confidence': confidence,
      if (imagePath != null) 'image_path': imagePath,
      if (boundingBox != null) 'bounding_box': boundingBox,
      if (reviewStatus != null) 'review_status': reviewStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DetectedItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String?>? workId,
      Value<String>? titleGuess,
      Value<String?>? authorGuess,
      Value<double>? confidence,
      Value<String>? imagePath,
      Value<String?>? boundingBox,
      Value<String>? reviewStatus,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return DetectedItemsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      workId: workId ?? this.workId,
      titleGuess: titleGuess ?? this.titleGuess,
      authorGuess: authorGuess ?? this.authorGuess,
      confidence: confidence ?? this.confidence,
      imagePath: imagePath ?? this.imagePath,
      boundingBox: boundingBox ?? this.boundingBox,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (titleGuess.present) {
      map['title_guess'] = Variable<String>(titleGuess.value);
    }
    if (authorGuess.present) {
      map['author_guess'] = Variable<String>(authorGuess.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (boundingBox.present) {
      map['bounding_box'] = Variable<String>(boundingBox.value);
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<String>(reviewStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetectedItemsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('workId: $workId, ')
          ..write('titleGuess: $titleGuess, ')
          ..write('authorGuess: $authorGuess, ')
          ..write('confidence: $confidence, ')
          ..write('imagePath: $imagePath, ')
          ..write('boundingBox: $boundingBox, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorksTable works = $WorksTable(this);
  late final $EditionsTable editions = $EditionsTable(this);
  late final $AuthorsTable authors = $AuthorsTable(this);
  late final $WorkAuthorsTable workAuthors = $WorkAuthorsTable(this);
  late final $UserLibraryEntriesTable userLibraryEntries =
      $UserLibraryEntriesTable(this);
  late final $ScanSessionsTable scanSessions = $ScanSessionsTable(this);
  late final $DetectedItemsTable detectedItems = $DetectedItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        works,
        editions,
        authors,
        workAuthors,
        userLibraryEntries,
        scanSessions,
        detectedItems
      ];
}

typedef $$WorksTableCreateCompanionBuilder = WorksCompanion Function({
  required String id,
  required String title,
  Value<String?> subtitle,
  Value<String?> description,
  Value<String?> author,
  required List<String> authorIds,
  required List<String> subjectTags,
  Value<bool> synthetic,
  Value<String?> reviewStatus,
  Value<String?> workKey,
  Value<DataProvider?> provider,
  Value<int?> qualityScore,
  required List<String> categories,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$WorksTableUpdateCompanionBuilder = WorksCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> subtitle,
  Value<String?> description,
  Value<String?> author,
  Value<List<String>> authorIds,
  Value<List<String>> subjectTags,
  Value<bool> synthetic,
  Value<String?> reviewStatus,
  Value<String?> workKey,
  Value<DataProvider?> provider,
  Value<int?> qualityScore,
  Value<List<String>> categories,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$WorksTableReferences
    extends BaseReferences<_$AppDatabase, $WorksTable, Work> {
  $$WorksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EditionsTable, List<Edition>> _editionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.editions,
          aliasName: $_aliasNameGenerator(db.works.id, db.editions.workId));

  $$EditionsTableProcessedTableManager get editionsRefs {
    final manager = $$EditionsTableTableManager($_db, $_db.editions)
        .filter((f) => f.workId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_editionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkAuthorsTable, List<WorkAuthor>>
      _workAuthorsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.workAuthors,
          aliasName: $_aliasNameGenerator(db.works.id, db.workAuthors.workId));

  $$WorkAuthorsTableProcessedTableManager get workAuthorsRefs {
    final manager = $$WorkAuthorsTableTableManager($_db, $_db.workAuthors)
        .filter((f) => f.workId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_workAuthorsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$UserLibraryEntriesTable, List<UserLibraryEntry>>
      _userLibraryEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.userLibraryEntries,
              aliasName: $_aliasNameGenerator(
                  db.works.id, db.userLibraryEntries.workId));

  $$UserLibraryEntriesTableProcessedTableManager get userLibraryEntriesRefs {
    final manager =
        $$UserLibraryEntriesTableTableManager($_db, $_db.userLibraryEntries)
            .filter((f) => f.workId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_userLibraryEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DetectedItemsTable, List<DetectedItem>>
      _detectedItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.detectedItems,
              aliasName:
                  $_aliasNameGenerator(db.works.id, db.detectedItems.workId));

  $$DetectedItemsTableProcessedTableManager get detectedItemsRefs {
    final manager = $$DetectedItemsTableTableManager($_db, $_db.detectedItems)
        .filter((f) => f.workId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_detectedItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorksTableFilterComposer extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subtitle => $composableBuilder(
      column: $table.subtitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get authorIds => $composableBuilder(
          column: $table.authorIds,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get subjectTags => $composableBuilder(
          column: $table.subjectTags,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get synthetic => $composableBuilder(
      column: $table.synthetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workKey => $composableBuilder(
      column: $table.workKey, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DataProvider?, DataProvider, String>
      get provider => $composableBuilder(
          column: $table.provider,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get categories => $composableBuilder(
          column: $table.categories,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> editionsRefs(
      Expression<bool> Function($$EditionsTableFilterComposer f) f) {
    final $$EditionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.editions,
        getReferencedColumn: (t) => t.workId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EditionsTableFilterComposer(
              $db: $db,
              $table: $db.editions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workAuthorsRefs(
      Expression<bool> Function($$WorkAuthorsTableFilterComposer f) f) {
    final $$WorkAuthorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workAuthors,
        getReferencedColumn: (t) => t.workId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkAuthorsTableFilterComposer(
              $db: $db,
              $table: $db.workAuthors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> userLibraryEntriesRefs(
      Expression<bool> Function($$UserLibraryEntriesTableFilterComposer f) f) {
    final $$UserLibraryEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userLibraryEntries,
        getReferencedColumn: (t) => t.workId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserLibraryEntriesTableFilterComposer(
              $db: $db,
              $table: $db.userLibraryEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> detectedItemsRefs(
      Expression<bool> Function($$DetectedItemsTableFilterComposer f) f) {
    final $$DetectedItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detectedItems,
        getReferencedColumn: (t) => t.workId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetectedItemsTableFilterComposer(
              $db: $db,
              $table: $db.detectedItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorksTableOrderingComposer
    extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subtitle => $composableBuilder(
      column: $table.subtitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorIds => $composableBuilder(
      column: $table.authorIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subjectTags => $composableBuilder(
      column: $table.subjectTags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synthetic => $composableBuilder(
      column: $table.synthetic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workKey => $composableBuilder(
      column: $table.workKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get provider => $composableBuilder(
      column: $table.provider, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categories => $composableBuilder(
      column: $table.categories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WorksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get authorIds =>
      $composableBuilder(column: $table.authorIds, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get subjectTags =>
      $composableBuilder(
          column: $table.subjectTags, builder: (column) => column);

  GeneratedColumn<bool> get synthetic =>
      $composableBuilder(column: $table.synthetic, builder: (column) => column);

  GeneratedColumn<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus, builder: (column) => column);

  GeneratedColumn<String> get workKey =>
      $composableBuilder(column: $table.workKey, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DataProvider?, String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get categories =>
      $composableBuilder(
          column: $table.categories, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> editionsRefs<T extends Object>(
      Expression<T> Function($$EditionsTableAnnotationComposer a) f) {
    final $$EditionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.editions,
        getReferencedColumn: (t) => t.workId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EditionsTableAnnotationComposer(
              $db: $db,
              $table: $db.editions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> workAuthorsRefs<T extends Object>(
      Expression<T> Function($$WorkAuthorsTableAnnotationComposer a) f) {
    final $$WorkAuthorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workAuthors,
        getReferencedColumn: (t) => t.workId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkAuthorsTableAnnotationComposer(
              $db: $db,
              $table: $db.workAuthors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> userLibraryEntriesRefs<T extends Object>(
      Expression<T> Function($$UserLibraryEntriesTableAnnotationComposer a) f) {
    final $$UserLibraryEntriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.userLibraryEntries,
            getReferencedColumn: (t) => t.workId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserLibraryEntriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userLibraryEntries,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> detectedItemsRefs<T extends Object>(
      Expression<T> Function($$DetectedItemsTableAnnotationComposer a) f) {
    final $$DetectedItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detectedItems,
        getReferencedColumn: (t) => t.workId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetectedItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.detectedItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorksTable,
    Work,
    $$WorksTableFilterComposer,
    $$WorksTableOrderingComposer,
    $$WorksTableAnnotationComposer,
    $$WorksTableCreateCompanionBuilder,
    $$WorksTableUpdateCompanionBuilder,
    (Work, $$WorksTableReferences),
    Work,
    PrefetchHooks Function(
        {bool editionsRefs,
        bool workAuthorsRefs,
        bool userLibraryEntriesRefs,
        bool detectedItemsRefs})> {
  $$WorksTableTableManager(_$AppDatabase db, $WorksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> subtitle = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<List<String>> authorIds = const Value.absent(),
            Value<List<String>> subjectTags = const Value.absent(),
            Value<bool> synthetic = const Value.absent(),
            Value<String?> reviewStatus = const Value.absent(),
            Value<String?> workKey = const Value.absent(),
            Value<DataProvider?> provider = const Value.absent(),
            Value<int?> qualityScore = const Value.absent(),
            Value<List<String>> categories = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorksCompanion(
            id: id,
            title: title,
            subtitle: subtitle,
            description: description,
            author: author,
            authorIds: authorIds,
            subjectTags: subjectTags,
            synthetic: synthetic,
            reviewStatus: reviewStatus,
            workKey: workKey,
            provider: provider,
            qualityScore: qualityScore,
            categories: categories,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> subtitle = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> author = const Value.absent(),
            required List<String> authorIds,
            required List<String> subjectTags,
            Value<bool> synthetic = const Value.absent(),
            Value<String?> reviewStatus = const Value.absent(),
            Value<String?> workKey = const Value.absent(),
            Value<DataProvider?> provider = const Value.absent(),
            Value<int?> qualityScore = const Value.absent(),
            required List<String> categories,
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorksCompanion.insert(
            id: id,
            title: title,
            subtitle: subtitle,
            description: description,
            author: author,
            authorIds: authorIds,
            subjectTags: subjectTags,
            synthetic: synthetic,
            reviewStatus: reviewStatus,
            workKey: workKey,
            provider: provider,
            qualityScore: qualityScore,
            categories: categories,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WorksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {editionsRefs = false,
              workAuthorsRefs = false,
              userLibraryEntriesRefs = false,
              detectedItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (editionsRefs) db.editions,
                if (workAuthorsRefs) db.workAuthors,
                if (userLibraryEntriesRefs) db.userLibraryEntries,
                if (detectedItemsRefs) db.detectedItems
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (editionsRefs)
                    await $_getPrefetchedData<Work, $WorksTable, Edition>(
                        currentTable: table,
                        referencedTable:
                            $$WorksTableReferences._editionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorksTableReferences(db, table, p0).editionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.workId == item.id),
                        typedResults: items),
                  if (workAuthorsRefs)
                    await $_getPrefetchedData<Work, $WorksTable, WorkAuthor>(
                        currentTable: table,
                        referencedTable:
                            $$WorksTableReferences._workAuthorsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorksTableReferences(db, table, p0)
                                .workAuthorsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.workId == item.id),
                        typedResults: items),
                  if (userLibraryEntriesRefs)
                    await $_getPrefetchedData<Work, $WorksTable,
                            UserLibraryEntry>(
                        currentTable: table,
                        referencedTable: $$WorksTableReferences
                            ._userLibraryEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorksTableReferences(db, table, p0)
                                .userLibraryEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.workId == item.id),
                        typedResults: items),
                  if (detectedItemsRefs)
                    await $_getPrefetchedData<Work, $WorksTable, DetectedItem>(
                        currentTable: table,
                        referencedTable:
                            $$WorksTableReferences._detectedItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorksTableReferences(db, table, p0)
                                .detectedItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.workId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorksTable,
    Work,
    $$WorksTableFilterComposer,
    $$WorksTableOrderingComposer,
    $$WorksTableAnnotationComposer,
    $$WorksTableCreateCompanionBuilder,
    $$WorksTableUpdateCompanionBuilder,
    (Work, $$WorksTableReferences),
    Work,
    PrefetchHooks Function(
        {bool editionsRefs,
        bool workAuthorsRefs,
        bool userLibraryEntriesRefs,
        bool detectedItemsRefs})>;
typedef $$EditionsTableCreateCompanionBuilder = EditionsCompanion Function({
  required String id,
  required String workId,
  Value<String?> isbn,
  Value<String?> isbn10,
  Value<String?> isbn13,
  Value<String?> subtitle,
  Value<String?> publisher,
  Value<int?> publishedYear,
  Value<String?> coverImageURL,
  Value<String?> thumbnailURL,
  Value<String?> description,
  Value<String?> format,
  Value<int?> pageCount,
  Value<String?> language,
  Value<String?> editionKey,
  required List<String> categories,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$EditionsTableUpdateCompanionBuilder = EditionsCompanion Function({
  Value<String> id,
  Value<String> workId,
  Value<String?> isbn,
  Value<String?> isbn10,
  Value<String?> isbn13,
  Value<String?> subtitle,
  Value<String?> publisher,
  Value<int?> publishedYear,
  Value<String?> coverImageURL,
  Value<String?> thumbnailURL,
  Value<String?> description,
  Value<String?> format,
  Value<int?> pageCount,
  Value<String?> language,
  Value<String?> editionKey,
  Value<List<String>> categories,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$EditionsTableReferences
    extends BaseReferences<_$AppDatabase, $EditionsTable, Edition> {
  $$EditionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorksTable _workIdTable(_$AppDatabase db) => db.works
      .createAlias($_aliasNameGenerator(db.editions.workId, db.works.id));

  $$WorksTableProcessedTableManager get workId {
    final $_column = $_itemColumn<String>('work_id')!;

    final manager = $$WorksTableTableManager($_db, $_db.works)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$UserLibraryEntriesTable, List<UserLibraryEntry>>
      _userLibraryEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.userLibraryEntries,
              aliasName: $_aliasNameGenerator(
                  db.editions.id, db.userLibraryEntries.editionId));

  $$UserLibraryEntriesTableProcessedTableManager get userLibraryEntriesRefs {
    final manager = $$UserLibraryEntriesTableTableManager(
            $_db, $_db.userLibraryEntries)
        .filter((f) => f.editionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_userLibraryEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EditionsTableFilterComposer
    extends Composer<_$AppDatabase, $EditionsTable> {
  $$EditionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isbn => $composableBuilder(
      column: $table.isbn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isbn10 => $composableBuilder(
      column: $table.isbn10, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isbn13 => $composableBuilder(
      column: $table.isbn13, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subtitle => $composableBuilder(
      column: $table.subtitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get publisher => $composableBuilder(
      column: $table.publisher, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get publishedYear => $composableBuilder(
      column: $table.publishedYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverImageURL => $composableBuilder(
      column: $table.coverImageURL, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumbnailURL => $composableBuilder(
      column: $table.thumbnailURL, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pageCount => $composableBuilder(
      column: $table.pageCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get editionKey => $composableBuilder(
      column: $table.editionKey, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get categories => $composableBuilder(
          column: $table.categories,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$WorksTableFilterComposer get workId {
    final $$WorksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableFilterComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> userLibraryEntriesRefs(
      Expression<bool> Function($$UserLibraryEntriesTableFilterComposer f) f) {
    final $$UserLibraryEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userLibraryEntries,
        getReferencedColumn: (t) => t.editionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserLibraryEntriesTableFilterComposer(
              $db: $db,
              $table: $db.userLibraryEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EditionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EditionsTable> {
  $$EditionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isbn => $composableBuilder(
      column: $table.isbn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isbn10 => $composableBuilder(
      column: $table.isbn10, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isbn13 => $composableBuilder(
      column: $table.isbn13, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subtitle => $composableBuilder(
      column: $table.subtitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get publisher => $composableBuilder(
      column: $table.publisher, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get publishedYear => $composableBuilder(
      column: $table.publishedYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverImageURL => $composableBuilder(
      column: $table.coverImageURL,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumbnailURL => $composableBuilder(
      column: $table.thumbnailURL,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pageCount => $composableBuilder(
      column: $table.pageCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get editionKey => $composableBuilder(
      column: $table.editionKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categories => $composableBuilder(
      column: $table.categories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$WorksTableOrderingComposer get workId {
    final $$WorksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableOrderingComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EditionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EditionsTable> {
  $$EditionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get isbn =>
      $composableBuilder(column: $table.isbn, builder: (column) => column);

  GeneratedColumn<String> get isbn10 =>
      $composableBuilder(column: $table.isbn10, builder: (column) => column);

  GeneratedColumn<String> get isbn13 =>
      $composableBuilder(column: $table.isbn13, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<int> get publishedYear => $composableBuilder(
      column: $table.publishedYear, builder: (column) => column);

  GeneratedColumn<String> get coverImageURL => $composableBuilder(
      column: $table.coverImageURL, builder: (column) => column);

  GeneratedColumn<String> get thumbnailURL => $composableBuilder(
      column: $table.thumbnailURL, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get editionKey => $composableBuilder(
      column: $table.editionKey, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get categories =>
      $composableBuilder(
          column: $table.categories, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorksTableAnnotationComposer get workId {
    final $$WorksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableAnnotationComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> userLibraryEntriesRefs<T extends Object>(
      Expression<T> Function($$UserLibraryEntriesTableAnnotationComposer a) f) {
    final $$UserLibraryEntriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.userLibraryEntries,
            getReferencedColumn: (t) => t.editionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserLibraryEntriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userLibraryEntries,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$EditionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EditionsTable,
    Edition,
    $$EditionsTableFilterComposer,
    $$EditionsTableOrderingComposer,
    $$EditionsTableAnnotationComposer,
    $$EditionsTableCreateCompanionBuilder,
    $$EditionsTableUpdateCompanionBuilder,
    (Edition, $$EditionsTableReferences),
    Edition,
    PrefetchHooks Function({bool workId, bool userLibraryEntriesRefs})> {
  $$EditionsTableTableManager(_$AppDatabase db, $EditionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EditionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EditionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EditionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String?> isbn = const Value.absent(),
            Value<String?> isbn10 = const Value.absent(),
            Value<String?> isbn13 = const Value.absent(),
            Value<String?> subtitle = const Value.absent(),
            Value<String?> publisher = const Value.absent(),
            Value<int?> publishedYear = const Value.absent(),
            Value<String?> coverImageURL = const Value.absent(),
            Value<String?> thumbnailURL = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> format = const Value.absent(),
            Value<int?> pageCount = const Value.absent(),
            Value<String?> language = const Value.absent(),
            Value<String?> editionKey = const Value.absent(),
            Value<List<String>> categories = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EditionsCompanion(
            id: id,
            workId: workId,
            isbn: isbn,
            isbn10: isbn10,
            isbn13: isbn13,
            subtitle: subtitle,
            publisher: publisher,
            publishedYear: publishedYear,
            coverImageURL: coverImageURL,
            thumbnailURL: thumbnailURL,
            description: description,
            format: format,
            pageCount: pageCount,
            language: language,
            editionKey: editionKey,
            categories: categories,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            Value<String?> isbn = const Value.absent(),
            Value<String?> isbn10 = const Value.absent(),
            Value<String?> isbn13 = const Value.absent(),
            Value<String?> subtitle = const Value.absent(),
            Value<String?> publisher = const Value.absent(),
            Value<int?> publishedYear = const Value.absent(),
            Value<String?> coverImageURL = const Value.absent(),
            Value<String?> thumbnailURL = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> format = const Value.absent(),
            Value<int?> pageCount = const Value.absent(),
            Value<String?> language = const Value.absent(),
            Value<String?> editionKey = const Value.absent(),
            required List<String> categories,
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EditionsCompanion.insert(
            id: id,
            workId: workId,
            isbn: isbn,
            isbn10: isbn10,
            isbn13: isbn13,
            subtitle: subtitle,
            publisher: publisher,
            publishedYear: publishedYear,
            coverImageURL: coverImageURL,
            thumbnailURL: thumbnailURL,
            description: description,
            format: format,
            pageCount: pageCount,
            language: language,
            editionKey: editionKey,
            categories: categories,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EditionsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {workId = false, userLibraryEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userLibraryEntriesRefs) db.userLibraryEntries
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workId,
                    referencedTable: $$EditionsTableReferences._workIdTable(db),
                    referencedColumn:
                        $$EditionsTableReferences._workIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userLibraryEntriesRefs)
                    await $_getPrefetchedData<Edition, $EditionsTable,
                            UserLibraryEntry>(
                        currentTable: table,
                        referencedTable: $$EditionsTableReferences
                            ._userLibraryEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EditionsTableReferences(db, table, p0)
                                .userLibraryEntriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.editionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EditionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EditionsTable,
    Edition,
    $$EditionsTableFilterComposer,
    $$EditionsTableOrderingComposer,
    $$EditionsTableAnnotationComposer,
    $$EditionsTableCreateCompanionBuilder,
    $$EditionsTableUpdateCompanionBuilder,
    (Edition, $$EditionsTableReferences),
    Edition,
    PrefetchHooks Function({bool workId, bool userLibraryEntriesRefs})>;
typedef $$AuthorsTableCreateCompanionBuilder = AuthorsCompanion Function({
  required String id,
  required String name,
  Value<String?> gender,
  Value<String?> culturalRegion,
  Value<String?> openLibraryId,
  Value<String?> goodreadsId,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$AuthorsTableUpdateCompanionBuilder = AuthorsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> gender,
  Value<String?> culturalRegion,
  Value<String?> openLibraryId,
  Value<String?> goodreadsId,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$AuthorsTableReferences
    extends BaseReferences<_$AppDatabase, $AuthorsTable, Author> {
  $$AuthorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkAuthorsTable, List<WorkAuthor>>
      _workAuthorsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.workAuthors,
              aliasName:
                  $_aliasNameGenerator(db.authors.id, db.workAuthors.authorId));

  $$WorkAuthorsTableProcessedTableManager get workAuthorsRefs {
    final manager = $$WorkAuthorsTableTableManager($_db, $_db.workAuthors)
        .filter((f) => f.authorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_workAuthorsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AuthorsTableFilterComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get culturalRegion => $composableBuilder(
      column: $table.culturalRegion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get openLibraryId => $composableBuilder(
      column: $table.openLibraryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goodreadsId => $composableBuilder(
      column: $table.goodreadsId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> workAuthorsRefs(
      Expression<bool> Function($$WorkAuthorsTableFilterComposer f) f) {
    final $$WorkAuthorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workAuthors,
        getReferencedColumn: (t) => t.authorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkAuthorsTableFilterComposer(
              $db: $db,
              $table: $db.workAuthors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AuthorsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get culturalRegion => $composableBuilder(
      column: $table.culturalRegion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get openLibraryId => $composableBuilder(
      column: $table.openLibraryId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goodreadsId => $composableBuilder(
      column: $table.goodreadsId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AuthorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuthorsTable> {
  $$AuthorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get culturalRegion => $composableBuilder(
      column: $table.culturalRegion, builder: (column) => column);

  GeneratedColumn<String> get openLibraryId => $composableBuilder(
      column: $table.openLibraryId, builder: (column) => column);

  GeneratedColumn<String> get goodreadsId => $composableBuilder(
      column: $table.goodreadsId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> workAuthorsRefs<T extends Object>(
      Expression<T> Function($$WorkAuthorsTableAnnotationComposer a) f) {
    final $$WorkAuthorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workAuthors,
        getReferencedColumn: (t) => t.authorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkAuthorsTableAnnotationComposer(
              $db: $db,
              $table: $db.workAuthors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AuthorsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuthorsTable,
    Author,
    $$AuthorsTableFilterComposer,
    $$AuthorsTableOrderingComposer,
    $$AuthorsTableAnnotationComposer,
    $$AuthorsTableCreateCompanionBuilder,
    $$AuthorsTableUpdateCompanionBuilder,
    (Author, $$AuthorsTableReferences),
    Author,
    PrefetchHooks Function({bool workAuthorsRefs})> {
  $$AuthorsTableTableManager(_$AppDatabase db, $AuthorsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuthorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuthorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuthorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> culturalRegion = const Value.absent(),
            Value<String?> openLibraryId = const Value.absent(),
            Value<String?> goodreadsId = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthorsCompanion(
            id: id,
            name: name,
            gender: gender,
            culturalRegion: culturalRegion,
            openLibraryId: openLibraryId,
            goodreadsId: goodreadsId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> gender = const Value.absent(),
            Value<String?> culturalRegion = const Value.absent(),
            Value<String?> openLibraryId = const Value.absent(),
            Value<String?> goodreadsId = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthorsCompanion.insert(
            id: id,
            name: name,
            gender: gender,
            culturalRegion: culturalRegion,
            openLibraryId: openLibraryId,
            goodreadsId: goodreadsId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AuthorsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({workAuthorsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (workAuthorsRefs) db.workAuthors],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workAuthorsRefs)
                    await $_getPrefetchedData<Author, $AuthorsTable,
                            WorkAuthor>(
                        currentTable: table,
                        referencedTable:
                            $$AuthorsTableReferences._workAuthorsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AuthorsTableReferences(db, table, p0)
                                .workAuthorsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.authorId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AuthorsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AuthorsTable,
    Author,
    $$AuthorsTableFilterComposer,
    $$AuthorsTableOrderingComposer,
    $$AuthorsTableAnnotationComposer,
    $$AuthorsTableCreateCompanionBuilder,
    $$AuthorsTableUpdateCompanionBuilder,
    (Author, $$AuthorsTableReferences),
    Author,
    PrefetchHooks Function({bool workAuthorsRefs})>;
typedef $$WorkAuthorsTableCreateCompanionBuilder = WorkAuthorsCompanion
    Function({
  required String workId,
  required String authorId,
  Value<int> rowid,
});
typedef $$WorkAuthorsTableUpdateCompanionBuilder = WorkAuthorsCompanion
    Function({
  Value<String> workId,
  Value<String> authorId,
  Value<int> rowid,
});

final class $$WorkAuthorsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkAuthorsTable, WorkAuthor> {
  $$WorkAuthorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorksTable _workIdTable(_$AppDatabase db) => db.works
      .createAlias($_aliasNameGenerator(db.workAuthors.workId, db.works.id));

  $$WorksTableProcessedTableManager get workId {
    final $_column = $_itemColumn<String>('work_id')!;

    final manager = $$WorksTableTableManager($_db, $_db.works)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AuthorsTable _authorIdTable(_$AppDatabase db) =>
      db.authors.createAlias(
          $_aliasNameGenerator(db.workAuthors.authorId, db.authors.id));

  $$AuthorsTableProcessedTableManager get authorId {
    final $_column = $_itemColumn<String>('author_id')!;

    final manager = $$AuthorsTableTableManager($_db, $_db.authors)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_authorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WorkAuthorsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkAuthorsTable> {
  $$WorkAuthorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableFilterComposer get workId {
    final $$WorksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableFilterComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AuthorsTableFilterComposer get authorId {
    final $$AuthorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.authorId,
        referencedTable: $db.authors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AuthorsTableFilterComposer(
              $db: $db,
              $table: $db.authors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkAuthorsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkAuthorsTable> {
  $$WorkAuthorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableOrderingComposer get workId {
    final $$WorksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableOrderingComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AuthorsTableOrderingComposer get authorId {
    final $$AuthorsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.authorId,
        referencedTable: $db.authors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AuthorsTableOrderingComposer(
              $db: $db,
              $table: $db.authors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkAuthorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkAuthorsTable> {
  $$WorkAuthorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WorksTableAnnotationComposer get workId {
    final $$WorksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableAnnotationComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AuthorsTableAnnotationComposer get authorId {
    final $$AuthorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.authorId,
        referencedTable: $db.authors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AuthorsTableAnnotationComposer(
              $db: $db,
              $table: $db.authors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkAuthorsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkAuthorsTable,
    WorkAuthor,
    $$WorkAuthorsTableFilterComposer,
    $$WorkAuthorsTableOrderingComposer,
    $$WorkAuthorsTableAnnotationComposer,
    $$WorkAuthorsTableCreateCompanionBuilder,
    $$WorkAuthorsTableUpdateCompanionBuilder,
    (WorkAuthor, $$WorkAuthorsTableReferences),
    WorkAuthor,
    PrefetchHooks Function({bool workId, bool authorId})> {
  $$WorkAuthorsTableTableManager(_$AppDatabase db, $WorkAuthorsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkAuthorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkAuthorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkAuthorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> workId = const Value.absent(),
            Value<String> authorId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkAuthorsCompanion(
            workId: workId,
            authorId: authorId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String workId,
            required String authorId,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkAuthorsCompanion.insert(
            workId: workId,
            authorId: authorId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkAuthorsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workId = false, authorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workId,
                    referencedTable:
                        $$WorkAuthorsTableReferences._workIdTable(db),
                    referencedColumn:
                        $$WorkAuthorsTableReferences._workIdTable(db).id,
                  ) as T;
                }
                if (authorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.authorId,
                    referencedTable:
                        $$WorkAuthorsTableReferences._authorIdTable(db),
                    referencedColumn:
                        $$WorkAuthorsTableReferences._authorIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WorkAuthorsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkAuthorsTable,
    WorkAuthor,
    $$WorkAuthorsTableFilterComposer,
    $$WorkAuthorsTableOrderingComposer,
    $$WorkAuthorsTableAnnotationComposer,
    $$WorkAuthorsTableCreateCompanionBuilder,
    $$WorkAuthorsTableUpdateCompanionBuilder,
    (WorkAuthor, $$WorkAuthorsTableReferences),
    WorkAuthor,
    PrefetchHooks Function({bool workId, bool authorId})>;
typedef $$UserLibraryEntriesTableCreateCompanionBuilder
    = UserLibraryEntriesCompanion Function({
  required String id,
  required String workId,
  Value<String?> editionId,
  required ReadingStatus status,
  Value<int?> currentPage,
  Value<int?> personalRating,
  Value<String?> notes,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$UserLibraryEntriesTableUpdateCompanionBuilder
    = UserLibraryEntriesCompanion Function({
  Value<String> id,
  Value<String> workId,
  Value<String?> editionId,
  Value<ReadingStatus> status,
  Value<int?> currentPage,
  Value<int?> personalRating,
  Value<String?> notes,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$UserLibraryEntriesTableReferences extends BaseReferences<
    _$AppDatabase, $UserLibraryEntriesTable, UserLibraryEntry> {
  $$UserLibraryEntriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WorksTable _workIdTable(_$AppDatabase db) => db.works.createAlias(
      $_aliasNameGenerator(db.userLibraryEntries.workId, db.works.id));

  $$WorksTableProcessedTableManager get workId {
    final $_column = $_itemColumn<String>('work_id')!;

    final manager = $$WorksTableTableManager($_db, $_db.works)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EditionsTable _editionIdTable(_$AppDatabase db) =>
      db.editions.createAlias($_aliasNameGenerator(
          db.userLibraryEntries.editionId, db.editions.id));

  $$EditionsTableProcessedTableManager? get editionId {
    final $_column = $_itemColumn<String>('edition_id');
    if ($_column == null) return null;
    final manager = $$EditionsTableTableManager($_db, $_db.editions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_editionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserLibraryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $UserLibraryEntriesTable> {
  $$UserLibraryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ReadingStatus, ReadingStatus, int>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get currentPage => $composableBuilder(
      column: $table.currentPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get personalRating => $composableBuilder(
      column: $table.personalRating,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$WorksTableFilterComposer get workId {
    final $$WorksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableFilterComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EditionsTableFilterComposer get editionId {
    final $$EditionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.editionId,
        referencedTable: $db.editions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EditionsTableFilterComposer(
              $db: $db,
              $table: $db.editions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserLibraryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserLibraryEntriesTable> {
  $$UserLibraryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentPage => $composableBuilder(
      column: $table.currentPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get personalRating => $composableBuilder(
      column: $table.personalRating,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$WorksTableOrderingComposer get workId {
    final $$WorksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableOrderingComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EditionsTableOrderingComposer get editionId {
    final $$EditionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.editionId,
        referencedTable: $db.editions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EditionsTableOrderingComposer(
              $db: $db,
              $table: $db.editions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserLibraryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserLibraryEntriesTable> {
  $$UserLibraryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReadingStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get currentPage => $composableBuilder(
      column: $table.currentPage, builder: (column) => column);

  GeneratedColumn<int> get personalRating => $composableBuilder(
      column: $table.personalRating, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorksTableAnnotationComposer get workId {
    final $$WorksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableAnnotationComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EditionsTableAnnotationComposer get editionId {
    final $$EditionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.editionId,
        referencedTable: $db.editions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EditionsTableAnnotationComposer(
              $db: $db,
              $table: $db.editions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserLibraryEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserLibraryEntriesTable,
    UserLibraryEntry,
    $$UserLibraryEntriesTableFilterComposer,
    $$UserLibraryEntriesTableOrderingComposer,
    $$UserLibraryEntriesTableAnnotationComposer,
    $$UserLibraryEntriesTableCreateCompanionBuilder,
    $$UserLibraryEntriesTableUpdateCompanionBuilder,
    (UserLibraryEntry, $$UserLibraryEntriesTableReferences),
    UserLibraryEntry,
    PrefetchHooks Function({bool workId, bool editionId})> {
  $$UserLibraryEntriesTableTableManager(
      _$AppDatabase db, $UserLibraryEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserLibraryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserLibraryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserLibraryEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String?> editionId = const Value.absent(),
            Value<ReadingStatus> status = const Value.absent(),
            Value<int?> currentPage = const Value.absent(),
            Value<int?> personalRating = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserLibraryEntriesCompanion(
            id: id,
            workId: workId,
            editionId: editionId,
            status: status,
            currentPage: currentPage,
            personalRating: personalRating,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            Value<String?> editionId = const Value.absent(),
            required ReadingStatus status,
            Value<int?> currentPage = const Value.absent(),
            Value<int?> personalRating = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserLibraryEntriesCompanion.insert(
            id: id,
            workId: workId,
            editionId: editionId,
            status: status,
            currentPage: currentPage,
            personalRating: personalRating,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserLibraryEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workId = false, editionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workId,
                    referencedTable:
                        $$UserLibraryEntriesTableReferences._workIdTable(db),
                    referencedColumn:
                        $$UserLibraryEntriesTableReferences._workIdTable(db).id,
                  ) as T;
                }
                if (editionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.editionId,
                    referencedTable:
                        $$UserLibraryEntriesTableReferences._editionIdTable(db),
                    referencedColumn: $$UserLibraryEntriesTableReferences
                        ._editionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserLibraryEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserLibraryEntriesTable,
    UserLibraryEntry,
    $$UserLibraryEntriesTableFilterComposer,
    $$UserLibraryEntriesTableOrderingComposer,
    $$UserLibraryEntriesTableAnnotationComposer,
    $$UserLibraryEntriesTableCreateCompanionBuilder,
    $$UserLibraryEntriesTableUpdateCompanionBuilder,
    (UserLibraryEntry, $$UserLibraryEntriesTableReferences),
    UserLibraryEntry,
    PrefetchHooks Function({bool workId, bool editionId})>;
typedef $$ScanSessionsTableCreateCompanionBuilder = ScanSessionsCompanion
    Function({
  required String id,
  required int totalDetected,
  Value<int> reviewedCount,
  Value<int> acceptedCount,
  Value<int> rejectedCount,
  required String status,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$ScanSessionsTableUpdateCompanionBuilder = ScanSessionsCompanion
    Function({
  Value<String> id,
  Value<int> totalDetected,
  Value<int> reviewedCount,
  Value<int> acceptedCount,
  Value<int> rejectedCount,
  Value<String> status,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$ScanSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $ScanSessionsTable, ScanSession> {
  $$ScanSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DetectedItemsTable, List<DetectedItem>>
      _detectedItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.detectedItems,
              aliasName: $_aliasNameGenerator(
                  db.scanSessions.id, db.detectedItems.sessionId));

  $$DetectedItemsTableProcessedTableManager get detectedItemsRefs {
    final manager = $$DetectedItemsTableTableManager($_db, $_db.detectedItems)
        .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_detectedItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ScanSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ScanSessionsTable> {
  $$ScanSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalDetected => $composableBuilder(
      column: $table.totalDetected, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reviewedCount => $composableBuilder(
      column: $table.reviewedCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get acceptedCount => $composableBuilder(
      column: $table.acceptedCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rejectedCount => $composableBuilder(
      column: $table.rejectedCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> detectedItemsRefs(
      Expression<bool> Function($$DetectedItemsTableFilterComposer f) f) {
    final $$DetectedItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detectedItems,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetectedItemsTableFilterComposer(
              $db: $db,
              $table: $db.detectedItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ScanSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanSessionsTable> {
  $$ScanSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalDetected => $composableBuilder(
      column: $table.totalDetected,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reviewedCount => $composableBuilder(
      column: $table.reviewedCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get acceptedCount => $composableBuilder(
      column: $table.acceptedCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rejectedCount => $composableBuilder(
      column: $table.rejectedCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ScanSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanSessionsTable> {
  $$ScanSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalDetected => $composableBuilder(
      column: $table.totalDetected, builder: (column) => column);

  GeneratedColumn<int> get reviewedCount => $composableBuilder(
      column: $table.reviewedCount, builder: (column) => column);

  GeneratedColumn<int> get acceptedCount => $composableBuilder(
      column: $table.acceptedCount, builder: (column) => column);

  GeneratedColumn<int> get rejectedCount => $composableBuilder(
      column: $table.rejectedCount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> detectedItemsRefs<T extends Object>(
      Expression<T> Function($$DetectedItemsTableAnnotationComposer a) f) {
    final $$DetectedItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detectedItems,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetectedItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.detectedItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ScanSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScanSessionsTable,
    ScanSession,
    $$ScanSessionsTableFilterComposer,
    $$ScanSessionsTableOrderingComposer,
    $$ScanSessionsTableAnnotationComposer,
    $$ScanSessionsTableCreateCompanionBuilder,
    $$ScanSessionsTableUpdateCompanionBuilder,
    (ScanSession, $$ScanSessionsTableReferences),
    ScanSession,
    PrefetchHooks Function({bool detectedItemsRefs})> {
  $$ScanSessionsTableTableManager(_$AppDatabase db, $ScanSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> totalDetected = const Value.absent(),
            Value<int> reviewedCount = const Value.absent(),
            Value<int> acceptedCount = const Value.absent(),
            Value<int> rejectedCount = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ScanSessionsCompanion(
            id: id,
            totalDetected: totalDetected,
            reviewedCount: reviewedCount,
            acceptedCount: acceptedCount,
            rejectedCount: rejectedCount,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int totalDetected,
            Value<int> reviewedCount = const Value.absent(),
            Value<int> acceptedCount = const Value.absent(),
            Value<int> rejectedCount = const Value.absent(),
            required String status,
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ScanSessionsCompanion.insert(
            id: id,
            totalDetected: totalDetected,
            reviewedCount: reviewedCount,
            acceptedCount: acceptedCount,
            rejectedCount: rejectedCount,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ScanSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({detectedItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (detectedItemsRefs) db.detectedItems
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (detectedItemsRefs)
                    await $_getPrefetchedData<ScanSession, $ScanSessionsTable,
                            DetectedItem>(
                        currentTable: table,
                        referencedTable: $$ScanSessionsTableReferences
                            ._detectedItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ScanSessionsTableReferences(db, table, p0)
                                .detectedItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ScanSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScanSessionsTable,
    ScanSession,
    $$ScanSessionsTableFilterComposer,
    $$ScanSessionsTableOrderingComposer,
    $$ScanSessionsTableAnnotationComposer,
    $$ScanSessionsTableCreateCompanionBuilder,
    $$ScanSessionsTableUpdateCompanionBuilder,
    (ScanSession, $$ScanSessionsTableReferences),
    ScanSession,
    PrefetchHooks Function({bool detectedItemsRefs})>;
typedef $$DetectedItemsTableCreateCompanionBuilder = DetectedItemsCompanion
    Function({
  required String id,
  required String sessionId,
  Value<String?> workId,
  required String titleGuess,
  Value<String?> authorGuess,
  required double confidence,
  required String imagePath,
  Value<String?> boundingBox,
  required String reviewStatus,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$DetectedItemsTableUpdateCompanionBuilder = DetectedItemsCompanion
    Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String?> workId,
  Value<String> titleGuess,
  Value<String?> authorGuess,
  Value<double> confidence,
  Value<String> imagePath,
  Value<String?> boundingBox,
  Value<String> reviewStatus,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$DetectedItemsTableReferences
    extends BaseReferences<_$AppDatabase, $DetectedItemsTable, DetectedItem> {
  $$DetectedItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ScanSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.scanSessions.createAlias(
          $_aliasNameGenerator(db.detectedItems.sessionId, db.scanSessions.id));

  $$ScanSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$ScanSessionsTableTableManager($_db, $_db.scanSessions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $WorksTable _workIdTable(_$AppDatabase db) => db.works
      .createAlias($_aliasNameGenerator(db.detectedItems.workId, db.works.id));

  $$WorksTableProcessedTableManager? get workId {
    final $_column = $_itemColumn<String>('work_id');
    if ($_column == null) return null;
    final manager = $$WorksTableTableManager($_db, $_db.works)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DetectedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DetectedItemsTable> {
  $$DetectedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleGuess => $composableBuilder(
      column: $table.titleGuess, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorGuess => $composableBuilder(
      column: $table.authorGuess, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get boundingBox => $composableBuilder(
      column: $table.boundingBox, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ScanSessionsTableFilterComposer get sessionId {
    final $$ScanSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.scanSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScanSessionsTableFilterComposer(
              $db: $db,
              $table: $db.scanSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$WorksTableFilterComposer get workId {
    final $$WorksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableFilterComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetectedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DetectedItemsTable> {
  $$DetectedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleGuess => $composableBuilder(
      column: $table.titleGuess, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorGuess => $composableBuilder(
      column: $table.authorGuess, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get boundingBox => $composableBuilder(
      column: $table.boundingBox, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ScanSessionsTableOrderingComposer get sessionId {
    final $$ScanSessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.scanSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScanSessionsTableOrderingComposer(
              $db: $db,
              $table: $db.scanSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$WorksTableOrderingComposer get workId {
    final $$WorksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableOrderingComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetectedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DetectedItemsTable> {
  $$DetectedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleGuess => $composableBuilder(
      column: $table.titleGuess, builder: (column) => column);

  GeneratedColumn<String> get authorGuess => $composableBuilder(
      column: $table.authorGuess, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get boundingBox => $composableBuilder(
      column: $table.boundingBox, builder: (column) => column);

  GeneratedColumn<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ScanSessionsTableAnnotationComposer get sessionId {
    final $$ScanSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.scanSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ScanSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.scanSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$WorksTableAnnotationComposer get workId {
    final $$WorksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workId,
        referencedTable: $db.works,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorksTableAnnotationComposer(
              $db: $db,
              $table: $db.works,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetectedItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DetectedItemsTable,
    DetectedItem,
    $$DetectedItemsTableFilterComposer,
    $$DetectedItemsTableOrderingComposer,
    $$DetectedItemsTableAnnotationComposer,
    $$DetectedItemsTableCreateCompanionBuilder,
    $$DetectedItemsTableUpdateCompanionBuilder,
    (DetectedItem, $$DetectedItemsTableReferences),
    DetectedItem,
    PrefetchHooks Function({bool sessionId, bool workId})> {
  $$DetectedItemsTableTableManager(_$AppDatabase db, $DetectedItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DetectedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DetectedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DetectedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String?> workId = const Value.absent(),
            Value<String> titleGuess = const Value.absent(),
            Value<String?> authorGuess = const Value.absent(),
            Value<double> confidence = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<String?> boundingBox = const Value.absent(),
            Value<String> reviewStatus = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DetectedItemsCompanion(
            id: id,
            sessionId: sessionId,
            workId: workId,
            titleGuess: titleGuess,
            authorGuess: authorGuess,
            confidence: confidence,
            imagePath: imagePath,
            boundingBox: boundingBox,
            reviewStatus: reviewStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            Value<String?> workId = const Value.absent(),
            required String titleGuess,
            Value<String?> authorGuess = const Value.absent(),
            required double confidence,
            required String imagePath,
            Value<String?> boundingBox = const Value.absent(),
            required String reviewStatus,
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DetectedItemsCompanion.insert(
            id: id,
            sessionId: sessionId,
            workId: workId,
            titleGuess: titleGuess,
            authorGuess: authorGuess,
            confidence: confidence,
            imagePath: imagePath,
            boundingBox: boundingBox,
            reviewStatus: reviewStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DetectedItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sessionId = false, workId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable:
                        $$DetectedItemsTableReferences._sessionIdTable(db),
                    referencedColumn:
                        $$DetectedItemsTableReferences._sessionIdTable(db).id,
                  ) as T;
                }
                if (workId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workId,
                    referencedTable:
                        $$DetectedItemsTableReferences._workIdTable(db),
                    referencedColumn:
                        $$DetectedItemsTableReferences._workIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DetectedItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DetectedItemsTable,
    DetectedItem,
    $$DetectedItemsTableFilterComposer,
    $$DetectedItemsTableOrderingComposer,
    $$DetectedItemsTableAnnotationComposer,
    $$DetectedItemsTableCreateCompanionBuilder,
    $$DetectedItemsTableUpdateCompanionBuilder,
    (DetectedItem, $$DetectedItemsTableReferences),
    DetectedItem,
    PrefetchHooks Function({bool sessionId, bool workId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorksTableTableManager get works =>
      $$WorksTableTableManager(_db, _db.works);
  $$EditionsTableTableManager get editions =>
      $$EditionsTableTableManager(_db, _db.editions);
  $$AuthorsTableTableManager get authors =>
      $$AuthorsTableTableManager(_db, _db.authors);
  $$WorkAuthorsTableTableManager get workAuthors =>
      $$WorkAuthorsTableTableManager(_db, _db.workAuthors);
  $$UserLibraryEntriesTableTableManager get userLibraryEntries =>
      $$UserLibraryEntriesTableTableManager(_db, _db.userLibraryEntries);
  $$ScanSessionsTableTableManager get scanSessions =>
      $$ScanSessionsTableTableManager(_db, _db.scanSessions);
  $$DetectedItemsTableTableManager get detectedItems =>
      $$DetectedItemsTableTableManager(_db, _db.detectedItems);
}
