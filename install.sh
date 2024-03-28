#!/usr/bin/env bash
set -e

# check os
os=$(uname)
if [[ "${os,}" != "linux" && "${os,}" != "darwin" ]]; then
	echo 'OS not support.'
	exit 1
fi

# check architecture
arch=""
case $(uname -m) in
    x86_64) arch="amd64" ;;
    arm64)    arch="arm64" ;;
esac
if [[ "$arch" == "" ]]; then
	echo 'Architecture not support.'
	exit 1
fi

# download tool
curl -s -L https://github.com/rogerdz/denv-install/releases/download/0.0.1/denv-0.0.1-${os,}-${arch}.tar.gz | tar -xzvf - -C .
chmod +x denv
sudo mv denv /usr/local/bin
echo 'Install success.'