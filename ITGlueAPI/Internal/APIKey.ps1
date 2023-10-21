function Add-ITGlueAPIKey {
<#
    .SYNOPSIS
        Sets your API key used to authenticate all API calls.

    .DESCRIPTION
        The Add-ITGlueAPIKey cmdlet sets your API key which is used to
        authenticate all API calls made to ITGlue.

        ITGlue API keys can be generated via the ITGlue web interface
            Account > API Keys

    .PARAMETER Api_Key
        Defines the API key that was generated from ITGlue.

    .EXAMPLE
        Add-ITGlueAPIKey

        Prompts to enter in the API key

    .EXAMPLE
        Add-ITGlueAPIKey -Api_key 'some_api_key'

        Will use the string entered into the [ -Api_Key ] parameter.

    .EXAMPLE
        '12345' | Add-ITGlueAPIKey

        Will use the string passed into it as its API key.

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [Alias('ApiKey')]
        [string]$Api_Key
    )

    process{

        if ($Api_Key) {
            $x_api_key = ConvertTo-SecureString $Api_Key -AsPlainText -Force

            Set-Variable -Name "ITGlue_API_Key" -Value $x_api_key -Option ReadOnly -Scope global -Force
        }
        else {
            Write-Output "Please enter your API key:"
            $x_api_key = Read-Host -AsSecureString

            Set-Variable -Name "ITGlue_API_Key" -Value $x_api_key -Option ReadOnly -Scope global -Force
        }

    }

}



function Get-ITGlueAPIKey {
<#
    .SYNOPSIS
        Gets the ITGlue API key

    .DESCRIPTION
        The Get-ITGlueAPIKey cmdlet gets the ITGlue API key from
        the global variable and returns it as a SecureString.

    .EXAMPLE
        Get-ITGlueAPIKey

        Gets the ITGlue API key global variable and returns it as a SecureString.

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param ()

    if ($ITGlue_API_Key) {
        $ITGlue_API_Key
    }
    else{
        Write-Warning "No API key exists. Please run Add-ITGlueAPIKey to add one."
    }

}



function Remove-ITGlueAPIKey {
<#
    .SYNOPSIS
        Removes the ITGlue API key

    .DESCRIPTION
        The Remove-ITGlueAPIKey cmdlet removes the ITGlue API key from
        global variable.

    .EXAMPLE
        Remove-ITGlueAPIKey

        Removes the ITGlue API key global variable.

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding(SupportsShouldProcess)]
    Param ()

    if ($ITGlue_API_Key) {
        Remove-Variable -Name "ITGlue_API_Key" -Scope global -Force -WhatIf:$WhatIfPreference
    }
    else{
        Write-Verbose 'The ITGlue API key variable is not set. Nothing to remove'
    }
}



function Test-ITGlueAPIKey {
<#
    .SYNOPSIS
        Test the ITGlue API key

    .DESCRIPTION
        The Test-ITGlueAPIKey cmdlet tests the base URI & API key that are defined
        in the Add-ITGlueBaseURI & Add-ITGlueAPIKey cmdlets.

        Helpful when needing to validate general functionality or when using
        RMM deployment tools

        The ITGlue Regions endpoint is called in this test

    .PARAMETER base_uri
        Define the base URI for the ITGlue API connection
        using ITGlue's URI or a custom URI.

        By default the value used is the one defined by Add-ITGlueBaseURI function
            'https://api.itglue.com'

    .EXAMPLE
        Test-ITGlueApiKey

        Tests the base URI & API key that are defined in the
        Add-ITGlueBaseURI & Add-ITGlueAPIKey cmdlets.

    .EXAMPLE
        Test-ITGlueApiKey -base_uri http://myapi.gateway.example.com

        Tests the defined base URI & API key that was defined in
        the Add-ITGlueAPIKey cmdlet.

        The full base uri test path in this example is:
            http://myapi.gateway.example.com/regions

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$base_uri = $ITGlue_Base_URI
    )

    $resource_uri = "/regions"

    Write-Verbose "Testing API key against [ $($base_uri + $resource_uri) ]"

    try {

        $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)

        $rest_output = Invoke-WebRequest -Method Get -Uri ($base_uri + $resource_uri) -Headers $ITGlue_Headers -ErrorAction Stop
    }
    catch {

        [PSCustomObject]@{
            Method = $_.Exception.Response.Method
            StatusCode = $_.Exception.Response.StatusCode.value__
            StatusDescription = $_.Exception.Response.StatusDescription
            Message = $_.Exception.Message
            URI = $($base_uri + $resource_uri)
        }

    } finally {
        [void] ($ITGlue_Headers.Remove('x-api-key'))
    }

    if ($rest_output){
        $data = @{}
        $data = $rest_output

        [PSCustomObject]@{
            StatusCode = $data.StatusCode
            StatusDescription = $data.StatusDescription
            URI = $($base_uri + $resource_uri)
        }
    }
}



New-Alias -Name Set-ITGlueAPIKey -Value Add-ITGlueAPIKey