# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-plaintext/version"

Gem::Specification.new do |s|
  s.name        = "middleman-plaintext"
  s.version     = Middleman::Plaintext::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Caius Durling"]
  s.email       = %w(dev@caius.name)
  s.summary     = %{Generate plaintext versions of resources}
  s.description = %{Generate raw un-rendered versions of selected resources. Shout out to John Gruber for the original idea - eg: http://daringfireball.net/2010/07/improved_regex_for_matching_urls.text}
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "middleman-core", "~> 4.1"

  s.add_development_dependency "rake"
end
