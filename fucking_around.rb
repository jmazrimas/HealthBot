require 'geocoder'

array_thing = Geocoder.search("9829 Lake Ave Cleveland")
# returns a google result array; each object has these methods available: http://www.rubydoc.info/github/alexreisner/geocoder/master/Geocoder/Result/Google

array_thing.each do |stuff|
  puts stuff.coordinates
  puts stuff.country
  puts stuff.formatted_address
  puts stuff.geometry
  puts stuff.neighborhood
  puts stuff.city
end

old_apartment = array_thing[0]
puts old_apartment.geometry["viewport"]

# 2614 North Springfield Avenue Chicago")
kaitlyn_with_a_k = Geocoder.search("Lincoln Park Chicago")
kaitlyns_house_array = kaitlyn_with_a_k[0].geometry
p "Kaitlyn"
p kaitlyns_house_array
#need location, viewport[northeast] and viewport[southwest]


# calculate methods from http://www.rubydoc.info/github/alexreisner/geocoder/master/Geocoder/Calculations

distance = 10
center_point = [41.48519599999999, -81.75088]
box = Geocoder::Calculations.bounding_box(center_point, distance)
# from docs: within_bounding_box(sw_lat, sw_lng, ne_lat, ne_lng, lat_attr, lon_attr)


# venue_thing = kaitlyns_house.within_bounding_box(box)
# p venue_thing