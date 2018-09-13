# Title: Delete content types from list by reading values from the csv file.
# Description: This script helps to Delete content types from list by reading values from the csv file.


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
 
#Delete content types from list
. "$currentPath\Modules\DeleteContentTypesFromList.ps1"
$inputFile = $currentPath + '\Input\ContentTypeToList.csv'
DeleteCTFromSubsite $inputFile $SiteCollection

# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{ 
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}

