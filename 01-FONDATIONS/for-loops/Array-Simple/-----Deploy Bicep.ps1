
Connect-AzAccount -Subscription 'f8d17dee-320f-4765-a0df-a0251ececb1a'

$Context = Get-AzSubscription -SubscriptionId "f8d17dee-320f-4765-a0df-a0251ececb1a"
Set-AzContext $context 
Get-AzResourceGroup  -Name 'rg-bicep04' 

  
$timestamp = Get-Date -Format "yyyy-MM-dd_HH_mm"
# Lance le déploiement
New-AzResourceGroupDeployment `
  -Name deploy_$Timestamp `
  -ResourceGroupName "rg-bicep06" `
  -TemplateFile '.\5.Example-FOR-IF.bicep' `
  -Mode Incremental `
  -Verbose



