$rawContent = Invoke-WebRequest -Uri 'https://www.reddit.com/r/All.json'
$content = $rawContent.Content
$convertedContent = $content | ConvertFrom-Json
$posts = $convertedContent.data.children.data
$posts = $posts | Select-Object title,ups,url | Sort-Object ups -Descending | Select-Object -First 5
$iterate = 0
foreach ($item in $posts){
$current = $posts | Select-Object title |Sort-Object ups -Descending | Select-Object -Skip $iterate | Select-Object -First 1
$current = $current.TrimStart('@{title=')
$current = $current.TrimEnd('}')
$length = $current.Length
[string]$ups = $posts | Select-Object ups | Sort-Object ups -Descending | Select-Object -Skip $iterate | Select-Object -First 1
$ups = $ups.TrimStart('@{ups=')
$ups = $ups.TrimEnd('}')
[string]$url = $posts | Select-Object url | Sort-Object ups -Descending | Select-Object -Skip $iterate | Select-Object -First 1
$url = $url.TrimStart('@{url=')
$url = $url.TrimEnd('}')
if ($length -gt 50)
{
$current = $current.Substring(0, 50)
}
Write-Host $current, $url, $ups
$iterate = $iterate + 1
}

$rawContent = Invoke-RestMethod -Uri 'https://www.bleepingcomputer.com/feed/'
$content = $rawContent | Select-Object -First 5

$rawContent = Invoke-RestMethod -Uri 'https://krebsonsecurity.com/feed/'
$content = $rawContent | Select-Object -First 5

$rawContent = Invoke-RestMethod -Uri 'https://isc.sans.edu/dailypodcast.xml'
$content = $rawContent | Select-Object -First 5
$content