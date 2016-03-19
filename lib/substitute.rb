#!/usr/bin/ruby

unless ARGV[0] and ARGV[1] and ARGV[2]
    puts "Usage: ruby substitute.rb <path> <old_content> <new_content>"
    puts "Example: ruby substitute.rb mydir/ hello hey"
    exit
end
unless File.exist? ARGV[0]
    puts "#{ARGV[0]} does not  exist."
    puts "Please provide the path to the file or directory you want to manipulate."
    exit
end

path=ARGV[0]
@old_content=ARGV[1]
@new_content=ARGV[2]

def file_substitute file_path
	file=File.new file_path,"r"
	if !file
	    puts "Failed to read file "+file_path
	else
	    content=""
	    file.each do |line|
	        content<<line
	    end
	    pattern=content.match /#{@old_content}/
	    if !pattern
	        puts "No matching found."
		file.close
		exit
	    else
	        content=content.gsub(/#{@old_content}/,@new_content)
	    end
	end
	file.close
	
	file=File.new file_path,"w"
	if !file
	    puts "Failed to write file "+file_path
	else
	    file.write content
	end
	file.close
end

def dir_substitute path
	if path!="." and path!=".."
		if File.directory?(path)
			Dir.entries(path).each do |sub|
				if sub!="." and sub!=".."
					dir_substitute "#{path}/#{sub}"
				end
			end
		else
			file_substitute path
		end
	end
end

dir_substitute path
