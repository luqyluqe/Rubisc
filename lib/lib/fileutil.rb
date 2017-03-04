#!/usr/bin/ruby
module Rubisc
	module FileUtil
		def self.process_file file_path
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
			file=File.new file_path,"w"
			if !file
				puts "Failed to write file "+file_path
				return false
			end
			file.write content
			file.close
			return true
		end
	end
end
