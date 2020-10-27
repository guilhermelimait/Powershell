# Version 0.3
clear-host
$channelname = "GuilhermeLimait"#Read-Host "What is the name of the channel? (This is the username of the channel uploader)"
$key = "AIzaSyBFboGP7KcIa1kH9tniXTiLf2Xe4nLngwI"
$file = "C:\dump\$channelname.txt"

Write-host "Remember to "

# Get the channel ID
$channelId = Invoke-WebRequest `
    "https://www.googleapis.com/youtube/v3/channels?part=snippet,id%2CcontentDetails%2Cstatistics&forUsername=$channelname&key=$key" | `
    ConvertFrom-Json | `
    Select-Object -ExpandProperty items | `
    Select-Object -ExpandProperty id

# Get list of videos from YouTube
$results = Invoke-WebRequest `
    "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=50&order=date&type=video&channelId=$channelId&key=$key" | `
    ConvertFrom-Json

    $results | Select-Object -ExpandProperty items | ` # Get all items from the search
    Select-Object -ExpandProperty id | ` # Expand the search results
    Select-Object -ExpandProperty videoId | ` # Extract the video IDs
    Add-Content $file # Append video IDs to a file
    $items = $results | Select-Object -ExpandProperty items # Get list of Videos remaining
    $nextpage = $results | Select-Object -ExpandProperty nextPageToken # Get token for the next page

# Keep moving to the next page and extracting until there is nothing left to extract
Do {
if (-not (!$items)) {
    $results = Invoke-WebRequest `
    "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=50&order=date&type=video&pageToken=$nextpage&channelId=$channelId&key=$key" | `
    ConvertFrom-Json

    $results | Select-Object -ExpandProperty items | ` # Get all items from the search
    Select-Object -ExpandProperty id | ` # Expand the search results
    Select-Object -ExpandProperty videoId | `
    Add-Content $file # Append video IDs to a file
    $items = $results | Select-Object -ExpandProperty items # Get list of Videos remaining
    $nextpage = $results | Select-Object -ExpandProperty nextPageToken # Get token for the next page
}
else {
    Exit
}
}
Until (!$items)