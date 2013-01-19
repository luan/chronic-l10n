$:.unshift File.expand_path('../lib', __FILE__)
require 'chronic'
require 'chronic-l10n'

Gem::Specification.new do |s|
  s.name = 'chronic-l10n'
  s.version = Chronic::L10n::VERSION
  s.summary     = 'Localization for Chronic.'
  s.description = 'Pack of locales for localizing Chronics date parsing.'
  s.authors  = ['Luan Santos']
  s.email    = ['luan@luansantos.com']
  s.homepage = 'http://github.com/luan/chronic-l10n'
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = %w[README.md HISTORY.md LICENSE]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test`.split("\n")

  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_dependency 'chronic', '>= 0.9.0'
end
