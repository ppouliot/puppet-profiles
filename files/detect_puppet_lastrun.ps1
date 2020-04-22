Start-Process -FilePath 'C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat' -ArgumentList 'lastrun' -NoNewWindow -Wait | Tee-Object -Variable puppet_lastrun
$puppet_lastrun_response = "Error: 'lastrun' has no default action.  See ``puppet help lastrun``. "
$puppet_lastrun -eq (Write-Host $puppet_lastrun_response -ForegroundColor Red)
