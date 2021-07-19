# Credits - https://stackoverflow.com/questions/52621129/restart-docker-windows-10-command-line/55212066#55212066

Write-Output "$((Get-Date).ToString("HH:mm:ss")) - Starting Docker Desktop"
& "C:\Program Files\Docker\Docker\Docker Desktop.exe"
$startTimeout = [DateTime]::Now.AddSeconds(90)
$timeoutHit = $true
while ((Get-Date) -le $startTimeout)
{

    Start-Sleep -Seconds 10
    $ErrorActionPreference = 'Continue'
    try
    {
        $info = (docker info)
        Write-Verbose "$((Get-Date).ToString("HH:mm:ss")) - `tDocker info executed. Is Error?: $($info -ilike "*error*"). Result was: $info"

        if ($info -ilike "*error*")
        {
            Write-Verbose "$((Get-Date).ToString("HH:mm:ss")) - `tDocker info had an error. throwing..."
            throw "Error running info command $info"
        }
        $timeoutHit = $false
        break
    }
    catch 
    {

        if (($_ -ilike "*error during connect*") -or ($_ -ilike "*errors pretty printing info*")  -or ($_ -ilike "*Error running info command*"))
        {
            Write-Output "$((Get-Date).ToString("HH:mm:ss")) -`t Docker Desktop startup not yet completed, waiting and checking again"
        }
        else
        {
            Write-Output "Unexpected Error: `n $_"
            return
        }
    }
    $ErrorActionPreference = 'Stop'
}
if ($timeoutHit -eq $true)
{
    throw "Timeout hit waiting for docker to startup"
}

Write-Output "$((Get-Date).ToString("HH:mm:ss")) - Docker started"