function New-ITGlue {
    Param (
        [Parameter(Mandatory = $true)]
        [String]$resource_uri,
        [Parameter(Mandatory = $true)]
        [Hashtable]$data
    )

    $body = @{'data'= $data}
    $body = ConvertTo-Json -InputObject $body -Depth $ITGlue_JSON_Conversion_Depth

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)

        $parameters = @{
            "Method" = 'POST'
            "Uri" = $ITGlue_Base_URI + $resource_uri
            "Headers" = $ITGlue_Headers
            "Body" = $body
        }

        $rest_output = Invoke-RestMethod @parameters -ErrorAction Stop
    } catch {
        Write-Error $_
    } finally {
        [void] ($ITGlue_Headers.Remove('x-api-key')) # Quietly clean up scope so the API key doesn't persist
    }

    $data = @{}
    $data = $rest_output
    return $data
}

function Get-ITGlue {
    Param (
        [Parameter(Mandatory = $true)]
        [String]$resource_uri,

        [Hashtable]$filter_list = @{}
    )

    $filter = ""
    foreach($key in $filter_list.keys) {
        $filter += "$key=$($filter[$key])&"
    }

    $filter = $filter.trimEnd("&") # Remove trailing &.

    if(-not [System.String]::IsNullOrEmpty($filter)) { # Skip if no filer was added.
        $resource_uri = "{0}?{1}" -f $resource_uri, $filter
    }

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)

        $parameters = @{
            "Method" = 'GET'
            "Uri" = $ITGlue_Base_URI + $resource_uri
            "Headers" = $ITGlue_Headers
        }

        $rest_output = Invoke-RestMethod @parameters -ErrorAction Stop
    } catch {
        Write-Error $_
    } finally {
        [void] ($ITGlue_Headers.Remove('x-api-key')) # Quietly clean up scope so the API key doesn't persist
    }

    $data = @{}
    $data = $rest_output
    return $data
}

function Set-ITGlue {
    Param (
        [Parameter(Mandatory = $true)]
        [String]$resource_uri,

        [Parameter(Mandatory = $true)]
        [Hashtable]$data,

        [Hashtable]$filter_list = @{}
    )

    $body = @{}
    if($filter_list.Count -gt 0)  { # Only run if filters are provided
        foreach($key in $filter_list.keys) { # Loop all filters and add them to the body.
            $body[$key] = $filter_list[$key]
        }
    }

    $body['data'] = $data
    $body = ConvertTo-Json -InputObject $body -Depth $ITGlue_JSON_Conversion_Depth

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)

        $parameters = @{
            "Method" = 'PATCH'
            "Uri" = $ITGlue_Base_URI + $resource_uri
            "Headers" = $ITGlue_Headers
            "Body" = $body
        }

        $rest_output = Invoke-RestMethod @parameters -ErrorAction Stop
    } catch {
        Write-Error $_
    } finally {
        [void] ($ITGlue_Headers.Remove('x-api-key')) # Quietly clean up scope so the API key doesn't persist
    }

    $data = @{}
    $data = $rest_output
    return $data
}

function Remove-ITGlue {
    Param (
        [Parameter(Mandatory = $true)]
        [String]$resource_uri,

        [Parameter(Mandatory = $true)]
        [Hashtable]$data,

        [Hashtable]$filter_list = @{}
    )

    $body = @{}

    if($filter_list.Count -gt 0)  { # Only run if filters are provided
        foreach($key in $filter_list.keys) { # Loop all filters and add them to the body.
            $body[$key] = $filter_list[$key]
        }
    }

    $body['data'] = $data
    $body = ConvertTo-Json -InputObject $body -Depth $ITGlue_JSON_Conversion_Depth

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)

        $parameters = @{
            "Method" = 'DELETE'
            "Uri" = $ITGlue_Base_URI + $resource_uri
            "Headers" = $ITGlue_Headers
            "Body" = $body
        }

        $rest_output = Invoke-RestMethod @parameters -ErrorAction Stop
    } catch {
        Write-Error $_
    } finally {
        [void] ($ITGlue_Headers.Remove('x-api-key')) # Quietly clean up scope so the API key doesn't persist
    }

    $data = @{}
    $data = $rest_output
    return $data
}
