#FUNCTION TO Delete Subsite 

function DeleteSubsite($inputFilePath,$SiteCollection) {
try
	   {
 
    # Import the csv file and store it in a variable
	$input = import-csv $inputFilePath
    
    foreach($row in $input)
    { 
	   $SubsiteName = $row.SubsiteName
	  
	   
	   # Get the subsite
	   $subsite = Get-PnPWeb $SubsiteName -ErrorAction SilentlyContinue
	   
	   #Check if subsite exists
	   if($subsite)
	   { 
	     #Delete subsite
		 Remove-PnPWeb -Identity $SubsiteName -Force -ErrorAction SilentlyContinue
	     Write-Host "Subsite: '$SubsiteName' deleted successfully." -ForegroundColor green
	   }
	   else
	   {
	     
		 Write-Host "Subsite: '$SubsiteName' already deleted or does not exist!!" -ForegroundColor green
	   }
 
}
}
catch 
{ 
    Write-Host "Error connecting to SharePoint Online: $_.Exception.Message" -foregroundcolor red 
    return 
} 
}
