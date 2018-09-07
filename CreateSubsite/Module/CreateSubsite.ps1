#FUNCTION TO CREATE Subsite 

function CreateSubsite($inputFilePath,$SiteCollection) {
try
	   {
 
    # Import the csv file and store it in a variable
	$input = import-csv $inputFilePath
    
    foreach($row in $input)
    { 
       # Get SubSite Name
	   $SubsiteName = $row.SubsiteName

       # Get SubSite Url
	   $SiteUrl = $row.Url

       # Get SubSite Description
	   $SiteDescription = $row.Description

       # Get SubSite Type
	   $SiteTemplate = $row.Template
	   
	   # Get the subsite
	   $subsite = Get-PnPWeb $SubsiteName -ErrorAction SilentlyContinue
	   
	   #Check if subsite exists
	   if($subsite)
	   {
	     Write-Host "Subsite: '$SubsiteName' already exists!!" -ForegroundColor green
	   }
	   else
	   {
	     #Create subsite 
		 New-PnPWeb -Title $SubsiteName -Url $SiteUrl -Description $SiteDescription  -Template $SiteTemplate -ErrorAction SilentlyContinue
		 Write-Host "Subsite: '$SubsiteName' created successfully." -ForegroundColor green
	   }
 
}
}
catch 
{ 
    Write-Host "Error connecting to SharePoint Online: $_.Exception.Message" -foregroundcolor red 
    return 
} 
}
