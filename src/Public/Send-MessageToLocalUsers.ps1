Function Send-MessageToLocalUsers
{
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Message,

        # timeout for message
        [Parameter(HelpMessage="Seconds until the message is automatically discarded. Default is 0, means never.")]
        [int]
        $TimeOut = 0,

        # if should be logged to LogAnalytics
        [Parameter()]
        [switch]
        $Log
    ) 
    $PSDefaultParameterValues = $Global:PSDefaultParameterValues
    try 
    {
        Start-Process "$env:SystemRoot\System32\msg.exe" -ArgumentList "* /time $TimeOut /v '$Message' " -ErrorAction Stop
        If($Log) { Send-ToLogAnalytics -message "Message send to all users on this system." }
    }
    catch 
    {
        If($Log) { Send-ToLogAnalytics -message "Could not send message." }
    }
}