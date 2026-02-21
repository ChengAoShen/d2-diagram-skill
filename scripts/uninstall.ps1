Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Uninstall-D2Skill {
  param(
    [ValidateSet('Project', 'Global')]
    [string]$Scope = 'Project'
  )

  if ($Scope -eq 'Global') {
    $dest = Join-Path $HOME '.claude/skills/d2-diagram'
  } else {
    $dest = Join-Path (Get-Location).Path '.claude/skills/d2-diagram'
  }

  if (Test-Path $dest) {
    Remove-Item -Recurse -Force $dest
  }

  Write-Host "Removed $dest"
}
