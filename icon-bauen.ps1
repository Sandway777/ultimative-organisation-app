# Erzeugt notizblock.ico fuer die Desktop-Verknuepfung.
#
# Quelle ist icon-desktop.png, nicht icon-512.png: Leon nutzt am Rechner ein
# anderes Logo als am Handy. icon-512.png gehoert der PWA (Homescreen-Icon am
# iPhone) und darf hier nicht durchschlagen.
#
# Warum eigenes Skript und nicht inline im .bat: Windows-Verknuepfungen koennen
# kein PNG als Icon, es muss eine .ico sein. Und die .ico muss im klassischen
# DIB-Format geschrieben werden - eine eingebettete PNG akzeptiert der
# Verknuepfungs-Dialog nicht zuverlaessig.

Add-Type -AssemblyName System.Drawing

$dir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$ico  = Join-Path $dir "notizblock.ico"
$png  = Join-Path $dir "icon-desktop.png"
if (-not (Test-Path $png)) { $png = Join-Path $dir "icon-512.png" }   # Rueckfall
$size = 128

if (-not (Test-Path $png)) { Write-Host "  Kein Logo gefunden"; exit 1 }

$src = New-Object System.Drawing.Bitmap($png)
$bmp = New-Object System.Drawing.Bitmap($size, $size, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb))
$gfx = [System.Drawing.Graphics]::FromImage($bmp)
$gfx.InterpolationMode = 'HighQualityBicubic'
$gfx.SmoothingMode     = 'HighQuality'
$gfx.PixelOffsetMode   = 'HighQuality'
$gfx.DrawImage($src, 0, 0, $size, $size)
$gfx.Dispose(); $src.Dispose()

# Pixel am Stueck holen statt Punkt fuer Punkt
$rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
$dat  = $bmp.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadOnly,
                      [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$roh  = New-Object 'Byte[]' ($size * $size * 4)
[System.Runtime.InteropServices.Marshal]::Copy($dat.Scan0, $roh, 0, $roh.Length)
$bmp.UnlockBits($dat); $bmp.Dispose()

# BITMAPINFOHEADER: doppelte Hoehe, weil danach die AND-Maske folgt
$ms = New-Object System.IO.MemoryStream
$bw = New-Object System.IO.BinaryWriter($ms)
$bw.Write([UInt32]40); $bw.Write([Int32]$size); $bw.Write([Int32]($size * 2))
$bw.Write([UInt16]1);  $bw.Write([UInt16]32);   $bw.Write([UInt32]0)
$bw.Write([UInt32]($size * $size * 4)); $bw.Write([Int32]2835); $bw.Write([Int32]2835)
$bw.Write([UInt32]0); $bw.Write([UInt32]0)
for ($y = $size - 1; $y -ge 0; $y--) { $bw.Write($roh, $y * $size * 4, $size * 4) }
$maskeZeile = [int][math]::Ceiling($size / 32) * 4
$leer = New-Object 'Byte[]' $maskeZeile
for ($y = 0; $y -lt $size; $y++) { $bw.Write($leer) }
$bw.Flush(); $dib = $ms.ToArray()

$fs = [System.IO.File]::Create($ico)
$w  = New-Object System.IO.BinaryWriter($fs)
$w.Write([UInt16]0); $w.Write([UInt16]1); $w.Write([UInt16]1)
$w.Write([Byte]$size); $w.Write([Byte]$size); $w.Write([Byte]0); $w.Write([Byte]0)
$w.Write([UInt16]1); $w.Write([UInt16]32)
$w.Write([UInt32]$dib.Length); $w.Write([UInt32]22)
$w.Write($dib); $w.Close(); $fs.Close()

# Gegenprobe - eine kaputte .ico faellt sonst erst auf dem Desktop auf
try {
  $t = New-Object System.Drawing.Icon($ico); $t.Dispose()
  Write-Host "  Icon erstellt."
} catch {
  Write-Host "  Icon konnte nicht erstellt werden: $_"
  exit 1
}
