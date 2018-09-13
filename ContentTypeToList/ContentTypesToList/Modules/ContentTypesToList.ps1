# Function to add CT to a list	
function AddCT_list($inputFilePath,$SiteCollection) {
 try
 {

	# Import the csv file and store it in a variable
    $input = import-csv $inputFilePath
		   
	# Looping the csv file collection
	foreach($row in $input) { 
	
	$ContentTypeName = $row.ContentTypeName
	$ListName = $row.ListName
	# get the content type from list
	
	$lt = Get-PnPList -Identity $ListName -ErrorAction SilentlyContinue
	$ctexists = Get-PnPContentType -Identity $ContentTypeName -ErrorAction SilentlyContinue
	
	$ct = Get-PnPContentType -List $ListName -Identity $ContentTypeName -ErrorAction SilentlyContinue
	
	if($ct)
	{
	  Write-Host "Content Type: '"$ContentTypeName "' - already added to the list: '"$ListName "' " -ForegroundColor green
	}
	  
	else
	{ 
	    if($ctexists)
		{
	    if($lt)
		{
		# add CT to list
		$ctexists = Add-PnPContentTypeToList -List $ListName -ContentType $ContentTypeName -DefaultContentType
		Write-Host "Content Type: $ContentTypeName - added to the list: $ListName" -ForegroundColor green
		}
		else
		{
		  Write-Host "List: '"$ListName "' doesn't exist!!" -ForegroundColor green
		} 
	   }
	   else
	   {
	     Write-Host "Content Type: '"$ContentTypeName "' doesn't exist!!" -ForegroundColor green
	   }
    }
}

}

catch { 
    Write-Host "Error occured!: $_.Exception.Message" -foregroundcolor red 
    return 
} 
}








