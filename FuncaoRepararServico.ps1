function conectionServico {
    param (
        
        [string]$adminUserName, $adminPassword, $secpasswd, $credential, $names, $action, $service, $computerName
        
    )

    process {

        $action = $action -replace ' ', '-'
        if (![string]::IsNullOrWhiteSpace($adminUserName)) {
        
            $secpasswd = ConvertTo-SecureString $adminPassword -AsPlainText -Force
            $credential = New-Object -typename System.Management.Automation.PSCredential -ArgumentList $adminUserName, $secpasswd
        
            $names.Split(";") | ForEach-Object -Process {
                Write-Output "$($action) $($_)"
                Invoke-Command -ComputerName $computerName -Credential $credential -ScriptBlock {
                    param($service, $action)
                    Get-Module WebAdministration

                        if ($state.Value -eq 'Stopped') {
                            Write-Warning("WebAppPool $($service) already $($state.Value)")
                            
                            Invoke-Expression  "Start-WebAppPool -Name '$($service)'"
                        }
                    }
        
                    if ($result) {
                        Invoke-Expression  "$($action) -Name '$($service)'"
                    }


                } -ArgumentList $_, $action
            }

        }
    }

param ( $NomeServico ) 

#$NomeServico = 'ReactPaginaETC'
$action = 'Start-WebAppPool'

$computerName = '<servidor>', '<servidor2>'
$adminUserName = <conta>
$service = $NomeServico
$names = $servico
$adminPassword = Get-Content C:\Conta\Scripts\PASSWD.txt 
$adminPassword.GetType() | Format-Table -AutoSize
Write-Output "Senha Usada:" $adminPassword

for ($i = 0; $i -lt 2; $i++) {
    
    conectionServico $adminUserName $adminPassword $secpasswd $credential $names $action $service $computerName[$i]

}



