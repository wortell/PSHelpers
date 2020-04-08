<#
.SYNOPSIS
    Sends a given message to a custom log in Log Analytics workspace
.DESCRIPTION
Sends a given message to a custom log in Log Analytics workspace. Use PSDefaultParameterValues to shorten this command. This will improve readability of the script.
.EXAMPLE
    You could set some paramters once like here using $PSDefaultParameterValues
    $PSDefaultParameterValues = @{
        "Send-ToLogAnalytics:LogName"="myCustomLog";
        "Send-ToLogAnalytics:SharedKey"="<sharedKey>";
        "Send-ToLogAnalytics:CustomerId"="CustomerID or WorkspaceID";
        "Send-ToLogAnalytics:ScriptVersion"="<any value>";
        "Send-ToLogAnalytics:CorrelationId"= $(New-Guid | Select-Object -ExpandProperty Guid);
    }
    Send-ToLogAnalytics -message 'Send from Powershell to LogAnalytics using wrt.helpers Send-ToLogAnalytics' 
.PARAMETER Message
    Contents if this parameter will be passed to log analytics in the collumn message
.NOTES
    Besides 
#>
Function Send-ToLogAnalytics
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $Message,

        # the log name
        [Parameter(Mandatory)]
        [string]
        $LogName,

        # parameter to set a script version to the log message
        [Parameter(Mandatory)]
        [string]
        $ScriptVersion,

        # sets the correlationId to the log message, see this as a session ID this is unique to the session this script runs
        [Parameter(Mandatory)]
        [string]
        $CorrelationId,

        # sets the customer or workspaceId to which this message is send
        [Parameter(Mandatory)]
        [string]
        $CustomerId,

        # the sharedsecret which is used to as an API key
        [Parameter(Mandatory)]
        [string]
        $SharedKey
    )
    $ProgressPreference = "SilentlyContinue" 
    Write-Verbose $message
    $method = "POST"
    $contentType = "application/json"
    $resource = "/api/logs"
    $rfc1123date = [DateTime]::UtcNow.ToString("r")
    $ISO8601DateTime  = [DateTime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")

    $LogObject = New-Object -TypeName PSObject
    $LogObject | Add-Member -NotePropertyName ISO8601DateTime -NotePropertyValue $ISO8601DateTime
    $LogObject | Add-Member -NotePropertyName Computer -NotePropertyValue $($env:COMPUTERNAME)
    $LogObject | Add-Member -NotePropertyName Message -NotePropertyValue $Message
    $LogObject | Add-Member -NotePropertyName ScriptVersion -NotePropertyValue $ScriptVersion
    $LogObject | Add-Member -NotePropertyName LoggedOnUser -NotePropertyValue $loggedOnUser
    $LogObject | Add-Member -NotePropertyName CorrelationId -NotePropertyValue $CorrelationId
    
	
	$json = $LogObject | ConvertTo-Json -Compress
	$body = [System.Text.Encoding]::UTF8.GetBytes($json)

    $contentLength = $body.Length
    $signature = Build-Signature `
        -customerId $CustomerId `
        -sharedKey $SharedKey `
        -date $rfc1123date `
        -contentLength $contentLength `
        -fileName $fileName `
        -method $method `
        -contentType $contentType `
        -resource $resource
    $uri = "https://" + $CustomerId + ".ods.opinsights.azure.com" + $resource + "?api-version=2016-04-01"
    
    # time-generated-field	The name of a field in the data that contains the timestamp of the data item. If you specify a field then its contents are used for TimeGenerated. If this field isn’t specified, the default for TimeGenerated is the time that the message is ingested. The contents of the message field should follow the ISO 8601 format YYYY-MM-DDThh:mm:ssZ.
    $headers = @{
        "Authorization" = $signature;
        "Log-Type" = $LogName;
        "x-ms-date" = $rfc1123date;
        "time-generated-field" = "ISO8601DateTime";
    }
	
    $response = Invoke-WebRequest -Uri $uri -Method $method -ContentType $contentType -Headers $headers -Body $body -UseBasicParsing
    Start-Sleep -Milliseconds 100
}