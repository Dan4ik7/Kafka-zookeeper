function zcheck {
    param(
        [string]$zkhost,
        [int]$port,
        [string]$cmd
    )

    function Show-Usage {
        Write-Host "<ARG> List:"
        $help = @{
            conf = "Print details about serving configuration."
            cons = "List full connection/session details for all clients connected to this server."
            dump = "Lists the outstanding sessions and ephemeral nodes. This only works on the leader."
            envi = "Print details about serving environment"
            ruok = "Tests if server is running in a non-error state."
            srvr = "Lists full details for the server."
            stat = "Lists brief details for the server and connected clients"
            wchs = "Lists brief information on watches for the server."
            wchc = "Lists detailed information on watches for the server, by session."
            wchp = "Lists detailed information on watches for the server, by path."
            mntr = "Outputs a list of variables that could be used for monitoring the health of the cluster."
        }
        foreach ($k in $help.Keys) {
            Write-Host (" {0,-6} {1}" -f $k, $help[$k])
        }
    }

    switch ($true) {
        { -not $zkhost } {
            Write-Host "Usage: zcheck <zookeeper> <port> <ARG>"
            Write-Host "<zookeeper> must be provided, either IP of zookeeper or hostname."
            Show-Usage
            return
        }
        { -not $port } {
            Write-Host "Usage: zcheck $zkhost <port> <ARG>"
            Write-Host "<port> of the zookeeper server must be provided."
            Write-Host "Usually it is 2181, but it can be different."
            Show-Usage
            return
        }
        { -not $cmd } {
            Write-Host "Usage: zcheck $zkhost $port <ARG>"
            Show-Usage
            return
        }
        { $cmd.ToLower() -notin @("conf","cons","dump","envi","ruok","srvr","stat","wchs","wchc","wchp","mntr") } {
            Write-Host "Unknown command: $cmd"
            Show-Usage
            return
        }
        default {
            & "C:\zcheck.ps1" $zkhost $port $cmd
        }
    }
}