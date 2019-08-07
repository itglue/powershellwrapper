function Get-ITGlueExpirations {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(Mandatory = $true, ParameterSetName = 'index')]
        [Parameter(Mandatory = $true, ParameterSetName = 'show')]
        [Nullable[Int64]]$organization_id,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_resource_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_resource_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_resource_type_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_description = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_expiration_date = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidatePattern('^[0-9*]+,\s[0-9*]+$')]
        [String]$filter_range = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'id', 'organization_id', 'expiration_date', 'created_at', 'updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(Mandatory = $true, ParameterSetName = 'show')]
        [Nullable[Int64]]$id,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        $include = ''
    )

    $resource_uri = ('/expirations/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $organization_id) + $resource_uri
    }

    $body = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $body += @{'filter[id]' = $filter_id}
        }
        if ($filter_resource_id) {
            $body += @{'filter[resource_id]' = $filter_resource_id}
        }
        if ($filter_resource_name) {
            $body += @{'filter[resource_name]' = $filter_resource_name}
        }
        if ($filter_resource_type_name) {
            $body += @{'filter[resource_type_name]' = $filter_resource_type_name}
        }
        if ($filter_description) {
            $body += @{'filter[description]' = $filter_description}
        }
        if ($filter_expiration_date) {
            $body += @{'filter[expiration_date]' = $filter_expiration_date}
        }
        elseif ($filter_range) {
            $body += @{'filter[range]' = $filter_range}
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