try {
    $client = New-Object System.Net.Sockets.TcpClient
    $asyncResult = $client.BeginConnect($args[0], [int]$args[1], $null, $null)
    if (-not $asyncResult.AsyncWaitHandle.WaitOne(30000, $false)) {
        $client.Close()
        Write-Host "Connection timed out after 30 seconds."
        exit 1
    }
    $client.EndConnect($asyncResult)

    $stream = $client.GetStream()
    $writer = New-Object System.IO.StreamWriter($stream)
    $writer.WriteLine($args[2])
    $writer.Flush()

    $reader = New-Object System.IO.StreamReader($stream)
    $startTime = Get-Date
    while (-not $stream.DataAvailable) {
        Start-Sleep -Milliseconds 100
        if ((Get-Date) - $startTime -gt [TimeSpan]::FromSeconds(30)) {
            Write-Host "Read timed out after 30 seconds."
            $writer.Close()
            $reader.Close()
            $client.Close()
            exit 1
        }
    }
    while (($line = $reader.ReadLine()) -ne $null) {
        Write-Host $line
    }
    $writer.Close()
    $reader.Close()
    $client.Close()
} catch {
    if ($_.Exception.InnerException -and $_.Exception.InnerException.Message -match "No such host is known") {
        Write-Host "Unknown host: $($args[0])"
    } elseif ($_.Exception.InnerException -and $_.Exception.InnerException.Message -match "actively refused" ) {
        Write-Host "Unknown connection or port: $($args[0]):$($args[1])"
    } else {
        Write-Host "An error occurred: $_"
    }
    exit 1
}