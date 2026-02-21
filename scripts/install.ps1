Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-RepoSlug {
  param([string]$Repo)
  $slug = $Repo -replace '^https?://github.com/', ''
  $slug = $slug -replace '\.git$', ''
  return $slug
}

function Install-D2Skill {
  param(
    [ValidateSet('Project', 'Global')]
    [string]$Scope = 'Project',

    [ValidateSet('Local', 'Remote')]
    [string]$Source = 'Local',

    [string]$Repo = '',
    [string]$Ref = 'main'
  )

  if ($Scope -eq 'Global') {
    $dest = Join-Path $HOME '.claude/skills/d2-diagram'
  } else {
    $dest = Join-Path (Get-Location).Path '.claude/skills/d2-diagram'
  }

  $src = $null
  $tempDir = $null

  if ($Source -eq 'Local') {
    $scriptDir = Split-Path -Parent $PSCommandPath
    $root = Resolve-Path (Join-Path $scriptDir '..')
    $candidateA = Join-Path $root 'skills/d2-diagram'
    $candidateB = Join-Path (Get-Location).Path 'skills/d2-diagram'

    if (Test-Path $candidateA) {
      $src = $candidateA
    } elseif (Test-Path $candidateB) {
      $src = $candidateB
    } else {
      throw 'Local source not found. Expected skills/d2-diagram in repo root or current directory.'
    }
  } else {
    if (-not $Repo) {
      throw '--Repo is required when -Source Remote'
    }

    $slug = Resolve-RepoSlug -Repo $Repo
    $zipHeadUrl = "https://github.com/$slug/archive/refs/heads/$Ref.zip"
    $zipTagUrl = "https://github.com/$slug/archive/refs/tags/$Ref.zip"

    $tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Path $tempDir | Out-Null
    $zipPath = Join-Path $tempDir 'repo.zip'

    try {
      Invoke-WebRequest -Uri $zipHeadUrl -OutFile $zipPath
    } catch {
      Invoke-WebRequest -Uri $zipTagUrl -OutFile $zipPath
    }
    Expand-Archive -Path $zipPath -DestinationPath $tempDir

    $repoName = ($slug -split '/')[1]
    $extract = Join-Path $tempDir "$repoName-$Ref"
    if (-not (Test-Path $extract)) {
      $extract = Get-ChildItem -Path $tempDir -Directory | Select-Object -First 1 | ForEach-Object { $_.FullName }
    }

    $src = Join-Path $extract 'skills/d2-diagram'
    if (-not (Test-Path $src)) {
      throw 'Remote source does not contain skills/d2-diagram'
    }
  }

  $destParent = Split-Path -Parent $dest
  New-Item -ItemType Directory -Force -Path $destParent | Out-Null
  if (Test-Path $dest) {
    Remove-Item -Recurse -Force $dest
  }
  Copy-Item -Recurse -Force $src $dest

  if ($tempDir -and (Test-Path $tempDir)) {
    Remove-Item -Recurse -Force $tempDir
  }

  Write-Host "Installed d2-diagram to $dest"
}
