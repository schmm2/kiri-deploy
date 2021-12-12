Invoke-Command {
    $AppName = "svc-kiriapi666"
    $ReplyUri = "https://testkiri5555-backend.azurewebsites.net/.auth/login/aad/callback"
    $RequiredGrants = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]::new("00000003-0000-0000-c000-000000000000", @([Microsoft.Open.AzureAD.Model.ResourceAccess]::new("e1fe6dd8-ba31-4d61-89e7-88639da4683d", "Scope"), [Microsoft.Open.AzureAD.Model.ResourceAccess]::new("b340eb25-3456-403f-be2f-af7a0d370277", "Scope")))
    $AppHomePage = "https://kiri.codes"

    Connect-AzureAD
    
    $App = New-AzureADApplication -DisplayName $AppName -AvailableToOtherTenants $true -RequiredResourceAccess $RequiredGrants -HomePage $AppHomePage -ReplyUrls $ReplyUri
    Set-AzureADApplication -ObjectId $app.ObjectId -IdentifierUris ("api://" + $app.AppId)
    
    write-host "--------------------------------------------------------------------------"
    write-host "Application Id:        $($app.AppId)"
    write-host "--------------------------------------------------------------------------" 
}