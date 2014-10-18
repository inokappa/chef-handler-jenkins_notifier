# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef/handler/jenkins_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "chef-handler-jenkins_notifier"
  spec.version       = Chef::Handler::JenkinsNotifier::VERSION
  spec.authors       = ["Yohei Kawahara(inokappa)"]
  spec.email         = ["inokara@gmail.com"]
  spec.summary       = %q{Chef notification handler for Jenkins}
  spec.description   = %q{Chef notification handler for Jenkins}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
