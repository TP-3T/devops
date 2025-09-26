$ErrorActionPreference = 'Stop'
$zeroSha = '0000000000000000000000000000000000000000'
$stdin = @()

while ($true) {
    $line = [Console]::In.ReadLine()
    if ($line -eq $null) { break }
    $stdin += $line
}

Write-Host "Checking for .env files in push..."

foreach ($line in $stdin) {
    $parts = $line -split '\s+'
    if ($parts.Length -lt 4) { continue }

    $localSha = $parts[1]
    $remoteSha = $parts[3]

    if ($localSha -eq $zeroSha) { continue }

    if ($remoteSha -eq $zeroSha) {
        $files = git diff-tree --no-commit-id --name-only -r $localSha
    } else {
        $files = git diff --name-only $remoteSha $localSha
    }

    foreach ($file in $files) {
        $trimmed = $file.Trim()
        if ([System.IO.Path]::GetFileName($trimmed) -eq '.env') {
            Write-Host ".env found in push. Push rejected." -ForegroundColor Red
            exit 1
        }
    }
}

Write-Host "No .env file found, push allowed." -ForegroundColor Green
exit 0