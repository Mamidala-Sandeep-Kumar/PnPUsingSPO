# Function to delete site columns from content types 
function DeleteSitecolumnsFromCT($inputFilePath,$SiteCollection) {

try {

# Import the csv file and store it in a variable
	$input = import-csv $inputFilePath
	# Looping the csv file collection
    foreach($row in $input)
    { 
        $SiteColumnName=$row.ColumnName
		$ContentTypeName = $row.ContentTypeName

        #get the Site Column ID based on title
        $SiteColumn = Get-PnpField -Identity $SiteColumnName -ErrorAction SilentlyContinue
        $SiteColumnGUID = $SiteColumn.ID
         if($SiteColumn)
		 {
            #Check if  Content Type present 
            $cType = Get-pnpContentType -Identity $ContentTypeName
            if($cType)
            {
                Remove-PnPFieldFromContentType -Field $SiteColumnName -ContentType $ContentTypeName
                Write-Host "'"$SiteColumnName "' Site Column Deleted Successfully from the Content Type:" $ct.Name -foregroundcolor green
            }
            else
            {
                Write-Host "Content Type '"$ContentTypeName "' doesn't exist" -foregroundcolor green
            }
        }
	    else
	    {
	        Write-Host "Column '"$SiteColumnName "' doesn't exist in '"$ContentTypeName"' or column deleted!!" -foregroundcolor green
	    }
	}
 
} 
catch 
{ 
    Write-Host "Error connecting to SharePoint Online: $_.Exception.Message" -foregroundcolor black -backgroundcolor Red 
    return 
} 
}