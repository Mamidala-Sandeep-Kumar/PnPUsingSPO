<# SCRIPT SUMMARY : THIS SCRIPT HELPS TO Delete the CDS Lists

Specify the below details

#>

param
(
[Parameter(Mandatory=$True)] $siteCollectionUrl

)

$currentPath = Split-Path $MyInvocation.MyCommand.Path

#log file path
$LogFileName = $currentPath + "\Log.log"
    
    Connect-PnPOnline -Url  $siteCollectionUrl –Credentials (Get-Credential) -ErrorAction silentlycontinue
      
  . "$currentPath\Module\DeleteList.ps1"
    $inputFile = $currentPath + '\Input\ListDetails.csv'

    DeleteList $inputFile $SiteCollection


# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{ 
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}           
      

 