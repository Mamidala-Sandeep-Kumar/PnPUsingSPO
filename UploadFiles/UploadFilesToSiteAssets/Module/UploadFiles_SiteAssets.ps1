#FUNCTION TO Upload files to Site Assets 


function UploadFiles($currentfilePath,$inputFilePath,$SiteCollection) {
try
{
    
	
    # Import the csv file and store it in a variable
	$input = import-csv $inputFilePath
	
    
    foreach($row in $input)
    { 
	   $FileName = $row.FileName
	   $SourceFolder = $row.SourceFolder
	   $DestinationFolder = $row.DestinationFolder
	   $CreateFolder = $row.CreateFolder
	   $FolderName = $row.FolderName
	   
	   # $folderRelativePath = "$DestinationFolder"+"/"+"$FolderName"
	   $siteRelativePath = $DestinationFolder+"/"+$FolderName
	   $filePath = $currentfilePath + $SourceFolder+"\"+$FileName
	   $fileExistsInFolderPath = $DestinationFolder+"/"+$FolderName+"/"+$FileName
	   $fileExistsPath = $DestinationFolder+"/"+$FileName
	   
	   # Check if folder already exists
	   $folderExists = Get-PnPFolder -Url $siteRelativePath -ErrorAction SilentlyContinue
		 
	   # Check if file already exists in folder
	   $fileExistsInFolder = Get-PnPFile -Url $fileExistsInFolderPath -ErrorAction SilentlyContinue
	   
		 
	   # Check whether folder has to be created
	   if(($CreateFolder -eq "yes") -or ($CreateFolder -eq "Yes") -or ($CreateFolder -eq "YES"))
	   {
	     
		 
			 if($folderExists)
			 {
			   
			   
			   if($fileExistsInFolder)
			   {
			     Write-Host "File: '$FileName' already uploaded to folder: '$siteRelativePath'" -ForegroundColor green
			   }
			   
			   else
			   {
				   #Upload file to Site Assets folder
				   Add-PnPFile -Path $filePath -Folder $siteRelativePath -ErrorAction SilentlyContinue
				   Write-Host "File: '$FileName' uploaded to folder: '$siteRelativePath'" -ForegroundColor green
			   }
			 }
			 
			if(!$folderExists)
			{
			 
				# Returns a folder from a given site relative path, and will create it if it does not exist.
				Resolve-PnPFolder -SiteRelativePath $siteRelativePath
				#Upload file to Site Assets folder
				Add-PnPFile -Path $filePath -Folder $siteRelativePath -ErrorAction SilentlyContinue
				Write-Host "File: '$FileName' uploaded to folder: '$siteRelativePath'" -ForegroundColor green
			   
			}
		}
		
		
		# Check whether file has to be uploaded to existing folder in Site Assests
	   elseif(($CreateFolder -eq "no") -or ($CreateFolder -eq "No") -or ($CreateFolder -eq "NO"))
	   {
	     
		 
			 if($folderExists)
			 {
			   
			   
			   if($fileExistsInFolder)
			   {
			     Write-Host "File: '$FileName' already uploaded to folder: '$siteRelativePath'" -ForegroundColor green
			   }
			   
			   else
			   {
				   #Upload file to Site Assets folder
				   Add-PnPFile -Path $filePath -Folder $siteRelativePath -ErrorAction SilentlyContinue
				   Write-Host "File: '$FileName' uploaded to folder: '$siteRelativePath'" -ForegroundColor green
			   }
			 }
			 
			if(!$folderExists)
			{
			 
				Write-Host "Folder by name '$FolderName' does not exist!!" -ForegroundColor green
			   
			}
		}
		
		
	   
	   else
	   {
	     # Check if file already exists in Site Assets
		 $fileExists = Get-PnPFile -Url $fileExistsPath -ErrorAction SilentlyContinue
	     if($fileExists)
		    {
			   Write-Host "File: '$FileName' already uploaded to folder: '$DestinationFolder'" -ForegroundColor green
			}
			else
			{
			  #Upload file to Site Assets folder
			  Add-PnPFile -Path $filePath -Folder $siteRelativePath -ErrorAction SilentlyContinue
			  Write-Host "File: '$FileName' uploaded to folder: '$DestinationFolder'" -ForegroundColor green
			}
		 
	   }	
		
	   
	   
}
}
catch 
{ 
    Write-Host "Error connecting to SharePoint Online: $_.Exception.Message" -foregroundcolor red 
    return 
} 
}
