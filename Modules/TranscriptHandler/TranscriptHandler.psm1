class TranscriptHandler
{
    <########## public members ##########>

    [bool] $TranscriptRunning

    <########## hidden/private members ##########>

    hidden [string] $_Identifier
    hidden [string] $_TranscriptPath
    hidden [string] $_CurrentTranscriptFile

    <########## constructors ##########>

    TranscriptHandler([string] $Identifier)
    {
        if ($Identifier -ne "")
        {
            $this._Identifier = $Identifier
            $this._TranscriptPath = ".\"
            $this.TranscriptRunning = $false
        }
        else
        {
            throw "The identifier must not be empty"
        }
    }

    TranscriptHandler([string] $Identifier, [string] $Path)
    {
        if ($Identifier -ne "")
        {
            $this._Identifier = $Identifier
            $this.TranscriptRunning = $false
        }
        else
        {
            throw "The identifier must not be empty"
        }

        if ($this._IsPathValid($Path) -eq $true)
        {
            $this._TranscriptPath = $Path
            $this.TranscriptRunning = $false
        }
        else
        {
            throw "The path '$Path' is invalid for a transcript file"
        }
    }

    <########## public methods ##########>

    <#
        Start the transcript without an additional literal.
    #>
    [void] Start()
    {
        $filename = $this._BuildPathFile("")

        Start-Transcript -Path $filename

        $this.TranscriptRunning = $true
        $this._CurrentTranscriptFile = $filename
    }

    <#
        Start the transcript with an additional literal.
    #>
    [void] Start([string] $Literal)
    {
        $filename = $this._BuildPathFile($Literal)

        Start-Transcript -Path $filename

        $this.TranscriptRunning = $true
        $this._CurrentTranscriptFile = $filename
    }

    <#
        Stop the transcript.
    #>
    [void] Stop()
    {
        if ($this.TranscriptRunning -eq $true)
        {
            Stop-Transcript

            $this.TranscriptRunning = $false

            Write-Host "Transcript written to '$($this._CurrentTranscriptFile)'"
        }
    }

    <########## hidden/private methods ##########>

    [bool] _IsPathValid([string] $Path)
    {
        return (Test-Path -Path $Path -PathType Container)
    }

    [string] _BuildPathFile([string] $Literal)
    {
        $transcriptExtension = Get-Date -Format yyyyMMdd-HHmmss

        if ($Literal -eq "")
        {
            $transcriptFile = "$($this._TranscriptPath)\$($this._Identifier)-$transcriptExtension.txt"
        }
        else 
        {
            $transcriptFile = "$($this._TranscriptPath)\$($this._Identifier)-$($Literal)-$transcriptExtension.txt"
        }

        return $transcriptFile
    }
}
