
#FUNCTION TO Delete Site Columns 

function DeleteSiteColumn($inputFilePath,$SiteCollection) {
 
try
{ 

    # Import the csv file and store it in a variable
	$input = import-csv $inputFilePath


    #Loop through the CSV file content
    foreach($row in $input)
    { 
        $SiteColumnName=$row.SiteColumnInternalName
		$ContentTypeName = $row.ContentTypeName
        #If field exists
       if ($SiteColumnName -ne $null)
	   {
	
        #Remove Site column from the site
        Remove-PnpField -Identity $SiteColumnName -Force 
        Write-Host "'"$SiteColumnName "' Site Column Deleted Successfully from the Site." -foregroundcolor green
       }
	    #If field doesn't exists
	   else
	   {
	    Write-Host "'"$SiteColumnName "' Site Column already deleted from the Site." -foregroundcolor green
	   }
   
     }
  
} 
catch 
{ 
    Write-Host "Error connecting to SharePoint Online: $_.Exception.Message" -foregroundcolor black -backgroundcolor Red 
    return 
} 

}

