function set-persistentlog {
  [CmdletBinding()]
  param (
    [string[]]$esxlist
  )

  begin {

  }

  process {
    foreach ($esx in $esxlist) {
      $vmh = get-vmhost $esx
      $esxcli = get-esxcli -VMHost $vmh -V2
      $adv = 'ScratchConfig.ConfiguredScratchLocation'
      if ($ds = $vmh | gds *scratch*) {
        $psdrivename = 'ds'
        New-PSDrive -name $psdrivename -Root \ -PSProvider VimDatastore -Datastore $ds


        $path1 = '/vmfs/volumes'
        #$path2 = ($esxcli.storage.filesystem.list.invoke() | ? { $_.volumename -match 'scratch' }).uuid
        $path2 = $ds.name + "/"
        $path3 = ".locker-$($vmh.name)"
        #$path4 = $vmh.Name

        $path = join-path -path $path1 -ChildPath $path2 |
        join-path -ChildPath $path3 #|
        #join-path -ChildPath $path4

        $path = $path.replace('\', '/')

        #$path

        $setadvparam = @{
          advancedsetting = $vmh | Get-AdvancedSetting -Name $adv
          value           = $path
          confirm         = $false
        }
        $path
        $path3
        $dspath = "$psdrivename`:$path3"
        new-item -ItemType Directory -Name $path3 -Path "$($psdrivename)`:"
        Set-AdvancedSetting @setadvparam

        #$setting = $vmh | get-advancedsetting -name $adv
        #$setting | Set-AdvancedSetting -Value $path -confirm:$false
        #Set-Advancedsetting -VMHost $vmh -Name $adv -Value ([string]"$path")

        get-psdrive $psdrivename | remove-psdrive

      } else {
        write-host "no datastore found" ;break
      }
    }
  }

  end {

  }
}
