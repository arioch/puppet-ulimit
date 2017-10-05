##############################################################################
# Rakefile - Configuration file for rake (http://rake.rubyforge.org/)
# Time-stamp: <Thu 2017-10-05 17:05 svarrette>
#
# Copyright (c) 2017  <>
#                       ____       _         __ _ _
#                      |  _ \ __ _| | _____ / _(_) | ___
#                      | |_) / _` | |/ / _ \ |_| | |/ _ \
#                      |  _ < (_| |   <  __/  _| | |  __/
#                      |_| \_\__,_|_|\_\___|_| |_|_|\___|
#
# Use 'rake -T' to list the available actions
#
# Resources:
# * http://www.stuartellis.eu/articles/rake/
##############################################################################
require 'falkorlib'
require 'puppetlabs_spec_helper/rake_tasks'

## placeholder for custom configuration of FalkorLib.config.*
## See https://github.com/Falkor/falkorlib

FalkorLib.config.versioning do |c|
  c[:type] = 'puppet_module'
end

# Git flow customization
FalkorLib.config.gitflow do |c|
    c[:branches] = {
        :master  => 'production',
        :develop => 'master'
    }
end

require 'falkorlib/tasks/git'
require 'falkorlib/tasks/puppet'
