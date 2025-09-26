$ErrorActionPreference = 'Stop'
$zeroSha = '0000000000000000000000000000000000000000'
$stdin = @()

while (-not [Console]::In.EndOfStream) {
    $line = [Console]::In.ReadLine()
    if ($line) { $stdin += $line }
}

Write-Host "Checking for .env files in push..."

foreach ($line in $stdin) {
    $parts = $line -split '\s+'
    if ($parts.Length -lt 4) { continue }

    $localSha = $parts[1]
    $remoteSha = $parts[3]

    if ($localSha -eq $zeroSha) { continue } # branch deletion

    $rangeArgs = if ($remoteSha -eq $zeroSha) { @($localSha) } else { @($remoteSha, $localSha) }
    $files = git diff --name-only --diff-filter=ACMR @rangeArgs

    if ($files | Where-Object { $_ -match '(^|[\\/])\.env$' }) {
        Write-Host ".env found in push. Push rejected." -ForegroundColor Red
        exit 1
    }
}

Write-Host "No .env file found, push allowed." -ForegroundColor Green
exit 0