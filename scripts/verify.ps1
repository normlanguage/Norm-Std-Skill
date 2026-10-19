param(
  [string]$NormRoot = "..\Norm",
  [string]$ExpectedRevision = "a704d53d1b55afa59a5fa69a9f19183a8312381b"
)
$revision = (git -C $NormRoot rev-parse HEAD).Trim()
if ($revision -ne $ExpectedRevision) { throw "Norm revision $revision does not match pinned revision $ExpectedRevision" }
$skill = Get-Content (Join-Path $PSScriptRoot "..\SKILL.md") -Raw
if ($skill -notmatch [regex]::Escape($ExpectedRevision)) { throw "SKILL.md does not contain the pinned Norm revision" }
if ($skill -notmatch "std\.process\.runProcess") { throw "SKILL.md is missing the process API" }
if ($skill -notmatch "std\.filesystem\.readText") { throw "SKILL.md is missing the filesystem API" }
Write-Output "Norm-Std-Skill is pinned to $ExpectedRevision"

