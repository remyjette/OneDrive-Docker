#!/bin/bash

echo "skip_file = \"${SKIP_FILES}\"" >> /root/.config/onedrive/config

if [ -f /sync_list ]
then
	cp /sync_list /root/.config/onedrive/sync_list
fi

exec "$@"
