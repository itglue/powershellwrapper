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
    
    if($Method -ne 'GET') {
        $AllResults = $false
    }
    
    if ($null -eq $Data) {
        $body = $null
    } else {
        $body = @{'data'=$Data} | ConvertTo-Json -Depth $ITGlue_JSON_Conversion_Depth
    }

    try {
        $headers = @{
            'x-api-key' = (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password
        }

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
                'Headers' = $headers
                'Body' = $body
            }

            if($Method -ne 'GET') {
                $parameters['ContentType'] = 'application/vnd.api+json; charset=utf-8'
            }

            $api_response = Invoke-RestMethod @parameters -ErrorAction Stop

            if($AllResults) {
                $result.data += $api_response.data
            } else {
                $result = $api_response
            }

        } while($AllResults -and $api_response.meta.'total-pages' -and $page -lt ($api_response.meta.'total-pages'))

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
    }

    return $result
}
