$ErrorActionPreference = 'Stop'

# Drain Git’s refs input so the hook doesn’t block.
while ([Console]::In.ReadLine() -ne $null) { }

Write-Host "Checking for tracked .env files..."

$trackedEnv = (& git ls-files) | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '(^|[\\/])\.env$' }

if ($trackedEnv) {
    Write-Host ".env file detected: $($trackedEnv -join ', '). Push rejected." -ForegroundColor Red
    exit 1
}

Write-Host "No tracked .env files found. Push allowed." -ForegroundColor Green
exit 0