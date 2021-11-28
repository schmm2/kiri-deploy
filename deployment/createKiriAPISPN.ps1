Invoke-Command {
    $AppName = "svc-kiriapi"
    $SpaBody = "{spa:{redirectUris:['https://kiritest1.azurewebsites.net/.auth/login/aad/callback']}}"
    $RequiredGrants = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]::new("00000003-0000-0000-c000-000000000000", @([Microsoft.Open.AzureAD.Model.ResourceAccess]::new("e1fe6dd8-ba31-4d61-89e7-88639da4683d", "Scope"), [Microsoft.Open.AzureAD.Model.ResourceAccess]::new("b340eb25-3456-403f-be2f-af7a0d370277", "Scope")))

    Connect-AzureAD

    $App = New-AzureADApplication -DisplayName $AppName -AvailableToOtherTenants $true -GroupMembershipClaims "SecurityGroup" -RequiredResourceAccess $RequiredGrants
    $AppRestUrl = "https://graph.microsoft.com/v1.0/applications/" + $App.ObjectId
    az rest --method PATCH --uri $AppRestUrl --headers "Content-Type=application/json" --body $SpaBody
    write-host "--------------------------------------------------------------------------"
    write-host "Application Id:        $($app.AppId)"
    write-host "--------------------------------------------------------------------------"
}