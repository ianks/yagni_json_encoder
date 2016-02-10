# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name     = "yagni_json_encoder"
  spec.version  = "0.0.1"
  spec.authors  = ["Ian Ker-Seymer"]
  spec.email    = ["i.kerseymer@gmail.com"]
  spec.summary  = "~2x Faster JSON encoding for Rails for those who don't " \
                  "need special escaping."
  spec.homepage = "https://github.com/ianks/yagni_json_encoder"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "oj", "~> 2.14"
end
