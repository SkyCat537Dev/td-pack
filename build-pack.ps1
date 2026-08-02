# Rebuilds resourcepack.zip from the assets in this folder and prints the SHA1
# that server.properties needs.
#
# Built through System.IO.Compression rather than Compress-Archive, and the one
# line that matters is the Replace: Windows PowerShell 5.1's Compress-Archive
# writes entry names with BACKSLASH separators, and a Minecraft resource pack
# built that way is not a broken pack, it is an empty one. The client opens it,
# finds nothing at any path it looks for, and applies a pack with no assets in
# it, so every custom tooltip frame quietly reverts to vanilla and nothing
# anywhere reports an error. Zip entry names are POSIX paths, always.

Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = $PSScriptRoot
$out = Join-Path $root 'resourcepack.zip'
$sep = [string][char]92

if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out -Force }

$zip = [System.IO.Compression.ZipFile]::Open($out, 'Create')
try {
    $items = @()
    $items += Get-ChildItem -LiteralPath (Join-Path $root 'assets') -Recurse -File | Sort-Object FullName
    $items += Get-Item -LiteralPath (Join-Path $root 'pack.mcmeta')
    $items += Get-Item -LiteralPath (Join-Path $root 'pack.png')
    foreach ($f in $items) {
        $rel = $f.FullName.Substring($root.Length + 1).Replace($sep, '/')
        [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $f.FullName, $rel, 'Optimal')
    }
} finally {
    $zip.Dispose()
}

# Refuse to hand over a pack that cannot be read, rather than printing a SHA1
# for it. A separator bug is invisible in game, so it has to be caught here.
$check = [System.IO.Compression.ZipFile]::OpenRead($out)
$bad = @($check.Entries | Where-Object { $_.FullName.Contains($sep) }).Count
$count = $check.Entries.Count
$check.Dispose()
if ($bad -gt 0) {
    Write-Error "$bad of $count entries use backslash separators, the pack would read as empty."
    exit 1
}

Write-Output "Packed $count files."
Write-Output ''
Write-Output 'New SHA1:'
(Get-FileHash -LiteralPath $out -Algorithm SHA1).Hash.ToLower()
Write-Output ''
Write-Output 'Commit and push, then put that SHA1 in server.properties.'
