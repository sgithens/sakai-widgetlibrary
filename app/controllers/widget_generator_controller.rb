require 'zip/zip'
require 'zip/zipfilesystem'

class WidgetGeneratorController < ApplicationController
  def index
    @awesomevar = "Very Cool Stuff with zip requires"
  end

  def zippedwidget
    render :text => "This could be a zip file!"
    t = Tempfile.new("wowthatswierd")
    zos =Zip::ZipOutputStream.open(t.path)
    zos.put_next_entry("hello.txt")
    zos.print("Hello there little text file!")
    zos.close
    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => 'hellowidget.zip'    
    t.close
  end

end
