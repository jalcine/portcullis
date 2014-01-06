#!/usr/bin/env bash
#
# Provisioning script for a Vagrant instance that'll run the Portcullis
# Web application.

RBENV_RUBY_VERSION=2.0.0-p353


echo '[info] Updating system...'
apt-get update -y 2>&1 >/dev/null

echo '[info] Installing packages...'
apt-get install -y build-essential zlib1g-dev curl nginx postgresql nodejs \
  git rbenv libxml2-dev libxslt1-dev 2>&1 >/dev/null

echo '[info] Grabbing build dependencies for PostgreSQL and Ruby..'
apt-get build-dep ruby postgresql 2>&1 >/dev/null

echo "[info] Installing rbenv/ruby-build..."
git clone git://github.com/jalcine/ruby-build /tmp/ruby-build 2>&1 >/dev/null
PREFIX=/usr /tmp/ruby-build/install.sh 2>&1 >/dev/null
