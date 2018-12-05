# CAM_Installer V3.3.0.exe
# https://camwebapp.com/download
# http://cambinaries.blob.core.windows.net/installer/CAM_Installer%20V3.5.90.exe
class profiles::nzxt_cam (){
  archive{'C:/Programdata/drivers/lighting/CAM_Installer V3.5.90.exe':
    source => 'http://cambinaries.blob.core.windows.net/installer/CAM_Installer%20V3.5.90.exe',
    extract      => true,
  	extract_path => 'C:/Programdata/drivers/GIGABYTE/GA-Z170N-WIFI/utility',
    creates      => 'C:/ProgramData/drivers/GIGABYTE/GA-Z170N-WIFI/utility',
  }  
}
