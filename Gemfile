source 'https://rubygems.org'

gem 'falkorlib' #, :path => '~/git/github.com/Falkor/falkorlib'

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_GEM_VERSION'] || '~> 4.10.0'
  gem 'puppet-strings'
  gem 'puppetlabs_spec_helper'
  gem 'metadata-json-lint'
  gem "puppet-lint-absolute_classname-check"
  gem "puppet-lint-leading_zero-check"
  gem "puppet-lint-trailing_comma-check"
  gem "puppet-lint-version_comparison-check"
  gem "puppet-lint-classes_and_types_beginning_with_digits-check"
  gem "puppet-lint-unquoted_string-check"
  gem 'puppet-lint-resource_reference_syntax'
  gem 'puppet-syntax'
end

require 'falkorlib/tasks/puppet'
