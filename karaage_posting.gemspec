# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'karaage_posting/version'

Gem::Specification.new do |spec|
  spec.name          = "karaage_posting"
  spec.version       = KaraagePosting::VERSION
  spec.authors       = ["tossh0095"]
  spec.email         = ["tossh0095@users.noreply.github.com"]

  spec.summary       = %q{Posting number of karaages you eat to Karaage.click with life log service.}
  spec.description   = %q{Posting number of karaages you eat to Karaage.click with life log service.}
  spec.homepage      = "https://github.com/tossh0095/karaage_posting"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "coveralls"

  spec.add_dependency "oauth2", "~> 1.0"
  spec.add_dependency "mechanize", "~> 2.7"
  spec.add_dependency "dotenv", "~> 2.0"
  spec.add_dependency "thor", "~> 0.19"
end
