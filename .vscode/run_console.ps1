Param(
  [string]$Script = "study/laser/console_app.py"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$venvPath = Join-Path $repoRoot ".venv"
$activate = Join-Path $venvPath "Scripts/Activate.ps1"

if (-not (Test-Path $venvPath)) {
  Write-Host ".venv not found; creating virtual environment..."
  & python -m venv "$venvPath"
}

if (-not (Test-Path $activate)) {
  throw "Cannot find $activate"
}

Write-Host "Activating .venv..." -ForegroundColor Cyan
& $activate

if (Test-Path (Join-Path $repoRoot "requirements.txt")) {
  Write-Host "Installing requirements..." -ForegroundColor Cyan
  pip install -r (Join-Path $repoRoot "requirements.txt")
}

Write-Host "Running: $Script" -ForegroundColor Green
python (Join-Path $repoRoot $Script)

