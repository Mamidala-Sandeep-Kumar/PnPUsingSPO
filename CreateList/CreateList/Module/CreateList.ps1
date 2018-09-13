#FUNCTION TO CREATE List 

function CreateList($inputFilePath,$SiteCollection) {
 
try
{ 
    # Import the csv file and store it in a variable
	$input = import-csv $inputFilePath
    

    foreach($row in $input)
    { 
    $listURL= $row.ListUrl;
     # Get the list object  
        $getList=Get-PnPList -Identity $listURL  
 
        # Check if list exists  
        if($getList)  
        {  
           write-host -ForegroundColor Magenta $listURL " - List already exists"   
        }  
        else  
        {  
           # Create new list  
           write-host -ForegroundColor Magenta "Creating list: " $listURL  
        New-PnPList -Title $row.ListName -Template $row.TemplateName -Url $row.ListUrl
        }       
                   
    }

  
} 
catch 
{ 
    Write-Host "Error connecting to SharePoint Online: $_.Exception.Message" -foregroundcolor black -backgroundcolor Red 
    return 
} 


}