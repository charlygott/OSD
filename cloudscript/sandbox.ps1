<#PSScriptInfo
.VERSION 22.4.16.1
.GUID 55a834b8-513e-4399-bbdb-2e54a1305eee
.AUTHOR David Segura @SeguraOSD
.COMPANYNAME osdcloud.com
.COPYRIGHT (c) 2022 David Segura osdcloud.com. All rights reserved.
.TAGS OSDeploy OSDCloud WinPE OOBE Windows AutoPilot
.LICENSEURI 
.PROJECTURI https://github.com/OSDeploy/OSD
.ICONURI 
.EXTERNALMODULEDEPENDENCIES 
.REQUIREDSCRIPTS 
.EXTERNALSCRIPTDEPENDENCIES 
.RELEASENOTES
Script should be executed in a Command Prompt using the following command
powershell Invoke-Expression -Command (Invoke-RestMethod -Uri sandbox.osdcloud.com)
This is abbreviated as
powershell iex(irm sandbox.osdcloud.com)
#>
<#
.SYNOPSIS
    PSCloudScript at sandbox.osdcloud.com
.DESCRIPTION
    PSCloudScript at sandbox.osdcloud.com
.NOTES
    Version 22.4.16.1
.LINK
    https://raw.githubusercontent.com/OSDeploy/OSD/master/cloudscript/sandbox.ps1
.EXAMPLE
    powershell iex (irm sandbox.osdcloud.com)
#>
[CmdletBinding()]
param()

#region Initialize
$SandboxVersion = '22.4.16.1'
$Transcript = "$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-OSDCloud.log"
$null = Start-Transcript -Path (Join-Path "$env:SystemRoot\Temp" $Transcript) -ErrorAction Ignore

if ($env:SystemDrive -eq 'X:') {$WindowsPhase = 'WinPE'}
else {
    $ImageState = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State' -ErrorAction Ignore).ImageState
    if ($env:UserName -eq 'defaultuser0') {$WindowsPhase = 'OOBE'}
    elseif ($ImageState -eq 'IMAGE_STATE_SPECIALIZE_RESEAL_TO_OOBE') {$WindowsPhase = 'Specialize'}
    elseif ($ImageState -eq 'IMAGE_STATE_SPECIALIZE_RESEAL_TO_AUDIT') {$WindowsPhase = 'AuditMode'}
    else {$WindowsPhase = 'Windows'}
}
Write-Host -ForegroundColor DarkGray "Starting OSDCloud $WindowsPhase Sandbox $SandboxVersion"
Invoke-Expression -Command (Invoke-RestMethod -Uri functions.osdcloud.com)
#endregion

#region WinPE
if ($WindowsPhase -eq 'WinPE') {
    osdcloud-StartWinPE -OSDCloud -KeyVault
    Write-Host -ForegroundColor Cyan "To start a new PowerShell session, type 'start powershell' and press enter"
    Write-Host -ForegroundColor Cyan "Start-OSDCloud or Start-OSDCloudGUI can be run in the new PowerShell session"
    $null = Stop-Transcript
}
#endregion

#region Specialize
if ($WindowsPhase -eq 'Specialize') {
    #Do something
    $null = Stop-Transcript
}
#endregion

#region AuditMode
if ($WindowsPhase -eq 'AuditMode') {
    #Do something
    $null = Stop-Transcript
}
#endregion

#region OOBE
if ($WindowsPhase -eq 'OOBE') {
    osdcloud-StartOOBE -Display -Language -DateTime -Autopilot -KeyVault
    #Do something
    $null = Stop-Transcript
}
#endregion

#region Windows
if ($WindowsPhase -eq 'Windows') {
    #Do something
    $null = Stop-Transcript
}
#endregion