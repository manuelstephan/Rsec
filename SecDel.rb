# Author: Manuel Stephan 
# mail: ms-elektronik@gmx.net
# Purpose: File Security 
#-------------------------------

require 'fileutils'

class Rsec
	# name: DelFile
	# type: method
	# purpose: overwrite file and delete it (secure deletion)
	# parameters: filePath:string: path to file and filename
	# return: result:boolean: true if deletion success, else false 	
	# note: overwriting a file one time is secure enough! check: (in German Language, available 25.04.2015)
	# http://www.heise.de/security/meldung/Sicheres-Loeschen-Einmal-ueberschreiben-genuegt-198816.html
	# The method will overwrite a file once and delete it, however to be sure to really delete data 
	# check your system for shadow-copies, temp files an the like. Editors sometimes keep copies. So be careful. 
	def DelFile(filePath)
		filePath = filePath.to_s
		if File.file?(filePath)
		  filesize = File.size(filePath)
		  [0x00, 0xff].each do |byte|
			File.open(filePath, 'wb') do |fo|
			  filesize.times { fo.print(byte.chr) }
			end
		  end
		  return true if File.delete(filePath)==1
		  puts "File: #{filePath} not deleted"
		  return false
		else
			puts "Secure deletion not possible! Specify correct file and path!"
			return false 
		end
	end 

end #Rsec

mySec = Rsec.new
mySec.DelFile(Dir.pwd+"/test.txt")