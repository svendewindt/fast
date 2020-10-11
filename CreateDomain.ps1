<#
.SYNOPSIS
  Script to create a domain with a single domain controller
.DESCRIPTION
  This script will create a new vm, install the domain roles on it and create a domain
.PARAMETER DomainControllerName
  Specifies the name of the domain controller, by default this is 'DC1'
.PARAMETER DomainName
  Specifies the name of the domain
.PARAMETER DomainControllerIPAddress
  Specifies the IP address of the domain controller

.INPUTS
  <Does the script accept an input>
.OUTPUTS
  A log file in the temp directory of the user running the script
.NOTES
  Version:        0.1
  Author:         Sven de Windt
  Creation Date:  <Date>
  Purpose/Change: Initial script development
.EXAMPLE
  <Give multiple examples of the script if possible>
#>

#requires -version 3.0

#-----------------------------------------------------------[Parameters]-----------------------------------------------------------

param(
    [CmdletBinding()]
        [parameter(mandatory = $false)][String]$Param1
)
#---------------------------------------------------------[Initialisations]--------------------------------------------------------

Set-StrictMode -Version Latest

# Set Error Action to Silently Continue
$ErrorActionPreference = "Stop"

# Dot Source required Function Libraries
#. "C:\Scripts\Functions\Logging_Functions.ps1"
. .\Convert-WindowsImage.ps1


#----------------------------------------------------------[Declarations]----------------------------------------------------------

$LogNumber = Get-Date -UFormat "%Y-%m-%d@%H-%M-%S"
$Log = "$($env:TEMP)\$($MyInvocation.MyCommand.Name) $($LogNumber).log"
$ScriptVersion = "0.1"
$SourceFolder = "Source"
$TemplateVhd = "Template2019-aug2020.vhdx"

#-----------------------------------------------------------[Functions]------------------------------------------------------------

Function Get-Folder (){
    param (
        [parameter(mandatory = $true)][String]$FolderName
    )
    try{
        if (-not(Test-Path $FolderName)) {
            New-Item -ItemType Directory $FolderName
        }
    } catch {
        Write-Error "Unable to get $($FolderName)"
        exit 1
    }
    return $FolderName
}

Function Get-File (){
    param (
        [parameter(mandatory = $false)][String]$FileName
    )

}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

Start-Transcript -Path $Log -NoClobber
$StopWatch = New-Object System.Diagnostics.Stopwatch
$StopWatch.Start()
Write-Output "Start script - version $($ScriptVersion)"

# Set source folder
$SourceFolder = Get-Folder -FolderName (Join-Path -path $PSScriptRoot -Childpath $SourceFolder)
# Set Template
#Get-File (and download if needed)

Copy-Item (Join-Path $SourceFolder $TemplateVhd) (Join-Path $PSScriptRoot "DC1")

#-----------------------------------------------------------[Finish up]------------------------------------------------------------
Write-Output $StopWatch.Elapsed
$StopWatch.Stop()
Write-Output "Finished script - $($MyInvocation.MyCommand.Name)"
Stop-Transcript
