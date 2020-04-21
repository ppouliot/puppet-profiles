#!/usr/bin/env bash
PUPPET_LASTRUN=$(puppet lastrun)
PUPPET_LASTRUN_RESPONSE="Error: 'lastrun' has no default action.  See \`puppet help lastrun\`."

# echo $PUPPET_LASTRUN
# echo $PUPPET_LASTRUN_RESPONSE

if [ "$PUPPET_LASTRUN" == "$PUPPET_LASTRUN_RESPONSE" ]; then
  echo "Good!"
  exit 0
else
  echo "Bad!"
  exit 1
fi
