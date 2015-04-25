# Author: Manuel Stephan 
# mail: ms-elektronik@gmx.net
# git: manuelstephan/Rsec
# Purpose: File Security 
# Status: Prototype
#-------------------------------
begin
	require 'fileutils'
	require 'colorize'
	rescue
		puts "Required modules could not be loaded!"
		puts "Install with: 'gem install <module_name>'"
	raise
end 

class Rsec
	# name: DelFile
	# type: method
	# purpose: overwrite file and delete it (secure deletion)
	# parameters: filePath:string: path to file and filename
	# return: result:boolean: true if deletion success, else false 	
	# note: overwriting a file one time is secure enough! check: (in German Language, last access 25.04.2015)
	# http://www.heise.de/security/meldung/Sicheres-Loeschen-Einmal-ueberschreiben-genuegt-198816.html
	# The method will overwrite a file once and delete it, however to be sure to really delete data 
	# check your system for shadow-copies, temp files an the like. Editors sometimes keep copies. So be careful. 
	# works for windows systems only 
	
	# todo: add force delete for linux systems 
	def DelFile(filePath)
		filePath = filePath.to_s
		if File.file?(filePath)
		  filesize = File.size(filePath)
		    begin
				[0x00, 0xff].each do |byte|
				File.open(filePath, 'wb') do |fo|
					filesize.times { fo.print(byte.chr) }
				end
				end
			rescue  
				puts "Serious trouble occurred when trying to open and delete the file".red
				puts "Its likely that another program holds a handle to the file".red
				puts "The file has not been overwritten nor deleted!!".red
				return false
			raise
			end 
		    if File.delete(filePath)==1
				puts "File deleted successfully!".green
				return true
			end
		  puts "File: #{filePath} not deleted".red
		  return false
		else
			puts "Secure deletion not possible! Specify correct file and path!".red
			return false 
		end
	end # DelFile

end #Rsec




mySec = Rsec.new
mySec.DelFile(Dir.pwd+"/dell.pdf")