# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: plaid-kilt 0.7.5 ruby lib

Gem::Specification.new do |s|
  s.name = "plaid-kilt"
  s.version = "0.7.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Koisch"]
  s.date = "2014-05-05"
  s.description = "Access the Plaid API using Rubyre"
  s.email = "jk@cloudsway.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".DS_Store",
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "design/plaid_flows_connect.png",
    "design/plaid_user_set_up.png",
    "lib/plaid.rb",
    "lib/plaid/client/balance.rb",
    "lib/plaid/client/body.rb",
    "lib/plaid/client/client.rb",
    "lib/plaid/client/configuration.rb",
    "lib/plaid/client/connect.rb",
    "lib/plaid/client/entity.rb",
    "lib/plaid/client/followup.rb",
    "lib/plaid/client/thin_client.rb",
    "lib/plaid/plaid_error.rb",
    "lib/plaid/plaid_object.rb",
    "lib/plaid/plaid_response.rb",
    "lib/plaid/scaffold/category.rb",
    "lib/plaid/scaffold/institution.rb",
    "lib/plaid/scaffold/scaffold.rb",
    "lib/plaid/text/exposition.rb",
    "test/helper.rb",
    "test/test_plaid.rb"
  ]
  s.homepage = "http://github.com/jkoisch/plaid"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "Access the Plaid API using Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.7"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
  end
end

