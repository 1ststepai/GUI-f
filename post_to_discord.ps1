$WebhookUrl = "https://discord.com/api/webhooks/1486236333331583106/4fwLJmEGPCChIaqySApcHXgjK5DFpRcZdTn29VlSYdtzSwpwoahmNR73auVyFk_Sd3en"

# Read the latest research report
$ReportPath = "C:\1stStepAI\Sourcing_Report.md"
if (Test-Path $ReportPath) {
    $Content = Get-Content $ReportPath -Raw
    $Payload = @{
        content = "🚀 **NEW VIRAL OPPORTUNITY DETECTED** 🚀`n`n$Content"
    } | ConvertTo-Json
    
    Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $Payload -ContentType 'application/json'
}