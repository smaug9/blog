# build nested hashtable
$h = @{ }
$h.a = @{ }
$h.b = @{ }
$h.c = @{ }
$h.a.a = '1234'
$h.b.a = 'asdf'
$h.c.a = 'qwer'
# iterate through nested hashtable
foreach ($k in $h.keys) { "$k : $(($h[$k]).a)" }
c : qwer
b : 1234
a : asdf

#build stig nested hashtable
$stiglist = @{
    ESXI_65_000004 = @{
        description = 'configure syslog remote host'
        target      = 'udp://syslog.domain.com:514'
        settingname = 'Syslog.global.loghost'
    }
    ESXI_65_000005 = @{
        description = 'Account Lock Failures'
        target      = '3'
        settingname = 'Security.AccountLockFailures'
    }
    ESXI_65_000006 = @{
        description = 'Account Unlock Time'
        target      = '900'
        settingname = 'Security.AccountUnlockTime'
    }
}

$report = foreach ($stig in $stiglist.keys) {
    $stigprop = $stiglist[$stig]
    [PSCustomObject]@{
        stigid      = $stig
        description = $stigprop.description
        target      = $stigprop.target
        settingname = $stigprop.settingname
    }
}
 
$report
