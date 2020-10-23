Add-Type -AssemblyName presentationCore
$mediaPlayer = New-Object system.windows.media.mediaplayer
$mediaPlayer.open('C:\Users\guilh\Music\MAGIC! - Don_t Kill the Magic - Rude.mp3')
$mediaPlayer.Play()