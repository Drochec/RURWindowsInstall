#Set-ExecutionPolicy Unrestricted -Scope CurrentUser

Write-Output "Odstran?ní p?edinstalovaných aplikací`n"
Get-ChildItem -Recurse *.ps*1 | Unblock-File

.\Debloat-Windows-10-master\scripts\remove-default-apps.ps1
.\Debloat-Windows-10-master\scripts\remove-default-apps.ps1

Write-Output "P?idávám uživatele`n"
$adminpass = ConvertTo-SecureString "1357ruradmin" -AsPlainText -Force
$pass = ConvertTo-SecureString "chasmen" -AsPlainText -Force
New-LocalUser -Name "R.U.R. Admin" -Password $adminpass -PasswordNeverExpires
New-LocalUser -Name "R.U.R" -Password $pass -PasswordNeverExpires
Add-LocalGroupMember -Group "Administrators" -Member "R.U.R. Admin"
Add-LocalGroupMember -Group "Users" -Member "R.U.R"

Write-Output "Instaluji správce balík?`n"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Instaluji základní software`n"
choco install arduino microsoft-teams microsoft-teams.install microsoft-edge vscode googlechrome gimp vlc 7zip python

Write-Output "Instaluji Visual Studio"
./vs_community.exe --addProductLang Cs-cz --add Microsoft.VisualStudio.Workload.ManagedDesktop -p | Out-Null
#P?ídá ?eský jazyk, nainstaluje balík pro vývoj desktop aplikací .NET (Visual Basic, C#, atd.)

Write-Output "`n!Instalace dale pot?ebují potvrzení!`n"

Write-Output "Instaluji Programovací prost?edí pro EV3`n"
./EV3.exe | Out-Null

Set-ExecutionPolicy Restricted -Force -Scope CurrentUser

Write-Output "Všechna instalace hotova aktivujte Windows a Office"
& '.\KMS Digital Online Activation Suite v7.5 ENG\KMS_Suite.cmd'

