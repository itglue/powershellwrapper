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

        [Hashtable]$Data = $null,

        [Switch]$AllResults
    )

    $result = @{}
    
    if(-not $Method -eq 'GET') {
        $AllResults = $false
    }
    
    if ($null -eq $Data) {
        $body = $null
    } else {
        $body = @{'data'=$Data} | ConvertTo-Json -Depth $ITGlue_JSON_Conversion_Depth
    }

    try {
        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)

        $page = 0
        
        do {
            if($AllResults) {
                $page++
                if(-not $QueryParams) { $QueryParams = @{} }
                $QueryParams['page[number]'] = $page
            }

            $query_string = ConvertTo-QueryString -QueryParams $QueryParams

            $parameters = @{
                'Method' = $Method
                'Uri' = $ITGlue_Base_URI + $ResourceURI + $query_string
                'Headers' = $ITGlue_Headers
                'Body' = $body
            }

            $api_response = Invoke-RestMethod @parameters -ErrorAction Stop

            if($AllResults) {
                $result.data += $api_response.data
            } else {
                $result = $api_response
            }

        } while($AllResults -and $api_response.meta.'total-pages' -and $page -le ($api_response.meta.'total-pages'))

        if($AllResults -and $api_response.meta) {
            $result.meta = $api_response.meta
            if($result.meta.'current-page') { $result.meta.'current-page' = 1 }
            if($result.meta.'next-page') { $result.meta.'next-page' = '' }
            if($result.meta.'prev-page') { $result.meta.'prev-page' = '' }
            if($result.meta.'total-pages') { $result.meta.'total-pages' = 1 }
            if($result.meta.'total-count') { $result.meta.'total-count' = $result.data.count }
        }

    } catch {
        Write-Error $_
    } finally {
        [void] ($ITGlue_Headers.Remove('x-api-key')) # Quietly clean up scope so the API key doesn't persist
    }

    return $result
}
