
#create message box window & display starting message for the user
Add-Type -AssemblyName PresentationFramework
$messageBoxTitle = "Sora Technologies Network Test"
$messageBoxBody = "We are going to run some tests on your network, click OK to continue"
$messageBoxIcon = [System.Windows.MessageBoxImage]::Information
$messageBoxButton = [System.Windows.MessageBoxButton]::OK
[System.Windows.MessageBox]::Show($messageBoxBody,$messageBoxTitle,$messageBoxButton,$messageBoxIcon)

#gets the default gateway from WMIC
$gateway = Get-WmiObject -Class Win32_IP4RouteTable |
where { $_.destination -eq '0.0.0.0' -and $_.mask -eq '0.0.0.0'} |
Sort-Object metric1 | select nexthop


#performs network tests and adjusts message box information
if (Test-connection $gateway.nexthop) {
    Write-Host "We were able to reach your router"
    if (Test-Connection 8.8.8.8 -ErrorAction SilentlyContinue){
        $messageBoxBody = "Internet is working"
        [System.Windows.MessageBox]::Show($messageBoxBody,$messageBoxTitle,$messageBoxButton,$messageBoxIcon)    }
    else{
        $messageBoxBody = "We were able to reach your router, but not the internet, your ISP may be experiencing an outage. Please contact Sora and we will reach out to your ISP on your behalf. 309-693-7672"
        $messageBoxIcon = [System.Windows.MessageBoxImage]::Error
        [System.Windows.MessageBox]::Show($messageBoxBody,$messageBoxTitle,$messageBoxButton,$messageBoxIcon)    }
}
else{
    Write-Host "We were unable to reach your router trying to resolve..."
    ipconfig /release 
    ipconfig /renew
    if(Test-Connection $gateway.nexthop){
        $messageBoxBody = "We were able to restore your internet connection."
        [System.Windows.MessageBox]::Show($messageBoxBody,$messageBoxTitle,$messageBoxButton,$messageBoxIcon)    }
    else{
        $messageBoxBody = "We are unable to restore your internet connection. Please contact Sora for further assistance. 309-693-7672"
        [System.Windows.MessageBox]::Show($messageBoxBody,$messageBoxTitle,$messageBoxButton,$messageBoxIcon) 
        ipconfig /all | Out-File C:\soratemp\ipconfig.txt
       }
}



