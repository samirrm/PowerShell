param (
        
    $NomeServico
    
)

function conectionServico {
    param (
        
        $adminUserName, $adminPassword, $secpasswd, $credential, $names, $action, $service, $computerName
        
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

                    $result = $true
                    if ($action -eq 'Stop-WebAppPool') {
                        $state = Get-WebAppPoolState -Name $service
                        if ($state.Value -eq 'Stopped') {
                            Write-Warning("WebAppPool $($service) already $($state.Value)")
                            $result = $false
                        }
                    }
                    elseif ($action -eq 'Stop-Website') { 
                        $state = Get-WebsiteState -Name $service
                        if ($state.Value -eq 'Stopped') {
                            Write-Warning("Website $($service) already $($state.Value)")
                            $result = $false
                        }
                    }
                    elseif ($action -eq 'Restart-WebAppPool') { 
                        $state = Get-WebAppPoolState -Name $service
                        if ($state.Value -eq 'Stopped') {
                            Write-Warning("WebAppPool $($service) already $($state.Value)")
                            $result = $false
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
}

Write-Output "Arq. Nome Servico:" $NomeServico
#$NomeServico = 'ReactServicesETC'
$action = 'Start-WebAppPool'
$computerName = '<servidor>', '<servidor2>'
$adminUserName = <conta acesso>
[String] $service = $NomeServico
[String] $names = $NomeServico
#Path ServerMonitoramento
$adminPassword = Get-Content -Path C:\Windows\PASSWD\PASSWD.txt
#Path LOCAL
#$adminPassword = Get-Content -Path C:\FonteDesenvolvimentoSamirVSTS\Scripts\PASSWD.txt
$adminPassword.GetType() | Format-Table -AutoSize
Write-Output "Senha Usada:" $adminPassword

for ($i = 0; $i -lt 2; $i++) {
    Write-Output "service:" $service
    Write-Output "names:" $names

    conectionServico $adminUserName $adminPassword $secpasswd $credential $names $action $service $computerName[$i]
    Exit-PSSession
}