$ITGlue_Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"   
$ITGlue_Headers.Add("Content-Type", 'application/vnd.api+json; charset=utf-8') 

Set-Variable -Name "ITGlue_Headers"  -Value $ITGlue_Headers -Scope global


Import-ITGlueModuleSettings
