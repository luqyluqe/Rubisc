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

		def file_substitute file_path,old_content,new_content
			process_file file_path,true do |content|
				pattern=content.match /#{old_content}/
				if !pattern
					puts "No matching found."
				end
				content=content.gsub /#{old_content}/,new_content
			end
		end

		def contains_pattern? path,pattern
			contains=false
			if path!="." and path!=".."
                if File.directory?(path)
                    Dir.entries(path).each do |sub|
                        if sub!="." and sub!=".."
                            contains=contains_pattern? "#{path}/#{sub}",pattern
                        end
                    end
                else
                    contains=file_contains_pattern? path,pattern
                end
            end
			contains
		end

		def file_contains_pattern? path,pattern
			match=nil
			process_file path,false do |content|
				match=content.match /#{pattern}/
			end
			match!=nil
		end

		def substitute path,old_content,new_content
			if path!="." and path!=".."
				if File.directory?(path)
					Dir.entries(path).each do |sub|
						if sub!="." and sub!=".."
							substitute "#{path}/#{sub}",old_content,new_content
						end
					end
				else
					file_substitute path,old_content,new_content
				end
			end
		end
	end
end
