$ErrorActionPreference = 'Stop'
$zeroSha = '0000000000000000000000000000000000000000'
$forbiddenPattern = '(^|[\\/])\.env$'
$stdin = @()

while (-not [Console]::In.EndOfStream) {
    $line = [Console]::In.ReadLine()
    if ($line) { $stdin += $line }
}

Write-Host "Checking for .env files in push..."

foreach ($line in $stdin) {
    $parts = $line -split '\s+'
    if ($parts.Length -lt 4) { continue }

    $localSha  = $parts[1]
    $remoteSha = $parts[3]

    if ($localSha -eq $zeroSha) { continue } # branch deletion

    $commitRange = if ($remoteSha -eq $zeroSha) {
        & git rev-list $localSha
    } else {
        & git rev-list "$remoteSha..$localSha"
    }

    foreach ($commit in $commitRange) {
        $files = & git diff-tree --no-commit-id --name-only -r $commit
        if ($files | Where-Object { $_.Trim() -match $forbiddenPattern }) {
            Write-Host ".env found in push (commit $commit). Push rejected." -ForegroundColor Red
            exit 1
        }
    }
}

Write-Host "No .env file found, push allowed." -ForegroundColor Green
exit 0