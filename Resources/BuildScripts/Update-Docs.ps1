﻿Clear-Host
#Install-Module -Name platyPS -Scope CurrentUser
Import-Module platyPS
Import-Module OSD -Force
New-MarkdownHelp -Module OSD -OutputFolder $(Join-Path (Get-Module -Name OSD -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1).ModuleBase 'Docs') -Force
New-ExternalHelp $(Join-Path (Get-Module -Name OSD -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1).ModuleBase 'Docs') -OutputPath $(Join-Path (Get-Module -Name OSD -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1).ModuleBase 'en-US') -Force