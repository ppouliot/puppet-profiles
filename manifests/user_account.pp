# Defined type for creating virtual user accounts
#
define profiless::user_account ($uid,$realname,$pass) {
 
  user { $title:
    ensure            =>  'present',
    uid               =>  $uid,
    gid               =>  $title,
    shell             =>  '/bin/bash',
    home              =>  "/home/${title}",
    comment           =>  $realname,
    password          =>  $pass,
    managehome        =>  true,
    require           =>  Group[$title],
  }
 
  group { $title:
    gid               =>  $uid,
  }
 
  file { "/home/${title}":
    ensure            =>  directory,
    owner             =>  $title,
    group             =>  $title,
    mode              =>  0750,
    require           =>  [ User[$title], Group[$title] ],
  }
}
