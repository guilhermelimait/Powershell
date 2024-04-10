

$number = "+393665802655"
$message = "Howdy, this is a message from PowerShell."

$clientId = "FREE_TRIAL_ACCOUNT"  # No need to change
$clientSecret = "PUBLIC_SECRET"   # No need to change

$jsonObj = @{'number'=$number;
             'message'=$message;}

Try {
  $res = Invoke-WebRequest -Uri 'http://api.whatsmate.net/v1/whatsapp/queue/message' `
                          -Method Post   `
                          -Headers @{"X-WM-CLIENT-ID"=$clientId; "X-WM-CLIENT-SECRET"=$clientSecret;} `
                          -Body (ConvertTo-Json $jsonObj)

  Write-host "Status Code: "  $res.StatusCode
  Write-host $res.Content
}
Catch {
  $result = $_.Exception.Response.GetResponseStream()
  $reader = New-Object System.IO.StreamReader($result)
  $reader.BaseStream.Position = 0
  $reader.DiscardBufferedData()
  $responseBody = $reader.ReadToEnd();

  Write-host "Status Code: " $_.Exception.Response.StatusCode
  Write-host $responseBody
}