param(
  [Parameter(Mandatory)][string]$NormRoot,
  [string]$NormExecutable = "norm"
)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$revision = (git -C $NormRoot rev-parse HEAD).Trim()
if ($LASTEXITCODE -ne 0) { throw 'Cannot resolve the Norm source revision' }
$expected = & (Join-Path $PSScriptRoot 'verify.ps1') -PrintRevision
if ($revision -cne $expected) { throw "Norm revision $revision does not match pinned revision $expected" }
$temporary = Join-Path $root '.tmp/docs'
New-Item -ItemType Directory -Force $temporary | Out-Null
$generated = Join-Path $temporary 'generated.md'
& $NormExecutable docs (Join-Path $NormRoot 'norm/stdlib/std') --output (Join-Path $temporary 'api') --skill $generated --strict
if ($LASTEXITCODE -ne 0) { throw 'Standard library API generation failed' }
$header = @"
# Norm Standard Library Skill

Norm source revision: $revision

Generated declarations and signatures follow below. Source indexes:

- [std.application.providers](https://github.com/normlanguage/Norm/blob/$revision/norm/stdlib/std/application/application.norm)
- [std.logging.logInfo](https://github.com/normlanguage/Norm/blob/$revision/norm/stdlib/std/logging/log.norm)
- [std.filesystem.readText](https://github.com/normlanguage/Norm/blob/$revision/norm/stdlib/std/filesystem/files.norm)
- [std.process.runProcess](https://github.com/normlanguage/Norm/blob/$revision/norm/stdlib/std/process/process.norm)

"@
$content = $header + [Environment]::NewLine + [IO.File]::ReadAllText($generated).TrimEnd() + [Environment]::NewLine
[IO.File]::WriteAllText((Join-Path $root 'SKILL.md'), $content.Replace("`r`n", "`n"))
