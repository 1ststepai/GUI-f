cd C:\1stStepAI
git add .
git commit -m "Auto-update: $(Get-Date -Format 'MM-dd-yyyy HH:mm')"
git push origin main
Write-Host "🚀 Updates pushed to GitHub successfully!" -ForegroundColor Green