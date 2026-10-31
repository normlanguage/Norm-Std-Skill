param(
  [string]$NormRoot = "..\Norm",
  [string]$ExpectedRevision = "741a0e1fdbfbc93c5b006d3971cb68fa4a55a1c6",
  [switch]$PrintRevision
)
if ($PrintRevision) { Write-Output $ExpectedRevision; exit 0 }
$revision = (git -C $NormRoot rev-parse HEAD).Trim()
if ($revision -ne $ExpectedRevision) { throw "Norm revision $revision does not match pinned revision $ExpectedRevision" }
$skill = Get-Content (Join-Path $PSScriptRoot "..\SKILL.md") -Raw
if ($skill -notmatch [regex]::Escape($ExpectedRevision)) { throw "SKILL.md does not contain the pinned Norm revision" }
if ($skill -notmatch "std\.process\.runProcess") { throw "SKILL.md is missing the process API" }
if ($skill -notmatch "std\.filesystem\.readText") { throw "SKILL.md is missing the filesystem API" }
if ($skill -notmatch "std\.logging\.logInfo") { throw "SKILL.md is missing application logging" }
if ($skill -notmatch "std\.application\.providers") { throw "SKILL.md is missing implementation discovery" }
foreach ($declaration in @('providers', 'LogOutputer', 'logInfo', 'runProcess', 'readText')) {
  if (!$skill.Contains('### ' + [char]96 + $declaration + [char]96)) { throw "SKILL.md is missing generated declaration $declaration" }
}
Write-Output "Norm-Std-Skill is pinned to $ExpectedRevision"

