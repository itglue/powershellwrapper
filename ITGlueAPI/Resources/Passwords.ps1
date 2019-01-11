function New-ITGluePasswords {
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Boolean]$show_password = $true, # Passwords API defaults to $false

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/passwords/'

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords' -f $organization_id)
    }

    if (!$show_password) {
        $resource_uri = $resource_uri + ('?show_password=false') # using $False in PS results in 'False' (uppercase false), so explicitly writing out 'false' is needed
    }

    $body = @{}

    $body += @{'data'= $data}

    $body = ConvertTo-Json -InputObject $body -Depth $ITGlue_JSON_Conversion_Depth

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
        $rest_output = Invoke-RestMethod -method 'POST' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
            -body $body -ErrorAction Stop -ErrorVariable $web_error
    } catch {
        Write-Error $_
    } finally {
        $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist
    }

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
        [Boolean]$show_password = $true, # Passwords API defaults to $true

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        $include = ''
    )
    
    $resource_uri = ('/passwords/{0}' -f $id)

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords/{1}' -f $organization_id, $id)
    }

    $body = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {$body += @{'filter[id]' = $filter_id}
        }
        if ($filter_name) {$body += @{'filter[name]' = $filter_name}
        }
        if ($filter_organization_id) {$body += @{'filter[organization_id]' = $filter_organization_id}
        }
        if ($filter_password_category_id) {$body += @{'filter[password_category_id]' = $filter_password_category_id}
        }
        if ($filter_url) {$body += @{'filter[url]' = $filter_url}
        }
        if ($filter_cached_resource_name) {$body += @{'filter[cached_resource_name]' = $filter_cached_resource_name}
        }
        if ($sort) {
            $body += @{'sort' = $sort}
        }
        if ($page_number) {$body += @{'page[number]' = $page_number}
        }
        if ($page_size) {$body += @{'page[size]' = $page_size}
        }
    }
    elseif ($organization_id -eq $null) {
        #Parameter set "Show" is selected and no organization id is specified; switch from nested relationships route
        $resource_uri = ('/passwords/{0}' -f $id)
    }

    if (!$show_password) {
        $resource_uri = $resource_uri + ('?show_password=false') # using $False in PS results in 'False' (uppercase false), so explicitly writing out 'false' is needed
    }

    if($include) {
        $body += @{'include' = $include}
    }

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
        $rest_output = Invoke-RestMethod -method 'GET' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
            -body $body -ErrorAction Stop -ErrorVariable $web_error
    } catch {
        Write-Error $_
    } finally {
        $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist
    }

    $data = @{}
    $data = $rest_output 
    return $data
}

function Set-ITGluePasswords {
    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Boolean]$show_password = $false, # Passwords API defaults to $false

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords/{1}' -f $organization_id, $id)
    }

    if ($show_password) {
        $resource_uri = $resource_uri + ('?show_password=true') # using $True in PS results in 'True' (uppercase T), so explicitly writing out 'true' is needed
    }

    $body = @{}

    $body += @{'data' = $data}

    $body = ConvertTo-Json -InputObject $body -Depth $ITGlue_JSON_Conversion_Depth

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
        $rest_output = Invoke-RestMethod -method 'PATCH' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
            -body $body -ErrorAction Stop -ErrorVariable $web_error
    } catch {
        Write-Error $_
    } finally {
        $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist
    }

    $data = @{}
    $data = $rest_output 
    return $data
}

function Remove-ITGluePasswords {
    [CmdletBinding(DefaultParameterSetName = 'destroy')]
    Param (
        [Parameter(ParameterSetName = 'destroy')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_password_category_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_url = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_cached_resource_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy', Mandatory = $true)]
        $data
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    $body = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if ($filter_id) {
            $body += @{'filter[id]' = $filter_id}
        }
        if ($filter_name) {
            $body += @{'filter[name]' = $filter_name}
        }
        if ($filter_organization_id) {
            $body += @{'filter[organization_id]' = $filter_organization_id}
        }
        if ($filter_password_category_id) {
            $body += @{'filter[password_category_id]' = $filter_password_category_id}
        }
        if ($filter_url) {
            $body += @{'filter[url]' = $filter_url}
        }
        if ($filter_cached_resource_name) {
            $body += @{'filter[cached_resource_name]' = $filter_cached_resource_name}
        }

        $body += @{'data' = $data}

        $body = ConvertTo-Json -InputObject $body -Depth $ITGlue_JSON_Conversion_Depth
    }

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
        $rest_output = Invoke-RestMethod -method 'DELETE' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
            -body $body -ErrorAction Stop -ErrorVariable $web_error
    } catch {
        Write-Error $_
    } finally {
        $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist
    }

    $data = @{}
    $data = $rest_output
    return $data
}
