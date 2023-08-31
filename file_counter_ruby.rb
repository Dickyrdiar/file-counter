require 'digest'
require 'find'

#Get the Path to scan from command line argument
path = ARGV[0]

#ensure a path provider
if path.nil? || !File.directory?(path)
	puts "Please Provide a valid directory"
	exit 
end 

#Hash function to calculate content hash 
def calculate_hash(file_path)
	Digest::SHA256.file(file_path).hexdigest
end

#Traverse the directory and count files by their content
file_counts = Hash.new(0)

Find.find(path) do |file_path|
	next if File.directory?(file_path)
	
	content_hash = calculate_hash(file_path)
	file_counts[content_hash] += 1
end 

#find the content with the highest count
most_common_content = file_counts.max_by { |_, count| count}
puts "Most common content: #{most_common_content[0]} #{most_commom_content[1]}"

