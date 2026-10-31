# Norm-Std-Skill

Published agent skill for Norm's standard library. `SKILL.md` is generated from the Norm standard-library module and is pinned to a Norm commit.

## Regeneration

From a Norm checkout at the pinned revision:

```powershell
./scripts/generate.ps1 -NormRoot ../Norm
./scripts/verify.ps1 -NormRoot ../Norm
```

The generated file must be committed together with the Norm source revision it describes. Use the repository verification script before publishing.
