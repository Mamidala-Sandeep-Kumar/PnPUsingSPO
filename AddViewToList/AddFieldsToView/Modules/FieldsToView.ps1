# Function to add fields to view
function AddFieldsToview($inputFilePath,$SiteCollection) {
try
{
    
	# Import the csv file and store it in a variable
    $input = import-csv $inputFilePath
		   
	# Looping the csv file collection
	foreach($row in $input) { 
	
	$ContentTypeName = $row.ContentTypeName
	$ListName = $row.ListName
	$ViewName = $row.ViewName
	
	
	# get the list view
	$view = Get-PnPView -Identity $ViewName -List $ListName
    if($view -eq $null) {
		Write-Host "View '"$ViewName "' does not exist in '"$ListName "'" -foregroundcolor green
        return
    }
	
	# get the content type
	$ctype = Get-PnPContentType -Identity $ContentTypeName
	# get fields from content type
	$ctfields = Get-pnpproperty -clientobject $ctype -property "Fields"
	$listfields = Get-PnPField -List  $ListName
	  
		foreach ($ctColumn in $ctfields | Where-Object { !$_.Hidden } ) {
			foreach ($ltColumn in $listfields | Where-Object { !$_.Hidden }) {
				if ($ctColumn.Title -eq $ltColumn.Title){
					if($view.ViewFields -contains $ltColumn.Title){
						Write-Host "'"$ltColumn.Title "' Column already exists in view in '"$ListName "' list!" -foregroundcolor green
						continue
					}
					if ($ltColumn.Title -match "Modified By" -or
						$ltColumn.Title -match "Created By" -or
						$ltColumn.Title -eq "Name" -or
						$ltColumn.Title -eq "Content Type" -or
						$ltColumn.Title -eq "Title")
					{
						#system fields              
						continue	
					}
					$view.ViewFields.Add($ltColumn.Title)   
					Write-Host "Column '"$ltColumn.Title "' added to '"$ViewName "' view in '"$ListName "' list" -foregroundcolor green
				}
			}
		}
	$view.Update()
	Invoke-PnPQuery
	}
}	

	catch { 
		Write-Host "Error occured!: $_.Exception.Message" -foregroundcolor red 
		return 
	} 
}