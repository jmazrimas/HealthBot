class PubHealth < ActiveRecord::Base

  #after greg and joe determine the category of the request...

  def get_box_around_address(address)
    google_object = Geocoder.search(address)
    northeast = google_object.geometry["bounds"]["northeast"].values
    southwest = google_object.geometry["bounds"]["southwest"].values
    box = northeast.concat(southwest)
    return box
  end

  def make_query(category, address)
    box_around_target_address = get_box_around_address(address)
    text_file = File.open("api_endpoints.txt")
    last_line = ""
    text_file.each_line do |line|
      #remove newline character
      if line.strip == category
        last_line = line
      elsif last_line
        to_append = "?where=within_box(location, #{box_around_target_address[0]}, #{box_around_target_address[1]}, #{box_around_target_address[2]}, #{box_around_target_address[3]})"
        api_call = line.strip + to_append
      end
    api_call
  end

end
