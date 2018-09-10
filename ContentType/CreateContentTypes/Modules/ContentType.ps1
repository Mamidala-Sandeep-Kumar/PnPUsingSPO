# Function to create content type 
function CreateCT($inputFilePath,$SiteCollection) {
 try {   
	# Import the csv file and store it in a variable
	$input = import-csv $inputFilePath

	# Looping the csv file collection
	foreach($row in $input) { 
	
	$ParentName = $row.Parent
	$ContentTypeName = $row.ContentTypeName
	$ContentTypeDescription = $row.ContentTypeDescription
	$GroupName = $row.Group
	# store the parent CT in a variable
	$ParentCT = Get-PnPContentType -Identity $ParentName
	# retrieve the content type
	$ctype = Get-PnPContentType -Identity $ContentTypeName
	# if content type exists display message
	if ($ctype)  {
	Write-Host "Content Type: $ContentTypeName already created!" -foregroundcolor green 
	}
	# if content type doesn't exist create it
	if (!$ctype) { 
	
	# create the CT by retrieving name, description, group and parent CT details 
	$ctype = Add-PnPContentType -Name $ContentTypeName -Description $ContentTypeDescription -Group $GroupName -ParentContentType $ParentCT
	Write-Host "Content Type: "$ContentTypeName" created!" -ForegroundColor green
}
}
}

catch { 
    Write-Host "Error occured!: $_.Exception.Message" -foregroundcolor red 
    return 
} 
}
