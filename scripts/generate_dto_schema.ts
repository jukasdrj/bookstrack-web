#!/usr/bin/env tsx
/**
 * Generate JSON Schema from BendV3 Zod schemas
 *
 * Usage:
 *   npm run generate-schemas
 *   # or
 *   npx tsx generate_dto_schema.ts
 *
 * Environment:
 *   BENDV3_PATH - Path to BendV3 repo (default: ../../bendv3)
 *
 * Output:
 *   test/fixtures/bendv3_schemas.json
 */

import { zodToJsonSchema } from 'zod-to-json-schema'
import { writeFileSync, mkdirSync } from 'fs'
import { resolve } from 'path'

async function main() {
  // Determine BendV3 path (support custom via env var)
  const bendv3Path = process.env.BENDV3_PATH || '../../bendv3'

  // Dynamically import BendV3 schema
  const schemaPath = resolve(__dirname, bendv3Path, 'src/api-v3/schemas/book.ts')

  let BookSchema
  try {
    // Use dynamic import for ESM/CJS compatibility
    const module = await import(schemaPath)
    BookSchema = module.BookSchema

    if (!BookSchema) {
      throw new Error('BookSchema not found in module exports')
    }
  } catch (error) {
    console.error('❌ Failed to load BendV3 schema from:', schemaPath)
    console.error('💡 Set BENDV3_PATH environment variable or ensure BendV3 is at ../../bendv3')
    console.error('')
    console.error('Example:')
    console.error('  BENDV3_PATH=/path/to/bendv3 npx tsx generate_dto_schema.ts')
    console.error('')
    console.error('Error details:', error)
    process.exit(1)
  }

  // Convert Zod schema to JSON Schema
  const bookJsonSchema = zodToJsonSchema(BookSchema, {
    name: 'BookSchema',
    target: 'openApi3',
    $refStrategy: 'none',
  })

  const schemas = {
    Book: bookJsonSchema,
  }

  const output = {
    $schema: 'http://json-schema.org/draft-07/schema#',
    title: 'BendV3 API Schemas',
    description: 'Generated from BendV3 Zod schemas - DO NOT EDIT MANUALLY',
    note: 'Run `npm run generate-schemas` to regenerate this file after BendV3 updates',
    generatedAt: new Date().toISOString(),
    bendv3Path: schemaPath,
    schemas,
  }

  // Ensure fixtures directory exists
  const fixturesDir = resolve(__dirname, '../test/fixtures')
  mkdirSync(fixturesDir, { recursive: true })

  const outputPath = resolve(fixturesDir, 'bendv3_schemas.json')
  writeFileSync(outputPath, JSON.stringify(output, null, 2))

  console.log('✅ Generated JSON schemas from BendV3 Zod definitions')
  console.log('📁 Output:', outputPath)
  console.log('📊 Schemas:', Object.keys(schemas).join(', '))
  console.log('')
  console.log('Book schema properties:', Object.keys(bookJsonSchema.properties || {}).length)
}

// Run main function
main().catch((error) => {
  console.error('❌ Error:', error)
  process.exit(1)
})
