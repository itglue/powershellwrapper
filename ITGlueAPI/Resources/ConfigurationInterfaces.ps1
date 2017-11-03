function Get-ITGlueConfigurationInterfaces {
    [CmdletBinding(DefaultParametersetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$conf_id = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$id = $null
    )

    $resource_uri = "/configurations/${conf_id}/relationships/configuration_interfaces/${id}"
    if(($PsCmdlet.ParameterSetName -eq "show") -and ($conf_id -eq $null)) {
        $resource_uri = "/configuration_interfaces/${id}"
    }

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{}
        if($page_number) {
            $body += @{"page[number]" = $page_number}
        }
        if($page_size) {
            $body += @{"page[size]" = $page_size}
        }
    }


    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "GET" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}