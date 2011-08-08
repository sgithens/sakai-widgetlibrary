

class SakaiwidgetGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  def create_initializer_file
    empty_directory "widgets"
    empty_directory "widgets/#{file_name}"
    empty_directory "widgets/#{file_name}/bundles"
    copy_file "bundles/default.properties", "widgets/#{file_name}/bundles/default.properties"
    empty_directory "widgets/#{file_name}/css"
    template "css/WIDGET_ID.css", "widgets/#{file_name}/css/#{file_name}.css"
    empty_directory "widgets/#{file_name}/javascript"
    template "javascript/WIDGET_ID.js", "widgets/#{file_name}/javascript/#{file_name}.js"
    template "config.json", "widgets/#{file_name}/config.json"
    copy_file "README.txt", "widgets/#{file_name}/README.txt"
    template "WIDGET_ID.html", "widgets/#{file_name}/#{file_name}.html"
  end
end
