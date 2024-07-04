require 'yaml'
require 'fileutils'

# Directory containing YAML files
data_dir = '_data/app-icons'
output_dir = 'pages/app-icons'

# Create a directory for the HTML files if it doesn't exist
FileUtils.mkdir_p(output_dir)

# Method to convert filename to desired format
def convert_to_html_filename(yml_filename)
  # Remove the .yml extension
  base_name = yml_filename.gsub('.yml', '')
  
  # Replace uppercase letters preceded by a lowercase letter or digit with -lowercase
  formatted_name = base_name.gsub(/(?<=\w)([A-Z])/, '-\1').downcase
  
  # Handle special case for 'i' followed by an uppercase letter
  formatted_name = formatted_name.gsub(/^i-/, 'i')

  formatted_name + '.html'
end

# Iterate through each YAML file in the directory
Dir.glob("#{data_dir}/*.yml") do |file_path|
  # Load the YAML file
  data = YAML.load_file(file_path)

  # Ensure data has 'name' and 'tags' keys
  if data.key?('name') && data.key?('tags')
    name = data['name']
    tags = data['tags']
    
    # Get the base name of the file (e.g., "AirDrop.yml")
    base_name = File.basename(file_path)
    
    # Convert the base name to the desired HTML file name
    html_filename = convert_to_html_filename(base_name)
    
    # Define the full output file path
    output_file_path = File.join(output_dir, html_filename)
    
    # Generate the HTML content
    html_content = <<-HTML
---
layout: cover
title: #{name}
description: #{name} App Icon
permalink: /app-icons/#{html_filename.gsub('.html', '')}/
tags: "#{tags}"
---
<div class="container">{% include app-icon.html %}</div>
    HTML
    
    # Write the HTML content to the file
    File.write(output_file_path, html_content)
  else
    puts "Skipping file #{file_path} as it does not contain the required keys."
  end
end

puts "HTML files have been generated in the '#{output_dir}' directory."
