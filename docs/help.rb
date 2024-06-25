require 'fileutils'

# Print a message to ensure Ruby is working
puts "Hello, Ruby is working!"

# Create a sample directory and file to test file operations
test_dir = "test_directory"
test_file = "test_directory/test_file.txt"

# Create a directory
Dir.mkdir(test_dir) unless Dir.exist?(test_dir)

# Create a file and write to it
File.open(test_file, 'w') do |file|
  file.write("This is a test file.")
end

# Read the file and print its content
puts "Content of test file:"
puts File.read(test_file)

# Create a YAML file to test YAML operations without using to_yaml
yaml_data = {
  'name' => 'test',
  'tags' => 'ruby test'
}

yaml_content = <<~YAML
---
name: #{yaml_data['name']}
tags: #{yaml_data['tags']}
YAML

yaml_file = "test_directory/test_file.yml"

# Write YAML data to the file
File.open(yaml_file, 'w') do |file|
  file.write(yaml_content)
end

# Read and print YAML file content
puts "Content of YAML file:"
puts File.read(yaml_file)
