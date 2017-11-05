function New-ITGlueOrganizationStatuses {
    Param (
        [Parameter(Mandatory=$true)]
        $data
    )

    $resource_uri = "/organization_statuses/"

    $body = ConvertTo-Json $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "POST" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}



function Get-ITGlueOrganizationStatuses {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [String]$filter_name = "",

        [Parameter(ParameterSetName="index")]
        [ValidateSet( "name",  "id", `
                     "-name", "-id")]
        [String]$sort = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$id = $null
    )

    $resource_uri = "/organization_statuses/${id}"

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{
                "filter[name]" = $filter_name
                "sort" = $sort
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




function Set-ITGlueOrganizationStatuses {
    Param (
        [Int]$id,

        [Parameter(Mandatory=$true)]
        $data
    )

    $resource_uri = "/organization_statuses/${id}"

    $body = ConvertTo-Json $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "PATCH" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}