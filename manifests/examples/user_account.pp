# Defined type for creating virtual user accounts
#
#
#  @profiles::user_account {'ovswitch':
#    uid => 500,
#    realname => 'OpenVSwitch Account',
#  }
#
define profiless::user_account ($uid,$realname,$pass,$homedir) {
  user { $title:
    ensure     =>  'present',
    uid        =>  $uid,
    gid        =>  $title,
    shell      =>  '/bin/bash',
    home       =>  "/home/${title}",
    comment    =>  $realname,
    password   =>  $pass,
    managehome =>  true,
    require    =>  Group[$title],
  }
  group { $title:
    gid =>  $uid,
  }
  if $homedir == undef {
    $homedir = "/home/${title}"
  }
  file { $homedir:
    ensure  =>  directory,
    owner   =>  $title,
    group   =>  $title,
    mode    =>  '0750',
    require =>  [ User[$title], Group[$title] ],
  }
}
