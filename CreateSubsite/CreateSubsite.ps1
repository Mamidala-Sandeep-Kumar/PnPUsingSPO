<# SCRIPT SUMMARY : THIS SCRIPT HELPS TO CREATE Subsites 

#>

param
(

[Parameter(Mandatory=$True)] $siteCollectionUrl

)



$currentPath = Split-Path $MyInvocation.MyCommand.Path

#log file path
$LogFileName = $currentPath + "\Log.log"
 

#Connect-PnPOnline -Url $siteCollectionUrl -Credentials $PSCredentials 
Connect-PnPOnline -Url  $siteCollectionUrl –Credentials (Get-Credential) -ErrorAction silentlycontinue

#Set Path    
"$currentPath\Module\CreateSubsite.ps1"
$inputFile = $currentPath + '\Input\SubsiteDetails.csv'

#Invoke Function
CreateSubsite $inputFile $SiteCollection


# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{ 
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}