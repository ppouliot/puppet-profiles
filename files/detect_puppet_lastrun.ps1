$puppet_lastrun = (C:\Program Files\Puppet Labs\Puppet\puppet\bin\puppet lastrun)
$puppet_lastrun_response = "Error: 'lastrun' has no default action.  See \`puppet help lastrun\`."

If ( $puppet_lastrun -eq $puppet_lastrun_response ){
  'Good!'
} else {
  'Bad!'
}

