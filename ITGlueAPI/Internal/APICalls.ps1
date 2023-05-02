function ConvertTo-QueryString([Hashtable]$QueryParams) {
    if (-not $QueryParams) {
        return ""
    }

    $params = @()
    foreach ($key in $QueryParams.Keys) {
        $value = [System.Net.WebUtility]::UrlEncode($QueryParams[$key])
        $params += "$key=$value"
    }

    $query_string = '?' + ($params -join '&')
    return $query_string
}

function Invoke-ITGlueRequest {
    param (
        [ValidateSet('GET', 'POST', 'PATCH', 'DELETE')]
        [string]$Method = 'GET',

        [Parameter(Mandatory = $true)]
        [string]$ResourceURI,

        [Hashtable]$QueryParams = $null,

        [Hashtable]$Data = $null
    )

    $query_string = ConvertTo-QueryString -QueryParams $QueryParams

    if ($null -eq $Data) {
        $body = $null
    } else {
        $body = @{'data'=$Data} | ConvertTo-Json -Depth $ITGlue_JSON_Conversion_Depth
    }

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)

        $parameters = @{
            'Method' = $Method
            'Uri' = $ITGlue_Base_URI + $ResourceURI + $query_string
            'Headers' = $ITGlue_Headers
            'Body' = $body
        }
        if ($Method -ne 'GET') {
            $parameters['ContentType'] = 'application/vnd.api+json; charset=utf-8'
        }

        $api_response = Invoke-RestMethod @parameters -ErrorAction Stop
    } catch {
        Write-Error $_
    } finally {
        [void] ($ITGlue_Headers.Remove('x-api-key')) # Quietly clean up scope so the API key doesn't persist
    }

    return $api_response
}
