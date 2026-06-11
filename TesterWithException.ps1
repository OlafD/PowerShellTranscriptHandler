using module TranscriptHandler

<#
    The try part contains the whole handling of the script. 
    The catch part will handle (output) unhandled exceptions.
    The finally part should make should the transcript is finished and closed.

    When we do not use this approach, whenever we have an unhandled exception
    in the script, the transcript will not be closed and the consumed information
    is lost.
#>

try 
{
    # $th = [TranscriptHandler]::new("Test")
    $th = [TranscriptHandler]::new("Test", "C:\Temp")

    $th.Start("StageOne")

    Write-Host "This is a message."

    $x = 1 / 0

    Write-Host $x
}
catch 
{
    Write-Host $_.Exception.InnerException
    Write-Host "-----"
    Write-Host $_.ScriptStackTrace
}
finally
{
    $th.Stop()
}
