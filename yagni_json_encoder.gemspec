# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "yagni_json_encoder"
  spec.version       = "0.0.2"
  spec.authors       = ["Ian Ker-Seymer"]
  spec.email         = ["i.kerseymer@gmail.com"]
  spec.summary       = "~2x faster JSON encoder for Rails"
  spec.homepage      = "https://github.com/ianks/yagni_json_encoder"
  spec.license       = 'MIT'

  spec.files         = Dir['MIT-LICENSE', 'README.md', 'lib/**/*']
  spec.test_files    = Dir['test/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"

  spec.add_dependency "oj", "~> 2.18.5"
  spec.add_dependency 'activesupport', '>= 4.1.0'
end
