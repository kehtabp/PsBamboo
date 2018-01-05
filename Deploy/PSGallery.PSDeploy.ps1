﻿# Publish to gallery with a few restrictions
if ($env:BHPSModulePath -and $env:BHBuildSystem -ne 'Unknown' -and $env:BHBranchName -eq "master" -and $env:BHCommitMessage -match '!deploy') {
    Deploy Module {
        By PSGalleryModule {
            FromSource $ENV:BHPSModulePath
            To PSGallery
            WithOptions @{
                ApiKey = $ENV:PsGalleryApiKey
            }
        }
    }
} else {
    "Skipping deployment: To deploy, ensure that...`n" +
    "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
    "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +
    "`t* Your commit message includes !deploy (Current: $ENV:BHCommitMessage)" |
    Write-Host
}
