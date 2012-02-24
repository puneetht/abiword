module OsFunctions
  
  # universal-darwin9.0 shows up for RUBY_PLATFORM on os X leopard with the bundled ruby. 
  # Installing ruby in different manners may give a different result, so beware.
  # Examine the ruby platform yourself. If you see other values please comment
  # in the snippet on dzone and I will add them.

  def is_mac?
    RUBY_PLATFORM.downcase.include?("darwin")
  end

  def is_windows?
     RUBY_PLATFORM.downcase.include?("mswin")
  end

  def is_linux?
     RUBY_PLATFORM.downcase.include?("linux")
  end
  
  module_function :is_mac? , :is_windows?, :is_linux?
end

module Exceptions
  class AbiwordException  < StandardError; end
end

module Abiword
  
  class Abiword
    @@binary = "abiword_linux"
    @@binary_dir = File.join(File.dirname(File.dirname(__FILE__)),"bin")
    @@binary_path = ""
    
    def self.doc2pdf(infile)
      self.set_binary_path if @@binary_path.empty?
      ext  = File.extname(infile)
      
      raise Exceptions::AbiwordException if (ext != ".doc" && ext != ".docx")  
        
      raise Exceptions::AbiwordException if !File.exists?(infile)
      
      outfile = File.join(File.dirname(infile),File.basename(infile,".*")) + ".pdf"
      cmd = @@binary_path
      cmd += " --to=pdf"
      cmd += " #{infile}"
      cmd += " -o #{outfile}"

      puts "#{cmd} is Commdna"      
      `#{cmd}`
      
      while !$?.exited?
        sleep 0.01
      end
      
      exit_status = $?.exitstatus
      raise Exceptions::AbiwordException if exit_status != 0
      
      return outfile
    end
  
    def self.set_binary_path
      if OsFunctions::is_mac?
        @@binary = "abiword_macos"
      elsif OsFunctions::is_linux?
        @@binary == "abiword_linux"
      else
        raise "This ruby packge only works on mac and on linux"
      end
       @@binary_path = File.join(@@binary_dir,@@binary)
    end
  end
end
