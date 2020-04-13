function Test-IsProductStateOn {
    <#
    .SYNOPSIS
        Tests if given product state has product state flag to On
    .DESCRIPTION
        Registry, WMI and other properties may contain a DWORD value or data object that represents the state of the corresponding product.
        Specific state of the product is set to a bit in this DWORD, these states can be optained using bitwise operations.
        This function will return true if the flag for product state is set to on, meaning this product is enabled. 
    .PARAMETER ProductState
        The value (DWORD) containing the bitflags.
    .EXAMPLE
        PS C:\> Test-IsProductStateOn -ProductState 393472
        False
        This example shows basic functionality
    .OUTPUTS
        Bool
    .NOTES
        This function was build to resolve the state of a Antivirus Provider registered in Security Center. 
        Using this function it is possible to read which product is set to On or not.
        Other states are Off, Snoozed and Expired which can be resolved by using the enums provided in this module. 
        Example: Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Where-Object {($_.productState -band [ProductFlags]::ProductState) -eq [ProductState]::Off}
        Will list all products that are disabled.
        Use Add-ProductStates to return the actual state or cast the value using the stateflag
        $prod = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct 
        [SignatureStatus]($prod[0].productState -band [ProductFlags]::SignatureStatus)
    #>
    [CmdletBinding()]
    param (
        # Product State contains a value (DWORD) that contains multiple bitflags and we use the productState flag (0000F000)
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName, HelpMessage = "The value (DWORD) containing the bitflags.")]
        [Alias("STATE")]
        [UInt32]$ProductState
    )
    
    try 
    {
        if( $([ProductState]::On -and $($ProductState -band [ProductFlags]::ProductState) ) )
        {
            return $true
        }
        else 
        {
            return $false
        }
    }
    catch 
    {
        return $false
    }
}