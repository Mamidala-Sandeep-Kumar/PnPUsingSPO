# function to delete CT from subsite list	
function DeleteCTFromSubsite($inputFilePath,$SiteCollection) {
 try {   
	# Import the csv file and store it in a variable
    $input = import-csv $inputFilePath
    $count = 0		   
	# Looping the csv file collection
	foreach($row in $input) { 
	
	            $ContentTypeName = $row.ContentTypeName
	            $ListName = $row.ListName
	
	
				$ct = Get-PnPContentType -List $ListName -Identity $ContentTypeName -ErrorAction SilentlyContinue
				   
				#This will ensure to delete the Content Type not any List/Library column.
				 if($ct)
				{
					Remove-PnPContentTypeFromList -List $ListName -ContentType $ContentTypeName
					Write-Host "'"$ContentTypeName "' Content Type deleted successfully from the List: '"$ListName "' " -foregroundcolor green
					$count++
				}
		
		        else
		        {
			        Write-Host "'"$ContentTypeName "' content Type already deleted from the List: '"$ListName "' " -foregroundcolor green
		        }
	}
}

catch { 
    Write-Host "Error occured!: $_.Exception.Message" -foregroundcolor red 
    return 
} 
}
