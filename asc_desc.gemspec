# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'asc_desc/version'

Gem::Specification.new do |s|
  s.name        = 'asc_desc'
  s.version     = AscDesc::VERSION
  s.authors     = ['David Werlen']
  s.email       = ['werlen@icare.ch']
  s.homepage    = 'http://github.com/dwerlen/asc_desc'
  s.summary     = %q{adds "asc/desc" methods and dynamic "order_by" mechanism to ActiveRecord}
  s.description = %q{This gem adds two new methods to ActiveRecord (and ActiveRecord::Relation) that allows to sort SQL queries without using the "ASC" and "DESC" SQL keywords. It also adds a dynamic "order_by" mechanism (in the same way as dynamic finders).}

  s.rubyforge_project = 'asc_desc'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency     'activerecord', '>= 3.0.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'with_model'
  s.add_development_dependency 'activerecord', '~> 3.2.1'
  s.add_development_dependency 'sqlite3', '~> 1.3.5'
end
