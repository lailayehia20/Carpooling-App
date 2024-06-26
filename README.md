# Carpool: Ain Shams University's Faculty of Engineering Rideshare Application
Welcome to Carpool, the dedicated rideshare application tailored exclusively for the vibrant community at Ain Shams University's Faculty of Engineering! Developed by students for students, Carpool aims to simplify and enhance your daily commute, fostering a sense of community while prioritizing convenience.

# Key Features
## Secure Authentication
Users sign in using their active @eng.asu.edu.eg accounts.
Ensures a trusted and closed community exclusively for the Faculty of Engineering.
## Scheduled Rides
One morning ride starting at 7:30 am from various locations to the Faculty of Engineering campus.
One return ride at 5:30 pm from the Faculty of Engineering campus.
## Reservation System
Morning Ride: Reserve your seat before 10:00 pm the previous day.
Return Ride: Reserve your seat before 1:00 pm on the same day.
## Community-Driven Operation
Operated by students for students, fostering a sense of community and understanding the unique needs of the Faculty of Engineering.
## Closed Community
Access is granted only to users with @eng.asu.edu.eg accounts, creating a secure and exclusive environment.
## User Profiles
Users can create profiles with essential information, enhancing trust and accountability within the community.

# Steps to Use Carpool

1. **Sign In:**
   - Use your @eng.asu.edu.eg account to sign in and join the Carpool community.
   
2. **Reserve Your Ride:**
   - Morning Ride: Make a reservation before 10:00 pm the previous day.
   - Return Ride: Make a reservation before 1:00 pm on the same day.
   
3. **Meet Up:**
   - Arrive at the designated pickup points (Gate 3 or Gate 4) for your scheduled ride.
   
4. **Enjoy the Ride:**
   - Travel comfortably with your fellow students to and from the Faculty of Engineering campus.

# Pilot Project Information
Morning Ride: Starts at 7:30 am from various locations to the Faculty of Engineering campus.
Return Ride: Starts at 5:30 pm from the Faculty of Engineering campus to various locations.

# User Interface
## Driver User Interface:
The driver chooses either to sign in or sign up.
If he clicks on the sign in, he can sign in with a previous account he created.
If he clicks on sign up, he can create new account.
He then chooses whether he wants to ride from the faculty or to the faculty
If he chooses to ride to the faculty, the following screen is shown. In the select time field the only accepted time is 7:30 am.
If he chooses to ride from the faculty the following screen will be visible to him. In the select time field the only accepted time is 5:30 pm.
The following screen shows the driver profile screen.
The following screen shows the driver requests screen
## Student User Interface:
The user has the same sign in, sign up, profile and the main route selection page (to the faculty => shows him all the rides offered heading to the faculty or from the faculty => shows him all the rides offered heading back from the faculty).
The following screen shows the list of available rides to the faculty. There is a similar one but for the rides from the faculty.
The following screen shows the cart with the requests made by the user and the status of each request.
The following screen shows the order history screen.
# Database:
## Driver:
There is a Drivers collection that contains a list of all the drivers available. For each driver there are 2 collections RidesToFaculty and RidesFromFaculty. These collections store the rides offered by the driver along with the driver id and the ride id.
## User:
There is Users collection which contains a list of all the users available in the system. For each user there are 2 collections the Requests collection which contains details of all the rides the user requested and the second collection is the CreditCardDetails collection which stores the details of the credit card of the user

