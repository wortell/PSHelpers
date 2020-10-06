function Convert-ToShortString {
    <#
    .SYNOPSIS
        returns an abreviate from the string you provide, try to get a 3 letter word
    .EXAMPLE
        PS> Get-ShortEnvironment -StringInput 'Test'
        tst
        PS>_

    .PARAMETER StringInput
        The string of the text file you'd like to make shorter
        If the word your provide is a well known one I try to make the best of it

    #>
    [CmdletBinding()]
    param (
        # this where you provide the string 
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [string]$StringInput
    )
    
    begin {
        # we do nothing here noting to initialise
    }
    
    process {
        if($StringInput.Length -gt 3 )
        {
            Switch ($StringInput)
            {
                "development"{ return "dev" }
                "production"{ return "prd" }
                "prod"      { return "prd" }
                "testing"   { return "tst" }
                "test"      { return "tst" }
                "staging"   { return "stg" }
                "testing"   { return "tst" }
                "acceptance"{ return "acc" }
                default     { return ($StringInput.ToLower() -replace '[aeiouy]').SubString(0,3) }
            }
        }
        else 
        {
            return  $StringInput.ToLower()
        }
    }
    
    end {
        # we do nothing here noting to cleanup
    }
}