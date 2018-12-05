# Razor Synapse
class razor_synapse (){
  # Razor Synapse
  # http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Installer_v2.21.20.606.exe
  archive{'C:/ProgramData/drivers/mouse/Razer_Synapse_Installer_v2.21.20.606.exe':
    source => 'http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Installer_v2.21.20.606.exe',
  }
}