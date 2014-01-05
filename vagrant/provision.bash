#!/usr/bin/env bash
#
# Provisioning script for a Vagrant instance that'll run the Portcullis
# application.

RBENV_RUBY_VERSION="2.0.0-p353"

echo "[info] Updating system..."
apt-get update -y
apt-get upgrade -y

echo "[info] Installing packages..."
apt-get install -y nodejs rbenv ruby-build postgresql\
  build-essential automake git

echo "[info] Removing old Ruby..."
apt-get remove -y ruby1.9 ruby1.8 ruby

echo "[info] Installing Ruby..."
git clone git://github.com/sstephenson/ruby-build\
 $HOME/.rbenv/plugins/ruby-build
rbenv install $RBENV_RUBY_VERSION -vk
gem install bundler

echo "[info] Setting up environment..."
bundle install --path vendor/cache

echo "[info] Spinning up server..."
cd /var/www/portcullis && bundle exec rails server
