$ErrorActionPreference = 'Stop'

# on push, git reads a bunch of lines into stdin, if we don't consume
# these lines, the hook never gets a chance to check files
while ([Console]::In.ReadLine() -ne $null) { }

Write-Host "Checking for tracked .env files..."

# list all tracked files, fliter for .env pattern matching
$trackedEnv = (& git ls-files) | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '(^|[\\/])\.env$' }

if ($trackedEnv) {
    Write-Host ".env file detected: $($trackedEnv -join ', '). Push rejected." -ForegroundColor Red
    exit 1
}

Write-Host "No .env found, push allowed" -ForegroundColor Green
exit 0