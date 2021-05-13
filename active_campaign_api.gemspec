# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_campaign_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_campaign_api'
  spec.version       = ActiveCampaignApi::VERSION
  spec.authors       = ['Daniel Laeng']
  spec.email         = ['daniel@laeng.org']

  spec.summary       = 'Basic Active Campaign API wrapper'
  spec.description   = 'API wrapper for ActiveCampaign API v3.'
  spec.homepage      = 'http://github.com/picfair/active_campaign_api'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.5.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = 'http://github.com/picfair/active_campaign_api'
    spec.metadata['source_code_uri'] = 'http://github.com/picfair/active_campaign_api'
    spec.metadata['changelog_uri'] = 'http://github.com/picfair/active_campaign_api'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_dependency 'addressable'
  spec.add_dependency 'json'
  spec.add_dependency 'rest-client'
end
