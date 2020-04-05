function Test-IsProductEnabled {
    <#
    .SYNOPSIS
        Tests if given product state has product state flag enabled
    .DESCRIPTION
        Registry, WMI and other propties may contain a DWORD value or data object that represents the state of the corresponding product.
        Specific enablement of the product is set to a bit in this DWORD, it can be challenging to gather the exact value of the flag.
        This function will return true if the flag is set, meaning it is enabled. 
    .PARAMETER ProductState
        The value (DWORD) containing the bitflags.
    .EXAMPLE
        PS C:\> Test-IsProductEnabled -ProductState 393472
        $false
        This example shows basic functionality
    .OUTPUTS
        Bool
    .NOTES
        This function was build to resolve the state of a Antivirus Provider registered in Security Center. 
        Using this function it is possible to read which provider is enabled or not.
        Other states are Snoozed which can be tested with Test-ProductIsSnoozed
    #>
    [CmdletBinding()]
    param (
        # Product State contains a value (DWORD) that contains multiple bitflags and we use the productState flag (0000F000)
        [Parameter(Mandatory, Position=0, ValueFromPipeline, HelpMessage="The value (DWORD) containing the bitflags.")]
        [Int32]$ProductState
    )
    $ProductEnabled = 0x1000
    $ProductStateMask = 0x0000f000
    
    try 
    {
        if( $($ProductEnabled -and $($ProductState -band $ProductStateMask) ) )
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