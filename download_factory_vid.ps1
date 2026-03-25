param($VideoUrl)

$DownloadPath = "C:\1stStepAI\factory_video.mp4"
$WebhookUrl = "param($VideoUrl)

$DownloadPath = "C:\1stStepAI\factory_video.mp4"
$WebhookUrl = "YOUR_DISCORD_WEBHOOK_URL"

# Download the video from 1688
Invoke-WebRequest -Uri $VideoUrl -OutFile $DownloadPath

# Post the video to Discord using a form-data request
curl.exe -H "Content-Type: multipart/form-data" `
         -F "file=@$DownloadPath" `
         -F "payload_json={\"content\": \"🔥 **NEW FACTORY FOOTAGE DETECTED** 🔥\nProduct: Jellyfish Lamp\nSource: 1688 Verified Supplier\"}" `
         $WebhookUrl"

# Download the video from 1688
Invoke-WebRequest -Uri $VideoUrl -OutFile $DownloadPath

# Post the video to Discord using a form-data request
curl.exe -H "Content-Type: multipart/form-data" `
         -F "file=@$DownloadPath" `
         -F "payload_json={\"content\": \"🔥 **NEW FACTORY FOOTAGE DETECTED** 🔥\nProduct: Jellyfish Lamp\nSource: 1688 Verified Supplier\"}" `
         $WebhookUrl