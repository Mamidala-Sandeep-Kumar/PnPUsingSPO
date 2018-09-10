<# SCRIPT SUMMARY : THIS SCRIPT HELPS TO Delete the site Column. Firat Delete from the List, Content Type then delete the Site Column.

#>

param
(
[Parameter(Mandatory=$True)] $siteCollectionUrl

)

#Set current directory path
$currentPath = Split-Path $MyInvocation.MyCommand.Path

#log file path
$LogFileName = $currentPath + "\Log.log"
 
 #connect with SPO using Prompt Credentails
    Connect-PnPOnline -Url  $siteCollectionUrl –Credentials (Get-Credential) -ErrorAction silentlycontinue

    
  . "$currentPath\Module\DeleteSiteColumnMethod.ps1"
    $inputFile = $currentPath + '\Input\DeleteSiteColumnDetails.csv'

    DeleteSiteColumn $inputFile $SiteCollection

# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{ 
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}