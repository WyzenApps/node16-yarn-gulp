#!/bin/bash

cd /opt

latest_url=https://yarnpkg.com/latest-version
specified_version=`curl -sLS $latest_url`
version_type='latest'

echo "Install YARN $specified_version"

output_dirname="yarn-v$specified_version"

curl --compressed -o yarn.latest.tar.gz -SL https://yarnpkg.com/latest.tar.gz
tar xzf yarn.latest.tar.gz
chown -R 33:33 $output_dirname
ln -sf /opt/$output_dirname/bin/yarn /usr/local/bin/.
ln -sf /opt/$output_dirname/bin/yarnpkg /usr/local/bin/.

