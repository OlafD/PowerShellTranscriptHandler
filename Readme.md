# TranscriptHandler module

In PowerShell scripts we can create transcripts that write the output during script execution to a text file. The TranscriptHandler module should help with creating the filename for the transcript and the start/stop handling.

To use the module just a using module entry on top of the main script file (the one that is executed) is needed.

```
using module TranscriptHandler
```

To get an instance for the TranscriptHandler, one of the constructors of the implemented class needs to be executed. We have the following constructors in the class:

```
# single parameter
$th = [TranscriptHandler]::new("Test")

# two parameters
$th = [TranscriptHandler]::new("Test", "C:\Transcripts")
```

In the single parameter approach, we just have an identifier that would be added to the transcript filename. The transcript file will be written to the current folder. The value of the parameter must not be an empty string.

The two parameter approach will get the identifier as the first parameter and the folder, where the transcript should be stored. Both parameters must not be empty and the folder must already exist.

To start the transcript, the method Start() must be executed. The method has two signatures:

```
$th.Start()

$th.Start("StageOne")
```

Without any parameter the filename of the transcript will just contain the identifier, used in the constructor. An example will look like 'Test-20260611-111736.txt'.

When the Start() method is called with a parameter, this value is added behind the identifier. An example will look like 'Test-StageOne-20260611-111736.txt'. 

To stop the transcript at the end of the script execution, the Stop() method needs to be called:

```
$th.Stop()
```

To make sure, the transcript will always be closed, even when we have unhandled exceptions during script execution, the main part of the script should run in the try-element of a try/catch structure. An example would look like this:

```
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
```

When the script can handle exceptions on its own, the catch part would not be called and in the finally part the transcript will be stopped. 
