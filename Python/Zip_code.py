import geopy
from geopy.geocoders import Nominatim

geolocator = Nominatim(user_agent="geoapiExercises") 
  
# Zipocde input 
# zipcode = "201301"
# zipcode = input("Enter your Zipcode here: ")
  
# Using geocode() 
location = geolocator.geocode("201307") 
print(location.address)
print((location.latitude, location.longitude))
print(location.raw)
  
# Displaying address details 
# print("Zipcode:",zipcode) 
# print("Checking details.....")
# print("Details of the Zipcode:")
# print(location)
