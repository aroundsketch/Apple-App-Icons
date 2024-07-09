require 'fileutils'

# Function to create YAML files
def create_yaml_files(dir_path, output_dir)
  Dir.foreach(dir_path) do |entry|
    next if entry == '.' || entry == '..'

    entry_path = File.join(dir_path, entry)
    if File.directory?(entry_path)
      folder_name = File.basename(entry_path)
      formatted_name = folder_name.gsub(/([a-z])([A-Z])/, '\1-\2').downcase # Insert hyphens between camel case and convert to lowercase
      formatted_name = formatted_name.gsub(/\s+/, '-') # Replace spaces with hyphens

      yaml_content = <<~YAML
      name: #{folder_name}
      url-name: #{formatted_name}
      tags: apple app icon
      YAML

      # Create the output directory if it doesn't exist
      FileUtils.mkdir_p(output_dir) unless Dir.exist?(output_dir)

      # Create the YAML file for the folder
      File.write("#{File.join(output_dir, folder_name)}.yml", yaml_content)

      # Recursive call to handle nested folders
      create_yaml_files(entry_path, output_dir)
    end
  end
end

# Starting directory (replace with your actual base directory)
base_directory = './App-Icon/Apple'

# Output directory where YAML files will be stored
output_directory = './_data/app-icons'

# Ensure the base directory exists
if Dir.exist?(base_directory)
  create_yaml_files(base_directory, output_directory)
else
  puts "Base directory '#{base_directory}' does not exist."
end
