#!/bin/sh
#
# Add my public key
#
# curl -s http://code.arp242.net/config/raw/tip/pubkey.sh | sh

[ ! -d ~/.ssh ] && mkdir ~/.ssh

echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVqAv/oswz7zdPBBqGGqk8b52STGO5py8iOZQ01ZgETEq01jW7shapk9eWHJLmhW5W6Ul8F3YcrnM4S0+q8frMh6puiLtuRMZ/F6kq4msMas/oGl6CEijeUs5zB8I2rLlylIFWOY2SKWVoGEfpVGSwhGu0SAYmq6hrwjixz4IOjzgRAha5JREokq9D44HPQUCIDPdEYuv9cFrUzJCE3M+i21eol1YPkX2WIHK3+kNWMzDgrsmXX7KxHi3XxtMK4VKSzNQlxSEYlwYu65ICmwpjozq0FrRgCORidmU5e5opgwT4oFocfzlaom6z5FQCodiUTuIhgFnzZL4rrjWo97q3 martin@glitch.arp242.net' >> ~/.ssh/authorized_keys
