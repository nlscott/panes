# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "panes/version"

Gem::Specification.new do |spec|
  spec.name          = "panes"
  spec.version       = Panes::VERSION
  spec.authors       = ["Nic Scott"]
  spec.email         = ["nls.inbox@gmail.com"]

  spec.summary       = "A ruby gem for MacAdmins to help manage access to System Preference Panes. Easily enable or disable access to individual panes."
  spec.homepage      = "https://github.com/nlscott/panes"
  spec.license       = "MIT"

=begin
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
=end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake", ">= 11.2.2"
  spec.add_development_dependency "minitest", "5.18.1"
  spec.add_development_dependency "CFPropertyList", ">= 3.0.6"

end
