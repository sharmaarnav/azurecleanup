# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

Write-Output "Using system-assigned managed identity"

#Get Azure Resource Groups
$allresourcegroups = Get-AzResourceGroup | Where-Object ResourceGroupName -NotLike '*automation*' ##exception is set here
  
     
    if(!$allresourcegroups){
        Write-Output "No resource groups found";
    }
    else{
         
        Write-Output "Starting the cleanup process";
           
            foreach($resourceGroup in $allresourcegroups){

                $rgname = $resourceGroup.ResourceGroupName

                    Write-Host "Deleting $($resource.ResourceGroupName)..."
                    Remove-AzResourceGroup -Name $rgname -Force
        }
         
        Write-Output "Cleanup Completed";
         
    }
