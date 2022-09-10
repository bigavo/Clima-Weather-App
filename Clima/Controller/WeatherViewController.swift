//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
class WeatherViewController: UIViewController{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
//                locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            // Higher accuracy will require longer time to retrieve location data
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            }
        
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func locationPress(_ sender: Any) {
//        locationManager.startUpdatingLocation()
        let status = CLLocationManager.authorizationStatus()

            if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
                // show alert to user telling them they need to allow location data to use some feature of your app
                
                print("show alert to user telling them they need to allow location data to use some feature of your app")
                return
            }

            // if haven't show location permission dialog before, show it to user
            if(status == .notDetermined){
                locationManager.requestWhenInUseAuthorization()

                // if you want the app to retrieve location data even in background, use requestAlwaysAuthorization
                // locationManager.requestAlwaysAuthorization()
                return
            }
            
            // at this point the authorization status is authorized
            // request location data once
            locationManager.startUpdatingLocation()
          
            // start monitoring location data and get notified whenever there is change in location data / every few seconds, until stopUpdatingLocation() is called
            // locationManager.startUpdatingLocation()
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use searchTextField.text to get the weather for that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        // might be that user didn't enable location service on the device
            // or there might be no GPS signal inside a building
          
            // might be a good idea to show an alert to user to ask them to walk to a place with GPS signal
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        locationManager.stopUpdatingLocation()
//        if let location = locations.last {

//        }
//        locationManager.stopUpdatingLocation()
//        weatherManager.delegate = nil
//        print(locations)
        locationManager.stopUpdatingLocation()
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            print("location manager authorization status changed")
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            switch clErr {
            case CLError.locationUnknown:
                print("location unknown")
            case CLError.denied:
                print("denied")
            default:
                print("other Core Location error")
            }
        } else {
            print("other error:", error.localizedDescription)
        }
    }
}

