
#FUNCTION TO Delete List

function DeleteList($inputFilePath,$SiteCollection) {
 
try
{ 
    # Import the csv file and store it in a variable
	$input = import-csv $inputFilePath
    
	
    foreach($row in $input)
    { 
	   # retrieve the list from csv file
	   $ListName = $row.ListName
	   
	   
          $lt = Get-PnPList -Identity $ListName 
               
		   if($lt)
		   {
		   Remove-PnpList -Identity $ListName -Force
		   Write-Host "List '"$ListName"' deleted Successfully." -foregroundcolor green
					   
			}
	
			else
			{
			 Write-Host "List '"$ListName"' already deleted!" -foregroundcolor green
			}

		  }
} 
catch 
{ 
    Write-Host "Error connecting to SharePoint Online: $_.Exception.Message" -foregroundcolor black -backgroundcolor Red 
    return 
} 


}