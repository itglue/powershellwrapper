function New-ITGlueModels {
    Param (
        [Nullable[Int]]$manufacturer_id = $null,

        [Parameter(Mandatory=$true)]
        $data
    )

    $resource_uri = "/models/"

    if($manufacturer_id) {
        $resource_uri = "/manufacturers/${manufacturer_id}/relationships/models"
    }

    $body = ConvertTo-Json $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "POST" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}



function Get-ITGlueModels {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$manufacturer_id = $null,

        [Parameter(ParameterSetName="index")]
        [ValidateSet( "id",  "name",  "manufacturer_id", `
                     "-id", "-name", "-manufacturer_id")]
        [String]$sort = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="show")]
            [Nullable[Int]]$id = $null
    )

    $resource_uri = "/models/${id}"
    if($manufacturer_id) {
        $resource_uri = "/manufacturers/${manufacturer_id}/relationships" + $resource_uri
    }

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{
                "filter[name]" = $filter_name
                "sort" = $sort
        }
        if($filter_region_id) {
            $body += @{"filter[region_id]" = $filter_region_id}
        }
        if($filter_country_id) {
            $body += @{"filter[country_id]" = $filter_country_id}
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





function Set-ITGlueModels {
    Param (
        [Nullable[Int]]$id = $null,

        [Nullable[Int]]$manufacturer_id = $null,

        [Parameter(Mandatory=$true)]
        $data
    )

    $resource_uri = "/models/${id}"

    if($manufacturer_id) {
        $resource_uri = "/manufacturers/${manufacturer_id}/relationships/models/${id}"
    }

    $body = ConvertTo-Json $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "PATCH" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}