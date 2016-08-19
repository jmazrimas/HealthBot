#after greg and joe determine the category of the request...
def response_options(category, address)
  json_response = return_collection(category, address)
  p json_response
  thing = json_response.map {|response| "There's a #{response["site_type"]} called #{response["site_name"]} at #{response["address"]} open #{response["hours_of_operation"]}"}
  p thing
  thing
end

# calls formquery, called by response options
def return_collection(category, address)
  uri = URI(form_query(category, address))
  p "URI"
  p uri
  string_data = Net::HTTP.get(uri)
  json_response = JSON.parse(string_data)
  json_response
end

# calls getboxaround, called by return collection
def form_query(category, address)
  box_around_target_address = get_box_around_address(address)
  api_call = CategoryManager.new.apis[category] + "?$where=within_box(location,#{box_around_target_address[0]},#{box_around_target_address[1]},#{box_around_target_address[2]},#{box_around_target_address[3]})"
  api_call
end

# called by form query
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