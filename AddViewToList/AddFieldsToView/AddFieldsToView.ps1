# Title: Add fields to view by reading values from the csv file.
# Description: This script helps to Add fields to view by reading values from the csv file.

# Parameters which user will input
param(
        # provide site Url
        [Parameter(Mandatory=$True)][string]$SiteCollection

        
    )



# current path is stored in a variable
$currentPath = Split-Path $MyInvocation.MyCommand.Path



# Connect to root site
 Connect-PnPOnline -Url  $SiteCollection -Credentials GetCredentials -ErrorAction silentlycontinue


#log file path
$LogFileName = $currentPath + "\Log.log"
 
#Add fields to view
. "$currentPath\Modules\FieldsToView.ps1"
$inputFile = $currentPath + '\Input\FieldsToView.csv'
AddFieldsToview $inputFile $SiteCollection

# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{ 
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}