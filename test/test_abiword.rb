require 'test/unit'
require File.join(File.dirname(File.dirname(__FILE__)),"lib/abiword")

class TestAbiword < Test::Unit::TestCase
  
  def cleanup
    File.delete('testfiles/testfile.pdf') if File.exists?('testfiles/testfile.pdf')
  end
  
  def teardown
    File.delete('testfiles/testfile.pdf') if File.exists?('testfiles/testfile.pdf')
  end
  
  def test_success
    Abiword::Abiword.doc2pdf("testfiles/testfile.doc")
    assert File.exists?("testfiles/testfile.pdf")
  end
  
  def test_failure_missing_file
    assert_raises Exceptions::AbiwordException do
      Abiword::Abiword.doc2pdf("testfiles/nonexistent.doc")
    end
    assert !File.exists?('testfiles/nonexistent.pdf')
  end
  
end
