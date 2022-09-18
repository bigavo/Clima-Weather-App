

#  Clima

## About Clima

Clima is the app where user can check weather based on the GPS data from the iPhone as well as by searching for a city manually.

## What was improved

* Change from storyboard UI to programmatically coded UI

* Complete function where user can check weather based on the GPS data of the iPhone. The app automatically shows weather for their location at the start of the application (real device only)

* If the user doesn’t allow to use their location, tapping on the location button show an explanation dialog. The dialog has a button that leads to the app’s settings on the device (real device only)

* Add logger functions to print event to device console on some user actions, for example, on clicking location button, on pressing search button, on successfully updating weather to the screen using NSLog() function.

* Added unit test to test fetching weather with city name, and fetching weather with location coordinates by mocking URLSession and URLSessionDataTask

## Things to improve 
 
 Because of time limitation, not all the needed features for a production quality app has been sufficiently added. The app would be more user-friendly if they would have: 
* Input field city suggestion/ correction

    Currently the app will return weather only if user enters full and grammatically correct city name. In case the user mistakenly enter a non-existing city name, the app will simply displays a text on screen saying that "Sorry. we can not find location". However, it would be more user-friendly to show the the suggestion city list based on user's input before they press search button to prevent this mistake when user type incorrect city name. 
 
* Security concern: 
    Hide appId from urlString
