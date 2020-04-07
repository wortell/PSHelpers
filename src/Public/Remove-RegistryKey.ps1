<#
.SYNOPSIS
    Removes a complete key from the registry
.DESCRIPTION
    Removes a complete key from the registry and returns true or false if successfull or not
.EXAMPLE
    PS C:\> Remove-RegistryKey -Path "HKLM:\testkey"
    Removes the Key HKLM:\testkey
.NOTES
    General notes
.OUTPUTS
    Boolean value which corresponds to the outcome
#>
function Remove-RegistryKey
{
    param (
        # the path to the value
        [Parameter()]
        [string]
        $KeyPath,

        # if should be logged to LogAnalytics
        [Parameter()]
        [switch]
        $Log
    )
    $PSDefaultParameterValues = $Global:PSDefaultParameterValues
    If(Test-Path $KeyPath)
    {
        try 
        {
            Remove-Item -Path $KeyPath -ErrorAction Stop -Recurse -Force
            If($Log) { Send-ToLogAnalytics -message "Removed $KeyPath." }
        }
        catch 
        {
            If($Log) { Send-ToLogAnalytics -message "Could not remove $KeyPath. $($_.Exception) $($_.ErrorDetails)" }
        }
    }
}