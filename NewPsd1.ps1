param (
    [Parameter(Mandatory=$true)]
    $ModuleName,
    [Parameter(Mandatory=$true)]
    $Desciption
)

$ModuleName = 'TranscriptHandler'
$ModuleRoot = Join-Path $PWD "Modules" $ModuleName

$ManifestPath = Join-Path $ModuleRoot "$ModuleName.psd1"

New-ModuleManifest `
    -Path $ManifestPath `
    -RootModule "$ModuleName.psm1" `
    -ModuleVersion '1.0.0' `
    -Guid (New-Guid) `
    -Author 'Olaf Didszun' `
    -CompanyName 'PlanB. GmbH' `
    -Copyright '<none>' `
    -Description $Desciption `
    -PowerShellVersion '7.0' `
    -CompatiblePSEditions @('Core') `
    -FunctionsToExport @() `
    -CmdletsToExport @() `
    -VariablesToExport @() `
    -AliasesToExport @()
