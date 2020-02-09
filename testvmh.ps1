function test-vmh {
  [CmdletBinding()]
  param (
    [parameter(
      Mandatory = $true
      , ValueFromPipeline = $true
    )]$objectlist
  )

  begin {
    write-verbose "Start Begin Block: $(get-date -f s)"

    ## do stuff

    write-verbose "End Begin Block: $(get-date -f s)"
  } # end begin

  process {
    write-verbose "Start Process Block: $(get-date -f s)"
    foreach ($object in $objectlist) {
      write-verbose "Start foreach object in objectlist: $(get-date -f s)"
      Write-Verbose "object : $object"
      if ($objecttype = ($object.gettype()).name) {
        write-verbose "$object : $objecttype"
      } # end if $objecttype

      switch ($objecttype) {
        'string' { $vmh = get-vmhost $object }
        'VMHostImpl' { $vmh = $object }
        Default { }
      }

      write-verbose "vmhname : $($vmh.name)"


      write-verbose "End foreach object in objectlist: $(get-date -f s)"
    } # end foreach $esx
    write-verbose "End Process Block: $(get-date -f s)"
  } # end process


  end {
    write-verbose "Start End Block: $(get-date -f s)"

    ## do stuff

    write-verbose "End End Block: $(get-date -f s)"
  } # end end

} # end function test-vmh
