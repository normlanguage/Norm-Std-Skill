param(
  [string]$NormRoot = "..\Norm",
  [string]$ExpectedRevision = "291eb53b8b6afa3668522d5f6774f3f34f960cc7",
  [switch]$PrintRevision
)
if ($PrintRevision) { Write-Output $ExpectedRevision; exit 0 }
$revision = (git -C $NormRoot rev-parse HEAD).Trim()
if ($revision -ne $ExpectedRevision) { throw "Norm revision $revision does not match pinned revision $ExpectedRevision" }
$skill = Get-Content (Join-Path $PSScriptRoot "..\SKILL.md") -Raw
if ($skill -notmatch [regex]::Escape($ExpectedRevision)) { throw "SKILL.md does not contain the pinned Norm revision" }
if ($skill -notmatch "std\.process\.runProcess") { throw "SKILL.md is missing the process API" }
if ($skill -notmatch "std\.filesystem\.readText") { throw "SKILL.md is missing the filesystem API" }
Write-Output "Norm-Std-Skill is pinned to $ExpectedRevision"

