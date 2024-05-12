#!/bin/sh

args=""

if [ -n "$SYNCPLAY_SALT_FILE" ]; then
  if [ ! -s "$SYNCPLAY_SALT_FILE" ]; then echo "SYNCPLAY_SALT_FILE '$SYNCPLAY_SALT_FILE' specified but missing, abort!"; exit 1; fi
  args="$args --salt=$(cat $SYNCPLAY_SALT_FILE)"
elif [ -n "$SYNCPLAY_SALT" ]; then
  args="$args --salt=$SYNCPLAY_SALT"
elif [ -n $SALT ]; then
  args="$args --salt=$SALT"
fi

if [ -n "$SYNCPLAY_PORT" ]; then
  args="$args --port=$SYNCPLAY_PORT"
elif [ -n "$PORT" ]; then
  args="$args --port=$PORT"
fi

if [ -n "$SYNCPLAY_ISOLATE" ]; then
  args="$args --isolate-rooms"
elif [ -n "$ISOLATE" ]; then
  args="$args --isolate-rooms"
fi

if [ -n "$SYNCPLAY_MOTD_FILE" ]; then
  if [ ! -s "$SYNCPLAY_MOTD_FILE" ]; then echo "SYNCPLAY_MOTD_FILE '$SYNCPLAY_MOTD_FILE' specified but missing, abort!"; exit 1; fi
  args="$args --motd-file=$SYNCPLAY_MOTD_FILE"
else
  if [ -n "$SYNCPLAY_MOTD" ]; then
    echo "$SYNCPLAY_MOTD" >> /app/syncplay/motd
  elif [ -n "$MOTD" ]; then
    echo "$MOTD" >> /app/syncplay/motd
  fi
  if [ -f /app/syncplay/motd ]; then
    args="$args --motd-file=/app/syncplay/motd"
  fi
fi

if [ -n "$SYNCPLAY_PASSWORD_FILE" ]; then
  if [ ! -s "$SYNCPLAY_PASSWORD_FILE" ]; then echo "SYNCPLAY_PASSWORD_FILE '$SYNCPLAY_PASSWORD_FILE' specified but missing, abort!"; exit 1; fi
  args="$args --password=$(cat $SYNCPLAY_PASSWORD_FILE)"
elif [ -n "$SYNCPLAY_PASSWORD" ]; then
  args="$args --password=$SYNCPLAY_PASSWORD"
elif [ -n "$PASSWORD" ]; then
  args="$args --password=$PASSWORD"
fi

if [ -n "$SYNCPLAY_NOREADY" ]; then
  args="$args --disable-ready"
elif [ -n "$NOREADY" ]; then
  args="$args --disable-ready"
fi

if [ -n "$SYNCPLAY_NOCHAT" ]; then
  args="$args --disable-chat"
fi

if [ -n "$SYNCPLAY_MAXCHARS" ]; then
  args="$args --max-chat-message-length=$SYNCPLAY_MAXCHARS"
fi

if [ -n "$SYNCPLAY_USERNAMELENGTH" ]; then
  args="$args --max-username-length=$SYNCPLAY_USERNAMELENGTH"
fi

if [ -n "$SYNCPLAY_STATSFILE" ]; then
  args="$args --stats-db-file=$SYNCPLAY_STATSFILE"
fi

if [ -n "$SYNCPLAY_TLS_DIR" ]; then
  if [ ! -d "$SYNCPLAY_TLS_DIR" ]; then echo "SYNCPLAY_TLS_DIR '$SYNCPLAY_TLS_DIR' specified but missing, abort!"; exit 1; fi
  if [ ! -r "${SYNCPLAY_TLS_DIR}/cert.pem" && ! -r "${SYNCPLAY_TLS_DIR}/cert.pem" && ! -r "${SYNCPLAY_TLS_DIR}/cert.pem" ]; then echo "Can't access TLS files, aborting!"; exit 1; fi
  args="$args --tls=$SYNCPLAY_TLS_DIR"
elif [ -n "$TLS" ]; then
  args="$args --tls=$TLS"
fi

echo "Starting syncplay-server with args '$args'"

PYTHONUNBUFFERED=1 exec syncplay-server $args $@

