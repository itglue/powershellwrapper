function New-ITGlueManufacturers {
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/manufacturers/'

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

function Get-ITGlueManufacturers {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'id', 'created_at', 'updated_at', `
                '-name', '-id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/manufacturers/{0}' -f $id)

    $body = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_name) {
            $body += @{'filter[name]' = $filter_name}
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

function Set-ITGlueManufacturers {
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/manufacturers/{0}' -f $id)

    $body = @{}

    $body += @{'data'= $data}

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