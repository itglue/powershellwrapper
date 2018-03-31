function New-ITGlueContacts {
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/contacts'

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts' -f $organization_id)
    }

    $body = ConvertTo-Json -InputObject $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'POST' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}

function Get-ITGlueContacts {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int]]$country_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_important = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'first_name', 'last_name', 'id', 'created_at', 'updated_at', `
                '-first_name', '-last_name', '-id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/contacts/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $organization_id) + $resource_uri
    }

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        $body = @{
            'filter[first_name]' = $filter_first_name
            'filter[last_name]' = $filter_last_name
            'filter[title]'     = $filter_title
            'filter[iso]'  = $filter_iso
            'sort'         = $sort
        }
        if ($filter_id) {
            $body += @{'filter[id]' = $filter_id}
        }
        if ($filter_country_id) {
            $body += @{'filter[country_id]' = $filter_country_id}
        }
        if ($filter_important) {
            $body += @{'filter[important]' = $filter_important}
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

function Set-ITGlueContacts {
    Param (
        [Nullable[Int64]]$id = $null,

        [Nullable[Int64]]$organization_id = $null,

        [Parameter(Mandatory = $true)]
        $data,

        [Nullable[Int64]]$filter_id = $null,

        [String]$filter_first_name = '',

        [String]$filter_last_name = '',

        [String]$filter_title = '',

        [Nullable[Int64]]$filter_contact_type_id = $null,

        [String]$filter_important = ''

    )

    $resource_uri = ('/contacts/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts/{1}' -f $organization_id, $id)
    }

    $body = ConvertTo-Json -InputObject $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'PATCH' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}