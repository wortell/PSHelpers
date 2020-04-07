<#
.SYNOPSIS
    Removes a  value from the registry
.DESCRIPTION
    Removes a  value from the registry and returns true or false if successfull or not
.EXAMPLE
    PS C:\> Remove-Registry -Path "HKLM:\testkey" -Value "testValue"
    Removes the value testValue from HKLM:\testkey
.NOTES
    General notes
.OUTPUTS
    Boolean value which corresponds to the outcome
#>
function Remove-RegistryValue 
{
    param (
        # the path to the value
        [Parameter()]
        [string]
        $Path,

        # the name of the value
        [Parameter()]
        [string]
        $Value,

        # if should be logged to LogAnalytics
        [Parameter()]
        [switch]
        $Log
    )
    $PSDefaultParameterValues = $Global:PSDefaultParameterValues
    If(Test-Path $RegistryPath)
    {
        If(Test-RegistryValue -Path $RegistryPath -Value $RegistryValue)
        {
            try 
            {
                Remove-ItemProperty -Path $RegistryPath -Name $RegistryValue -ErrorAction Stop
                If($Log) { Send-ToLogAnalytics -message "Removed $RegistryValue in path $RegistryPath." }
            }
            catch 
            {
                If($Log) { Send-ToLogAnalytics -message "Could not remove $RegistryValue in path $RegistryPath. $($_.Exception) $($_.ErrorDetails)" }
            }
        }
    }
}