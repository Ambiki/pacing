Gem::Specification.new do |s|
    s.name        = 'pacing'
    s.version     = '0.1.0' # https://stackoverflow.com/questions/3728626/what-to-use-as-an-initial-version
    s.summary     = "Pacing is a tool that enables therapists to better manage and track their caseload."
    s.description = "Pacing is built for cases where there are therapy frequency limitations that need to be adhered to. For example, in the case of an [IEP (Individualized Education Program)](https://ambiki.com/glossary-concepts/iep), 504 plan, or a Services plan. This gem helps to calculate remaining visits as well as a therapist's current pace to meet visit mandates."
    s.authors     = ["Kevin S. Dias", "Samuel Okoth"]
    s.email       = 'info@ambiki.com'
    s.files       = ["lib/pacing.rb"]
    s.homepage    =
      'https://rubygems.org/gems/pacing'
    s.license       = 'MIT'
  end

  spec.add_development_dependency "rspec"