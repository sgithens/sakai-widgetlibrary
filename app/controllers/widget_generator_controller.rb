require 'zip/zip'
require 'zip/zipfilesystem'

require 'rails/generators'
require 'guid'
require 'find'

class WidgetGeneratorController < ApplicationController
  def makewidget
    print "Freaking awesome"
    Rails::Generators.invoke 'sakaiwidget', ['fromweb'], :behavior => :invoke, :destination_root => Rails.root
    Find.find("#{Rails.root}/widgets/fromweb") { |path| puts path }
  end

  def index
    @awesomevar = 'blakjsd!'
    makewidget
  end

  def zippedwidget
    Rails::Generators.invoke 'sakaiwidget', ['fromweb'], :behavior => :invoke, :destination_root => Rails.root
    t = Tempfile.new("wowthatswierd")
    zos =Zip::ZipOutputStream.open(t.path)
    prefix = "#{Rails.root}/widgets/"
    Find.find("#{Rails.root}/widgets/fromweb") { |path| 
      zippath = path.slice(prefix.length...path.length)
      if zippath != 'fromweb' then
        zos.put_next_entry(zippath)
        if !File.directory?(path) then
          open(path) do |f| 
              zos << f.read
          end
        end
        zos.print("Hello there little text file!") 
      end
    }
    zos.close
    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => 'hellowidget.zip'    
    t.close
  end

end
