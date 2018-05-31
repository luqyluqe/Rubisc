#!/usr/bin/ruby
module Rubisc
	module FileUtil
		def self.process_file file_path,write
			return true unless block_given?
			if !File.file? file_path
				puts "Not a file: "+file_path
				return false
			end
			file=File.new file_path,"r"
			if !file
				puts "Failed to read file "+file_path
				return false
			end
			content=""
			file.each do |line|
				content<<line
			end
			content=yield content
			file.close
			return true unless write
			file=File.new file_path,"w"
			if !file
				puts "Failed to write file "+file_path
				return false
			end
			file.write content
			file.close
			return true
		end

		def self.substitute path,old_content,new_content
			iterate_files path do |file|
				file_substitute path,old_content,new_content
			end
		end

		def self.file_substitute file_path,pattern,new_content
			process_file file_path,true do |content|
				content=content.gsub /#{pattern}/,new_content
			end
		end

		def self.contains_pattern? path,pattern
			iterate_files path do |file|
				contains=file_contains_pattern file,pattern
				return true if contains
			end
			false
		end

		def self.file_contains_pattern? path,pattern
			matches=nil
			process_file path,false do |content|
				matches=content.match /#{pattern}/
			end
			matches!=nil
		end

		def self.iterate_files path
			if File.directory?(path)
                Dir.entries(path).each do |sub|
                    if sub!="." and sub!=".."
                        iterate_files "#{path}/#{sub}"
                    end
                end
            else
            	yield path
            end
		end
	end
end
