Must
- Currently kon screen sheta dekha jae, and oita jaate clickable na hoi
- logged in na thakle jeno route kore login screen e pathae dae
- onno karo itinerary jaate randomly keo na dekhte pare
- Home screen
	* Destination/Hotel/Restaurants filtering
	* Destination
- Destination
  - show location on map and center
- New Trip Screen
    - When clicking destination, initialize with location and name e.g. "Location Trip"
    - Limit start and end to not cross
    - Add search to location and centering
    - Initialize with image
- Near Me
	* Get user current location
	* show destinations on screen
- Search
	* All left
	* Can only be done after destination is done
- Account
  - Fix future builder rebuilding everytime
  - Add suggestions to share dialog
- New Trip Screen
  - add image upload
  - update image
  - add search to location picker
- Edit Information Screen
  - Show indicator that name/password/image is being updated
- Itinerary
    - Allow editing trip info
    - Show image of trip
    - Add map to mobile screen
    - Add next step indicator
    M Show tracker on map
    M Center map to trip location
- Image
    - Give default image upon account creation
    - Show image on account screen
    - Upload
        - Edit info
        - new trip
            - auto-fetch image


Destination
- name
- image (google koreo ana jae/ bing images api)
- location
- nearby (hotels and stuff)
- description
  - Shob bhalo thakle ja pabo tai
  - ar na thakle google kore description

Kon kon anbo
- Hand picked destinations for banner and home carousels (shob data django te thakbe)
- search results from scraper
  - Initial results (done)
  - Get type of establishment (done)
  - Clicked results
    - Description (done)
    - LongLat
    - Things to do
    - Nearby places