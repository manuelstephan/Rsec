# Author: Manuel Stephan 
# mail: ms-elektronik@gmx.net
# Purpose: Delete Files securely 
#-------------------------------


class Rsec

	def DelFile(filePath)
		if File.file?(filePath)
		  filesize = File.size(filePath)
		  [0x00, 0xff].each do |byte|
			File.open(filePath, 'wb') do |fo|
			  filesize.times { fo.print(byte.chr) }
			end
		  end
		else
			puts "Secure deletion not possible! Specify correct file and path!"
			return false 
		end
	end 

end #Rsec