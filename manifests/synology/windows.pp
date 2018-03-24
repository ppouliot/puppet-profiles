# = Class profiles::synology::windows
# Synology Software for Windows

class profiles::synology::windows {

  staging::file{'synology-assistant-6.1-15163.exe':
    source => 'https://global.download.synology.com/download/Tools/Assistant/6.1-15163/Windows/synology-assistant-6.1-15163.exe'
  }
  staging::file{'Chat_Setup-1.0.0-33.exe':
    source => 'https://global.download.synology.com/download/Tools/ChatClient/1.0.0-33/Windows/Chat%20Setup%201.0.0-33.exe',
  }
  staging::file{'Synology_Cloud_Station_Backup-4.2.6-4408.msi':
    source => 'https://global.download.synology.com/download/Tools/CloudStationBackup/4.2.6-4408/Windows/Installer/Synology%20Cloud%20Station%20Backup-4.2.6-4408.msi',
  }

  staging::file{'Synology_Cloud_Station_Drive-4.2.6-4408.msi':
    source => 'https://global.download.synology.com/download/Tools/CloudStationDrive/4.2.6-4408/Windows/Installer/Synology%20Cloud%20Station%20Drive-4.2.6-4408.msi',
  }
  staging::file{'SynologyEIAuthenticator-1.2.0-021.exe':
    source => 'https://global.download.synology.com/download/Tools/EvidenceIntegrityAuthenticator/1.2.0-021/Windows/SynologyEIAuthenticator-1.2.0-021.exe',
  }
  staging::file{'synology-note-station-2.1.1-237-win-x64-Setup.exe':
    source => 'https://global.download.synology.com/download/Tools/NoteStationClient/2.1.1-237/Windows/x86_64/synology-note-station-2.1.1-237-win-x64-Setup.exe',
  }
  staging::file{Synology-PhotoStationUploader-Setup-087.exe':
    source => 'https://global.download.synology.com/download/Tools/PhotoStationUploader/1.4.3-087/Windows/Synology-PhotoStationUploader-Setup-087.exe',
  }
  staging::file{'Synology_Surveillance_Station_Client-1.1.2-0384_x64.exe':
    source => 'https://global.download.synology.com/download/Tools/SurveillanceStationClient/1.1.2-0384/Windows/x86_64/Synology%20Surveillance%20Station%20Client-1.1.2-0384_x64.exe',
  }
  staging::file{'SynologyCloudSyncDecryptionTool-013.zip':
    source => 'https://global.download.synology.com/download/Tools/SynologyCloudSyncDecryptionTool/013/Windows/SynologyCloudSyncDecryptionTool-013.zip',
  }
  staging::file{'Synology_Drive-1.0.2-10275.msi':
    source => 'https://global.download.synology.com/download/Tools/SynologyDriveClient/1.0.2-10275/Windows/Installer/Synology%20Drive-1.0.2-10275.msi',
  }
}

