require_relative "lib/kaze/version"

Gem::Specification.new do |spec|
  spec.name = "kaze"
  spec.version = Kaze::VERSION
  spec.authors = [ "Cuong Giang" ]
  spec.email = [ "thaicuong.giang@gmail.com" ]
  spec.homepage = "https://github.com/gtkvn/kaze"
  spec.summary = "Minimal Rails authentication scaffolding with Hotwire, Vue, or React + Tailwind."
  spec.license = "MIT"
  spec.files = Dir["lib/**/*", "stubs/**/*", "MIT-LICENSE", "README.md"]
  spec.executables = %w[ kaze ]

  spec.add_dependency "thor", "~> 1.2"
  spec.add_dependency "zeitwerk", "~> 2.5"

  spec.add_development_dependency "railties"
end
