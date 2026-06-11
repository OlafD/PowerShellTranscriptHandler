using module TranscriptHandler

$th = [TranscriptHandler]::new("Test")
# $th = [TranscriptHandler]::new("")

$th.Start("StageOne")

Write-Host "This is a message."

$th.Stop()
