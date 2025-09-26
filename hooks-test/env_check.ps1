# ACM filter looks for Added, Copied, Renamed, Modified files
$files = git diff --cached --name-only --diff-filter=ACRM

Write-Host "Checking for .env files in push..."

foreach ($file in $files)
{
    if ($file.EndsWith(".env") -or $file -eq ".env") {
        Write-Host ".env found in push: $file" -ForegroundColor Red
        Write-Host "Push rejected. Add sensitive files to gitignore and try again" -ForegroundColor Red
        exit 1
    }
}

Write-Host "No .env file found, push allowed" -ForegroundColor Green
exit 0