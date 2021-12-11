Invoke-Command {
    $AppName = "svc-kiriapp"
    $SpaBody = "{spa:{redirectUris:['https://kiriapp.azurewebsites.net']}}"
    
    $RessourceAccessApp = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
    $Acc1 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "e1fe6dd8-ba31-4d61-89e7-88639da4683d","Scope"
    $Acc2 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "b340eb25-3456-403f-be2f-af7a0d370277","Scope"
    $RessourceAccessApp.ResourceAccess = $Acc1,$Acc2
    $RessourceAccessApp.ResourceAppId = "00000003-0000-0000-c000-000000000000"

    $RessourceAccessApp = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
    $Acc3 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "68ce7e13-ac30-4979-b2c5-6334ef2f70ef","Scope"
    $RessourceAccessApp.ResourceAccess = $Acc3
    $RessourceAccessApp.ResourceAppId = "00000003-0000-0000-c000-000000000000"

    Connect-AzureAD
    $App = New-AzureADApplication -DisplayName $AppName -AvailableToOtherTenants $true -GroupMembershipClaims "SecurityGroup" -RequiredResourceAccess @($RessourceAccessApp)
    $AppRestUrl = 'https://graph.microsoft.com/v1.0/applications/' + $App.ObjectId

    write-host "--------------------------------------------------------------------------"
    write-host "Application Id:        $($App.AppId)"
    write-host "--------------------------------------------------------------------------"

    az rest --method PATCH --uri $AppRestUrl --headers 'Content-Type=application/json' --body $SpaBody
}