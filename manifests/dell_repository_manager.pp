class profiles::dell_repository_manager (
) {
  # Dell Repository Manager
  # https://downloads.dell.com/FOLDER03680800M/1/Dell_Repository_Manager_2.2.0.614.exe
  # https://downloads.dell.com/FOLDER03680801M/1/Dell_Repository_Manager_2_2_A00_Release_Notes.pdf
  
  archive{'C:/ProgramData/staging/Dell_Repository_Manager_2_2_A00_Release_Notes.pdf':
    source => 'https://downloads.dell.com/FOLDER03680801M/1/Dell_Repository_Manager_2_2_A00_Release_Notes.pdf',
  } ->
  archive{'C:/ProgramData/staging/Dell_Repository_Manager_2.2.0.614.exe':
    source => 'https://downloads.dell.com/FOLDER03680800M/1/Dell_Repository_Manager_2.2.0.614.exe',
  } ->
  package{'Dell Repository Manager':
    ensure          => installed,
    provider        => 'windows',
    source          => 'C:/Programdata/staging/Dell_Repository_Manager_2.2.0.614.exe', 
    install_options => [ '/S', '/V/qn' ],
  }
}
