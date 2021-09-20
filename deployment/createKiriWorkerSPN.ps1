Invoke-Command { 
    $SiteName = "svc-kiriworker"
    $ReplyUri = "https://kiriworker.azurewebsites.net/tenantverification"
    $RequiredGrants = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]::new("00000003-0000-0000-c000-000000000000", 
        @(
            [Microsoft.Open.AzureAD.Model.ResourceAccess]::new("1138cb37-bd11-4084-a2b7-9f71582aeddb", "Role"), 
            [Microsoft.Open.AzureAD.Model.ResourceAccess]::new("78145de6-330d-4800-a6ce-494ff2d33d07", "Role"),
            [Microsoft.Open.AzureAD.Model.ResourceAccess]::new("9241abd9-d0e6-425a-bd4f-47ba86e767a4", "Role"),
            [Microsoft.Open.AzureAD.Model.ResourceAccess]::new("243333ab-4d21-40cb-a475-36241daa0842", "Role"),
            [Microsoft.Open.AzureAD.Model.ResourceAccess]::new("5ac13192-7ace-4fcf-b828-1a26f28068ee", "Role")
        ))
            
    Connect-AzureAD

    $App = New-AzureADApplication -DisplayName $SiteName -GroupMembershipClaims "SecurityGroup" -AvailableToOtherTenants $true -ReplyUrls $ReplyUri -RequiredResourceAccess $RequiredGrants
    $AppSecret = New-AzureADApplicationPasswordCredential -ObjectId $App.ObjectId -EndDate ([System.DateTime]::Now.AddYears(2).ToString("o"))
    
    Write-host "--------------------------------------------------------------------------"
    Write-host "Application Id:        $($app.AppId)\"
    Write-host "Secret:                $($AppSecret.Value)\"
    Write-host "--------------------------------------------------------------------------"
}