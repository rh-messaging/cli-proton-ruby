Gem::Specification.new do |s|
  s.name = 'cli-proton-ruby'
  s.version = '1.0.0'
  s.date = '2019-01-03'
  s.summary = "Qpid Proton Ruby commandline clients"
  s.description = "cli-proton-ruby is a collection of commandline messaging clients suitable for interacting with Message Oriented Middleware."
  s.authors = ["Radim Kubis", "Jiri Danek", "Alan Conway"]
  s.email = 'rkubis@redhat.com'
  s.files = Dir["lib/*.rb"] + Dir["lib/**/*.rb"] + Dir["bin/cli-proton-ruby-*"]
  s.executables = ["cli-proton-ruby-connector", "cli-proton-ruby-receiver", "cli-proton-ruby-sender"]
  s.homepage = 'http://rubygems.org/gems/cli-proton-ruby'
  s.license  = 'Apache-2.0'
  s.required_ruby_version = '>= 2.0.0p648'
  s.add_runtime_dependency 'qpid_proton', '~> 0.26', '>= 0.26.0'
  s.metadata = {"source_code_uri" => "https://github.com/rh-messaging/cli-proton-ruby"}
end
