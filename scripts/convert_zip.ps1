# Powershell Script to recurse input path looking for .bak files, Zip them
# and delete the .bak.

function out-zip {
  Param([string]$path)
  if (-not $path.EndsWith('.zip')) {$path += '.zip'}
  if (-not (test-path $path)) {
    set-content $path ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
  }
  $ZipFile = (new-object -com shell.application).NameSpace($path)
  $input | foreach {$zipfile.CopyHere($_.fullname)} | out-null
}
$FileCount =0
$FilesZipped =0
$FilesDeleted =0
$InputPath = $args[0]
if($InputPath.Length -lt 2)
{
    Write-Host "Please supply a path name as your first argument" -foregroundcolor Red
    return
}
if(-not (Test-Path $InputPath))
{
    Write-Host "Path does not appear to be valid" -foregroundcolor Red
    return
}
$BakFiles = Get-ChildItem $InputPath -Include *.bak -recurse
Foreach ($Bak in $BakFiles)
{
write-host "File: $Bak" -foregroundcolor Yellow
$ZipFile = $Bak.FullName -replace ".bak", ".zip"
if (Test-Path $ZipFile)
{
    Write-Host "$ZipFile exists already, aborted." -foregroundcolor Red
}
else
{
    Get-Item $Bak | out-zip $ZipFile
    if(Test-Path $ZipFile)
    {
        $Response = "c"
        $Response = read-host -prompt "Please wait for zip to complete then type c<enter> to continue..."
        if($Response = "c")
        {
            $FilesZipped++
            Remove-Item $Bak.FullName
            if(Test-Path $Bak.FullName)
            {
                Write-Host "File not deleted, manually remove $Bak.Fullname" -foregroundcolor Red
            }
            else
            {
                Write-Host "OK" -foregroundcolor Green
                $FilesDeleted++
            }
        }
        else
        {
            Write-Host "File delete aborted by user" -foregroundcolor Red
        }
    }
}
$FileCount++
}
Write-Host Files found: $FileCount
Write-Host Files Zipped: $FilesZipped
Write-Host Files Deleted: $FilesDeleted