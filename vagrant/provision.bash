#!/usr/bin/env bash
#
# Provisioning script for a Vagrant instance that'll run the Portcullis
# Web application.

RBENV_RUBY_VERSION=2.0.0-p353


echo '[info] Updating system...'
apt-get update -y 2>&1 >/dev/null

echo '[info] Installing packages...'
apt-get install -y build-essential zlib1g-dev curl nginx \
  postgresql nodejs git rbenv 2>&1 >/dev/null

echo '[info] Grabbing build dependencies for PostgreSQL and Ruby..'
apt-get build-dep ruby postgresql 2>&1 >/dev/null

echo "[info] Installing Ruby $RBENV_RUBY_VERSION ..."
git clone git://github.com/jalcine/ruby-build ./ruby-build
PREFIX=/usr ./ruby-build/install.sh
rbenv install $RBENV_RUBY_VERSION -k
echo "[info] Installed Ruby $(ruby -v)."

echo "[info] Bundling application..."
cd /var/www/portcullis
bundle install --path=vendor/cache 2>&1 >/dev/null
echo "[FIXME] Start the webapp."

echo "[info] Visit http://localhost:4373 to view the web application."
