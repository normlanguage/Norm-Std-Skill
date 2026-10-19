# Norm Standard Library Skill

This skill describes the public `std` module shipped with Norm. It is generated from the Norm standard-library sources and their `@Document` annotations.

- Norm source revision: `a704d53d1b55afa59a5fa69a9f19183a8312381b`
- Standard library module: `std` version `1`
- Source: https://github.com/normlanguage/Norm/tree/a704d53d1b55afa59a5fa69a9f19183a8312381b/norm/stdlib/std
- API export command: `norm docs norm/stdlib/std --output build/std-api --skill SKILL.md --strict`

## Usage

Use the exact imports and signatures from the API documentation generated with this skill. Do not invent declarations. The `std` module is exported by package and source file, including `std.io`, `std.filesystem`, `std.process`, `std.application`, `std.cli`, `std.http`, `std.json`, `std.collections`, `std.text`, `std.time`, `std.validation`, `std.serialization`, `std.websocket`, and `std.yaml`.

## Capability index

### Application and CLI

- `std.application.arguments()` returns the application argument sequence.
- `std.application.environmentVariable(name:)` reads one environment variable.
- `std.application.applicationDirectory()` and `workingDirectory()` return application paths.
- `std.cli.CommandLine` declares options, parses arguments, and produces help text.

### Console and streams

- `std.io.print(text:)` writes standard output.
- `std.io.printError(text:)` writes standard error.
- `std.io.standardInput()` returns a `ByteReader`.
- `ByteReader.read(maximumBytes:)` returns `ReadChunk.Data` or `ReadChunk.Eof`.
- Input is a byte stream. A line-oriented caller must buffer chunks, decode UTF-8, and handle both LF and CRLF. `readAll` waits for EOF and is not an interactive line reader.

### Filesystem

- `std.filesystem.Path` represents a filesystem path.
- `std.filesystem.readText(path:, encoding:, maximumBytes:)` reads bounded text.
- `std.filesystem.writeTextAtomic(path:, text:, encoding:)` writes text atomically.
- `std.filesystem.openRead(path:)` and `openWrite(path:, mode:)` expose stream ownership.
- Directory enumeration is not part of the current `std.filesystem` surface. Do not call `std.filesystem.listDirectory` unless it is present in the installed API export.

### Processes

- `std.process.runProcess(executable:, arguments:, directory:, environment:, input:, timeout:, maximumOutputBytes:)` runs one executable with structured argument boundaries.
- The result exposes stdout, stderr, outcome, exit code, and truncation information.
- `std.process.run` is not a standard-library declaration.

### Data and protocols

Use the `std.json`, `std.yaml`, `std.xml`, `std.http`, and `std.websocket` packages only through their generated declarations and documented resource lifecycle. Prefer typed values and bounded operations.

## Source of truth

The Norm source files and `@Document` annotations are authoritative. This file is a generated distribution artifact. Regenerate it when the pinned Norm revision changes; do not hand-edit API signatures.

