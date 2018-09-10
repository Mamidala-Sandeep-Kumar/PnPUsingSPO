# Function to delete content type 
function DeleteCT($inputFilePath,$SiteCollection) {

try
{ 
    # Import the csv file and store it in a variable
	$input = import-csv $inputFilePath
    
    # Looping the csv file collection
    foreach($row in $input)
    { 
        $ContentTypeName = $row.ContentTypeName
        # get the content type
	    $ctype = Get-PnPContentType -Identity $ContentTypeName
	    # if CT exists 
	    if ($ctype) { 
	
	    # remove the CT from site
	    Remove-PnPContentType -Identity $ContentTypeName -Force
	    Write-Host "Content Type: '"$ContentTypeName"' - deleted" -ForegroundColor green
  
        } 
	    else
	    {
	     Write-Host "Content Type: '"$ContentTypeName"' - already deleted!" -ForegroundColor green
	    }
    
    
    }# End of CSV row iteration
 
} 
catch 
{ 
    Write-Host "Error connecting to SharePoint Online: $_.Exception.Message" -foregroundcolor black -backgroundcolor Red 
    return 
} 


}