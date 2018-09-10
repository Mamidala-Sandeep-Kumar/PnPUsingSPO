# Function to add site columns to CT
function AddCol_CT($inputFilePath,$SiteCollection) {
try
{    
	# Import the csv file and store it in a variable
    $input = import-csv $inputFilePath
		   
	# Looping the csv file collection
	foreach($row in $input) { 
	
	$ContentTypeName = $row.ContentTypeName
	$ColumnName = $row.ColumnName
	
	$col = Get-PnPField -Identity $ColumnName -ErrorAction SilentlyContinue
	
	# get the content type
	$ctype = Get-PnPContentType -Identity $ContentTypeName -ErrorAction SilentlyContinue
	
	if($ctype)
	{
	
    $ctfields = get-pnpproperty -clientobject $ctype -property "Fields"
	
    $field = ($ctfields | where {$_.InternalName -eq $ColumnName})
        
        if ($field -ne $null)
        {
		Write-Host "Column: '"$ColumnName "' - already added to Content Type: '"$ContentTypeName"' " -ForegroundColor green
        
        }
        else
        {
		 if($col)
		 {
		# add the columns to CT
		Add-PnPFieldToContentType -Field $ColumnName -ContentType $ContentTypeName -ErrorAction SilentlyContinue
		Write-Host "Column: '"$ColumnName "' - added to Content Type: '"$ContentTypeName "'" -ForegroundColor green
		}
		 else
		 {
		    Write-Host "Column: '"$ColumnName "' doesn't exist!!" -ForegroundColor green
		 }
		}
	}
	else
	{
        Write-Host "Content Type: '"$ContentTypeName "' doesn't exist!!" -ForegroundColor green
	}	
	}
	}

catch { 
    
    Write-Host "Error occured!: $_.Exception.Message" -foregroundcolor red 
	
    return 
} 
}
