function New-ITGlueFavoriteOrganizations {
    Param (
        [Parameter(Mandatory=$true)]
        [Int]$user_id,

        [Parameter(Mandatory=$true)]
        [hashtable]$data
    )

    $resource_uri = "/users/${user_id}/relationships/favorite_organizations"

    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "POST" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $data -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}




function Get-ITGlueFavoriteOrganizations {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Parameter(Mandatory=$true)]
        [Int]$user_id,

        [Parameter(ParameterSetName="index")]
        [ValidateSet( "id",  "organization_id", "organization_name", `
                     "-id", "-organization_id","-organization_name")]
        [String]$sort = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="index")]
        [ValidateSet("organization")]
        [String]$include
    )

    $resource_uri = "/users/${user_id}/relationships/favorite_organizations"

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{
                "sort" = $sort
                "include" = $include
        }
        if($page_number) {
            $body += @{"page[number]" = $page_number}
        }
        if($page_size) {
            $body += @{"page[size]" = $page_size}
        }
    }


    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "GET" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}






function Remove-ITGlueFavoriteOrganizations {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    Param (
        [Parameter(Mandatory=$true)]
        [Int]$user_id,

        [Parameter(Mandatory=$true)]
        [Hashtable]$data
    )

    $resource_uri = "/users/${user_id}/relationships/favorite_organizations"

    if ($pscmdlet.ShouldProcess($user_id)) {

        $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
        $rest_output = Invoke-RestMethod -method "DELETE" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                        -body $data -ErrorAction Stop -ErrorVariable $web_error
        $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

        $data = @{}
        $data = $rest_output 
        return $data
    }
}
