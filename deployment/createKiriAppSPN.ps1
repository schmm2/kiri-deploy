Invoke-Command {
    $AppName = "svc-kiriapp"
    $SpaBody = "{spa:{redirectUris:['https://kiriapp.azurewebsites.net']}}"
    
    $RequiredGrants = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]::new("00000003-0000-0000-c000-000000000000", @([Microsoft.Open.AzureAD.Model.ResourceAccess]::new("e1fe6dd8-ba31-4d61-89e7-88639da4683d", "Scope"), [Microsoft.Open.AzureAD.Model.ResourceAccess]::new("b340eb25-3456-403f-be2f-af7a0d370277", "Scope")))
    Connect-AzureAD
    $App = New-AzureADApplication -DisplayName $AppName -AvailableToOtherTenants $true -GroupMembershipClaims "SecurityGroup" -RequiredResourceAccess $RequiredGrants
    $AppRestUrl = 'https://graph.microsoft.com/v1.0/applications/' + $App.ObjectId

    write-host "--------------------------------------------------------------------------"
    write-host "Application Id:        $($App.AppId)"
    write-host "--------------------------------------------------------------------------"

    az rest --method PATCH --uri $AppRestUrl --headers 'Content-Type=application/json' --body $SpaBody
}