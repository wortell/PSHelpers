<#
.SYNOPSIS
    Return $true if the value is found
.DESCRIPTION
    Return $true if the value is found, $false if not
.EXAMPLE
    PS C:\> Test-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Value "ProductName"
    The output of the function above will return true.
.OUTPUTS
    Boolean value which corresponds to the outcome
#>
function Test-RegistryValue 
{
param (

    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]$Path,

    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]$Value
)
    
    try 
    {
        Get-ItemProperty -Path $Path -ErrorAction Stop | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
        return $true
    }
    catch 
    {
        return $false
    }
}