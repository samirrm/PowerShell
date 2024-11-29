$Computer = 'COMPUTERNAME_01','COMPUTERNAME_02'

#Write-Output $Computer[2]


for ($i = 0; $i -lt 2; $i++) {
    Write-Output $Computer[$i]

}