
Connect-AzAccount -Subscription 'f8d17dee-320f-4765-a0df-a0251ececb1a'

$Context = Get-AzSubscription -SubscriptionId "f8d17dee-320f-4765-a0df-a0251ececb1a"
Set-AzContext $context 
Get-AzResourceGroup  -Name 'rg-bicep06' 

  
$timestamp = Get-Date -Format "yyyy-MM-dd_HH_mm"
# Lance le déploiement
New-AzResourceGroupDeployment `
  -Name deploy_$Timestamp `
  -ResourceGroupName "rg-bicep06" `
  -TemplateFile '.\if-dev-or-prod.bicep' `
  -Mode Incremental `
  -Verbose

$timestamp = Get-Date -Format "yyyy-MM-dd_HH_mm"
# Lance le déploiement
New-AzResourceGroupDeployment `
  -Name deploy_$Timestamp `
  -ResourceGroupName "rg-bicep06" `
  -TemplateFile '.\Loop-Index-Range-without-parameter.bicep' `
  -Mode Incremental `
  -Verbose

$timestamp = Get-Date -Format "yyyy-MM-dd_HH_mm"
# Lance le déploiement
New-AzResourceGroupDeployment `
  -Name deploy_$Timestamp `
  -ResourceGroupName "rg-bicep06" `
  -TemplateFile '.\20.1.bicep' `
  -Mode Incremental `
  -Verbose


  $timestamp = Get-Date -Format "yyyy-MM-dd_HH_mm"
# Lance le déploiement
New-AzsubscriptionDeployment `
  -location 'eastus' `
  -Name deploy_$Timestamp `
  -TemplateFile .\20.1.bicep `
  -verbose 
