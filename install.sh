#!/usr/bin/env bash
set -e

# check os
os=$(uname)
if [[ "${os,}" != "linux" && "${os,}" != "darwin" ]]; then
	echo 'ERROR: OS not support.'
	exit 1
fi

# check architecture
arch=""
case $(uname -m) in
    x86_64) arch="amd64" ;;
    arm64)    arch="arm64" ;;
esac
if [[ "$arch" == "" ]]; then
	echo 'ERROR: Architecture not support.'
	exit 1
fi

# download tool
latest=$(curl --silent "https://api.github.com/repos/rogerdz/denv-install/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"([^"]+)".*/\1/')
if [[ "$latest" != "" ]]; then
	echo "Version: $latest"
	curl -L https://github.com/rogerdz/denv-install/releases/download/${latest}/denv-${latest}-${os,}-${arch}.tar.gz | tar -xzvf - -C /tmp
	chmod +x /tmp/denv
	sudo mv /tmp/denv /usr/local/bin
	echo 'Install success.'
else
	echo 'ERROR: File not found.'
fi
