#!/bin/bash

# ==========================================
# AUTOMATED SSH KEY INJECTION & HARDENING
# ==========================================

# 1. Create the .ssh directory if it doesn't exist
# The -p flag ensures no error if the folder is already there.
mkdir -p /root/.ssh

# 2. Secure the directory immediately
# Permissions 700: Only the owner (root) can read, write, or open this folder.
chmod 700 /root/.ssh

# 3. Inject the Public Key
# REPLACE THE TEXT BELOW with your actual public key string.
# We use quotes "" to safely handle spaces in the key format.
echo "<PASTE_YOUR_PUBLIC_KEY_HERE>" >> /root/.ssh/authorized_keys

# 4. Secure the authorized_keys file
# Permissions 600: Only the owner (root) can read or write this file.
# If this is not set, SSHD will often refuse the key for being "too open."
chmod 600 /root/.ssh/authorized_keys

# 5. Configure SSH Daemon (The "Clean" Way)
# First, delete ANY existing lines starting with PermitRootLogin to avoid conflicts/duplicates.
sed -i '/^PermitRootLogin/d' /etc/ssh/sshd_config

# Then, append the clear "Allow" rule to the bottom of the file.
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# 6. Apply Changes
# Restart the SSH service to make it read the new configuration.
systemctl restart sshd
