#!/bin/bash

# Export the GOOGLE_APPLICATION_CREDENTIALS_JSON secret as an env var if it exists
if [ -f /run/secrets/GOOGLE_APPLICATION_CREDENTIALS_JSON ]; then
  export GOOGLE_APPLICATION_CREDENTIALS_JSON="$(cat /run/secrets/GOOGLE_APPLICATION_CREDENTIALS_JSON)"
  echo "$GOOGLE_APPLICATION_CREDENTIALS_JSON" > /tmp/gc.json
  export GOOGLE_APPLICATION_CREDENTIALS="/tmp/gc.json"
fi

# Run Chainlit (or your main app)
exec chainlit run app.py --port 7860 --host 0.0.0.0
