function New-ITGluePasswords {
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Nullable[Boolean]]$show_password = $null, # Passwords API defaults to $false

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/passwords/'

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords' -f $organization_id)
    }

    $body = @{}

    if (-not [string]::IsNullOrEmpty($show_password)) {$body += @{'show_password' = $show_password}
    }

    $body += ConvertTo-Json -InputObject $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'POST' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}

function Get-ITGluePasswords {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_password_category_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_url = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_cached_resource_name = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'username', 'id', 'created_at', 'updated-at', `
                '-name', '-username', '-id', '-created_at', '-updated-at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int64]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Boolean]]$show_password = $null # Passwords API defaults to $true
    )
    
    $resource_uri = ('/passwords/{0}' -f $id)

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords/{1}' -f $organization_id, $id)
    }

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        $body = @{
            'filter[id]'    = $filter_id
            'filter[name]'  = $filter_name
            'filter[url]'   = $filter_url
            'filter[cached_resource_name]'  = $filter_cached_resource_name
            'sort'          = $sort
        }
        if ($filter_id) {$body += @{'page[id]' = $filter_id}
        }
        if ($filter_organization_id) {$body += @{'page[organization_id]' = $filter_organization_id}
        }
        if ($filter_password_category_id) {$body += @{'page[password_category_id]' = $filter_password_category_id}
        }
        if ($page_number) {$body += @{'page[number]' = $page_number}
        }
        if ($page_size) {$body += @{'page[size]' = $page_size}
        }
        if (-not [string]::IsNullOrEmpty($show_password)) {$body += @{'show_password' = $show_password}
        }
    }
    elseif ($organization_id -eq $null) {
        #Parameter set "Show" is selected and no organization id is specified; switch from nested relationships route
        $resource_uri = ('/passwords/{0}' -f $id)
    }


    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'GET' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}

function Set-ITGluePasswords {
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Nullable[Int64]]$id = $null,

        [Nullable[Boolean]]$show_password = $null, # Passwords API defaults to $false

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords/{1}' -f $organization_id, $id)
    }

    $body = @{}

    if (-not [string]::IsNullOrEmpty($show_password) -and $id -and $organization_id) {
        $body += @{'show_password' = $show_password}
    }

    $body += ConvertTo-Json -InputObject $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'PATCH' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}