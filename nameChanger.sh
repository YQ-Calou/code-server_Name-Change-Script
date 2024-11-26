#!/bin/bash

# ask new name
read -p "New Name: " newName

# new name cant be empty
if [ -z "$newName" ]; then
  echo "New name cannot be empty."
  exit 1
fi

# list
files=(
  "/etc/passwd"
  "/etc/shadow"
  "/etc/sudoers"
  "/etc/s6-overlay/s6-rc.d/init-adduser/run"
  "/etc/s6-overlay/s6-rc.d/init-code-server/run"
  "/etc/s6-overlay/s6-rc.d/svc-code-server/run"
  "/etc/s6-overlay/s6-rc.d/init-crontab-config/run"
  "/etc/s6-overlay/s6-rc.d/svc-cron/run"
  "/usr/local/bin/install-extension"
)

# replace "abc"
for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    sed -i "s/abc/$newName/g" "$file"
    echo "Already replace $file 'abc' to '$newName'."
  else
    echo "File $file not exists，skip."
  fi
done

# modify
groupmod -n "$newName" abc

echo "Please restart your container."