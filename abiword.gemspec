#require 'rubygems'
#require 'rake/packagetask'
#require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = "abiword"
  s.version = "0.2.1"
  s.authors = ["Puneet Paul"]
  s.email = "puneetpaul74@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.description = "Ruby wrapper for abiword"
  s.summary = "Provides binaries for abiword only to convert word doc and docx documents to pdf"
  s.files =  ["lib/abiword.rb", "bin/abiword_linux"]
  s.test_files = [Dir.glob('test/test*.rb'),Dir.glob('testfiles/*')].flatten
  s.has_rdoc = false
  s.require_path = ["lib"]
  s.homepage = 'http://rubygems.org/gems/abiword'
end
