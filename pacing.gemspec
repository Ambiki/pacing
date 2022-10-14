lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pacing/version'

Gem::Specification.new do |s|
  s.name          = 'pacing'
  s.version       = Pacing::VERSION
  s.summary       = "Pacing is a tool that enables therapists to better manage and track their caseload."
  s.description   = "Pacing is built for cases where there are therapy frequency limitations that need to be adhered to. For example, in the case of an [IEP (Individualized Education Program)](https://ambiki.com/glossary-concepts/iep), 504 plan, or a Services plan. This gem helps to calculate remaining visits as well as a therapist's current pace to meet visit mandates."
  s.authors       = ["Kevin S. Dias", "Samuel Okoth", "Lukong I. Nsoseka"]
  s.email         = 'info@ambiki.com'
  s.files         = `git ls-files -z`.split("\x0")
  s.homepage      = 'https://github.com/Ambiki/pacing'
  s.license       = 'MIT'
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end

