class PubHealth < ActiveRecord::Base

  #after greg and joe determine the category...

  def self.import(category, box_around_target_address)
    #iterate through the text file, for each API, import
    text_file = File.open("api_endpoints.txt")
    last_line = ""
    text_file.each_line do |line|
      #remove newline character
      if line == category
        last_line = line
      elsif last_line
        # next line append search params and send to api
      end
    #create pubhealth objects from each row
  end

end
