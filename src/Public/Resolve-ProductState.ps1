<#
.SYNOPSIS
    Resolves several statuses of a product object.
.DESCRIPTION
    Resolves several statuses of a product object. If this function is be used 
    in a pipeline it will add properties to a product object. These properties reflect 
    several statuses that a product can relect using the State DWORD using bitfields. 
    Extracting these can be challenging and this function will help testing these values.
.EXAMPLE
    PS C:\> Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Resolve-Productstate
    Will result in:

.PARAMETER ProductState
    The value (DWORD) containing the bitflags.
.PARAMETER Products
    PSObject containing object array of Microsoft.Management.Infrastructure.CimInstance#ROOT/SecurityCenter2/AntiVirusProduct
.OUTPUTS
    Output (if any)
.NOTES
    This function utilizes Test-IsProductEnabled, ... To enrich information on State.
#>
function Resolve-ProductState {
    [CmdletBinding()]
    param (
        # This parameter can be passed from pipeline and can contain and array of collections that contain State or productstate members
        [Parameter(ValueFromPipeline)]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Products,
        # Product State contains a value (DWORD) that contains multiple bitflags and we use the productState flag (0000F000)
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName, HelpMessage = "The value (DWORD) containing the bitflags.")]
        [Alias("STATE")]
        [UInt32]$ProductState
    )  
    
    process {
        if ($Products -is [array]) {
            If ($Products.Count -gt 0) {
                If (Get-Member -inputobject $Products[0] -name "productState" -Membertype Properties) {
                    foreach ($item in $Products) {
                        $item | Add-Member -NotePropertyName Enabled -NotePropertyValue $(Test-IsProductEnabled -ProductState $item.productState)
                    }
                }
            }
        }
    }
}