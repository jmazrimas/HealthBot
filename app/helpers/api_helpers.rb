#after greg and joe determine the category of the request...
def return_string(category, address)
  p form_query(category, address)
  uri = URI(form_query(category, address))
  string_data = Net::HTTP.get(uri).gsub!(/(\\n)/, "")
  #get rid of quotes, \, and \n
  p string_data.strip
end

# def insert_answers_into_db
# end

def get_box_around_address(address)
  google_object = Geocoder.search(address)[0]
  northeast = google_object.geometry["bounds"]["northeast"].values
  northeast[0] = northeast[0]+0.1
  northeast[1] = northeast[1]-0.1
  southwest = google_object.geometry["bounds"]["southwest"].values
  southwest[0] = southwest[0]-0.1
  southwest[1] = southwest[1]+0.1
  box = northeast.concat(southwest)
  return box
end

def form_query(category, address)
  box_around_target_address = get_box_around_address(address)
  text_file = File.open("api_endpoints.txt")
  last_line = ""
  api_call = ""
  text_file.each_line do |line|
    #remove newline character
    if line.strip == category
      last_line = line
    elsif last_line
      to_append = "?$where=within_box(location, #{box_around_target_address[0]}, #{box_around_target_address[1]}, #{box_around_target_address[2]}, #{box_around_target_address[3]})"
      api_call = line.strip + to_append
    end
  end
  api_call
end