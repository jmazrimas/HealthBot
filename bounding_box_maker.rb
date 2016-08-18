require 'geocoder'

address = ARGV.join(" ")
location_possibilities_array = Geocoder.search(address)
first_try_location = location_possibilities_array[0]
hash_geometry = first_try_location.geometry
#need location, viewport[northeast] and viewport[southwest]
p "Hash geometry"
p hash_geometry
location_hash = hash_geometry["location"]
p location_hash