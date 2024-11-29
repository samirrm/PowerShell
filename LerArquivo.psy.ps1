$Text = Get-Content -Path C:\PASSWD.txt 
$Text.GetType() | Format-Table -AutoSize

Write-Output "Tex:" $Text
