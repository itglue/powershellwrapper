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

function Get-ITGlueContacts {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'first_name', 'last_name', 'id', 'created_at', 'updated_at', `
                '-first_name', '-last_name', '-id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        $include = ''
    )

    $resource_uri = ('/contacts/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $organization_id) + $resource_uri
    }

    $body = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $body += @{'filter[id]' = $filter_id}
        }
        if ($filter_first_name) {
            $body += @{'filter[first_name]' = $filter_first_name}
        }
        if ($filter_last_name) {
            $body += @{'filter[last_name]' = $filter_last_name}
        }
        if ($filter_title) {
            $body += @{'filter[title]' = $filter_title}
        }
        if ($filter_contact_type_id) {
            $body += @{'filter[contact_type_id]' = $filter_contact_type_id}
        }
        if ($filter_important -eq $true) {
            $body += @{'filter[important]' = '1'}
        }
        elseif ($filter_important -eq $false) {
            $body += @{'filter[important]' = '0'}
        }
        if ($filter_primary_email) {
            $body += @{'filter[primary_email]' = $filter_primary_email}
        }
        if ($sort) {
            $body += @{'sort' = $sort}
        }
        if ($page_number) {
            $body += @{'page[number]' = $page_number}
        }
        if ($page_size) {
            $body += @{'page[size]' = $page_size}
        }
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

function Set-ITGlueContacts {
    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data

    )

    $resource_uri = ('/contacts/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts/{1}' -f $organization_id, $id)
    }

    $body = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if ($filter_id) {
            $body += @{'filter[id]' = $filter_id}
        }
        if ($filter_first_name) {
            $body += @{'filter[first_name]' = $filter_first_name}
        }
        if ($filter_last_name) {
            $body += @{'filter[last_name]' = $filter_last_name}
        }
        if ($filter_title) {
            $body += @{'filter[title]' = $filter_title}
        }
        if ($filter_contact_type_id) {
            $body += @{'filter[contact_type_id]' = $filter_contact_type_id}
        }
        if ($filter_important -eq $true) {
            $body += @{'filter[important]' = '1'}
        }
        elseif ($filter_import -eq $false) {
            $body += @{'filter[important]' = '0'}
        }
        if ($filter_primary_email) {
            $body += @{'filter[primary_email]' = $filter_primary_email}
        }
    }

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

function Remove-ITGlueContacts {
    [CmdletBinding(DefaultParameterSetName = 'bulk_destroy')]
    Param (
        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_last_name = '',
        
        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_title = '',
        
        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/contacts/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts/{1}' -f $organization_id, $id)
    }

    $body = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if ($filter_id) {
            $body += @{'filter[id]' = $filter_id}
        }
        if ($filter_first_name) {
            $body += @{'filter[first_name]' = $filter_first_name}
        }
        if ($filter_last_name) {
            $body += @{'filter[last_name]' = $filter_last_name}
        }
        if ($filter_title) {
            $body += @{'filter[title]' = $filter_title}
        }
        if ($filter_contact_type_id) {
            $body += @{'filter[contact_type_id]' = $filter_contact_type_id}
        }
        if ($filter_important -eq $true) {
            $body += @{'filter[important]' = '1'}
        }
        elseif ($filter_important -eq $false) {
            $body += @{'filter[important]' = '0'}
        }
        if ($filter_primary_email) {
            $body += @{'filter[primary_email]' = $filter_primary_email}
        }
    }

    $body += @{'data' = $data}

    $body = ConvertTo-Json -InputObject $body -Depth $ITGlue_JSON_Conversion_Depth

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
