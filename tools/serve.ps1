# Tiny local web server for previewing the portfolio.
# Started by start-preview.bat. Close this window to stop it.

$root = Split-Path -Parent $PSScriptRoot
$port = 5500
$listener = $null

# Find a free port
while ($port -lt 5520 -and -not $listener) {
  try {
    $l = [System.Net.HttpListener]::new()
    $l.Prefixes.Add("http://localhost:$port/")
    $l.Start()
    $listener = $l
  } catch { $port++ }
}
if (-not $listener) { Write-Host "No free port found (5500-5519)."; Read-Host "Press Enter to close"; exit 1 }

$url = "http://localhost:$port/"
Write-Host ""
Write-Host "  Portfolio preview running at $url"
Write-Host "  Save a JSON file and refresh the browser to see changes."
Write-Host "  Close this window to stop the preview."
Write-Host ""
Start-Process $url

$types = @{
  ".html" = "text/html; charset=utf-8"; ".css" = "text/css; charset=utf-8"; ".js" = "application/javascript; charset=utf-8"
  ".json" = "application/json; charset=utf-8"; ".png" = "image/png"; ".jpg" = "image/jpeg"; ".jpeg" = "image/jpeg"
  ".gif" = "image/gif"; ".webp" = "image/webp"; ".avif" = "image/avif"; ".svg" = "image/svg+xml"; ".ico" = "image/x-icon"
  ".mp4" = "video/mp4"; ".webm" = "video/webm"; ".woff2" = "font/woff2"; ".pdf" = "application/pdf"
}

while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  try {
    $path = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart("/"))
    if ($path -eq "") { $path = "index.html" }
    $file = [IO.Path]::GetFullPath((Join-Path $root $path))

    if ($file.StartsWith($root) -and (Test-Path $file -PathType Leaf)) {
      $bytes = [IO.File]::ReadAllBytes($file)
      $type = $types[[IO.Path]::GetExtension($file).ToLower()]
      if ($type) { $ctx.Response.ContentType = $type }
      $ctx.Response.Headers.Add("Cache-Control", "no-store")
      $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
      $ctx.Response.StatusCode = 404
    }
  } catch {
    $ctx.Response.StatusCode = 500
  } finally {
    $ctx.Response.Close()
  }
}
