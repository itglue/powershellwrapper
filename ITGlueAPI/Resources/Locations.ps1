function New-ITGlueLocations {
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$org_id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/organizations/{0}/relationships/locations/' -f $org_id)

    $body = ConvertTo-Json -InputObject $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'POST' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}
function Get-ITGlueLocations {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$org_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_region_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_country_id = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'id', `
                '-name', '-id')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int64]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/locations/{0}' -f $id)
    if ($org_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $org_id) + $resource_uri
    }

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        $body = @{
            'filter[name]' = $filter_name
            'sort'         = $sort
        }
        if ($filter_region_id) {
            $body += @{'filter[region_id]' = $filter_region_id}
        }
        if ($filter_country_id) {
            $body += @{'filter[country_id]' = $filter_country_id}
        }
        if ($page_number) {
            $body += @{'page[number]' = $page_number}
        }
        if ($page_size) {
            $body += @{'page[size]' = $page_size}
        }
    }


    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'GET' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}

function Set-ITGlueLocations {
    Param (
        [Nullable[Int64]]$id = $null,

        [Nullable[Int64]]$org_id = $null,

        [Parameter(Mandatory = $true)]
        $data,

        [Nullable[Int64]]$filter_id = $null,

        [String]$filter_name = '',

        [String]$filter_city = '',

        [Nullable[Int64]]$filter_region_id = $null,

        [Nullable[Int64]]$filter_country_id = $null
    )

    $resource_uri = ('/locations/{0}' -f $id)

    if ($org_id) {
        $resource_uri = ('organizations/{0}/relationships/locations/{1}' -f $org_id, $id)
    }

    $body = ConvertTo-Json -InputObject $data -Depth $ITGlue_JSON_Conversion_Depth

    if($filter_id) {
        $body += @{'filter[id]' = $filter_id}
    }
    if($filter_name) {
        $body += @{'filter[name]' = $filter_name}
    }
    if($filter_city) {
        $body += @{'filter[city]' = $filter_city}
    }
    if($filter_region_id) {
        $body += @{'filter[region_id]' = $filter_region_id}
    }
    if($filter_country_id) {
        $body += @{'filter[country_id]' = $filter_country_id}
    }

    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'PATCH' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}