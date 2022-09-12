

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    // MARK: Properties
    // Testing text label
    var helloWorldTest: UILabel = {
        let someText = UILabel()
        someText.text = "21"
        someText.translatesAutoresizingMaskIntoConstraints = false
        someText.font = UIFont.preferredFont(forTextStyle: .headline)
        someText.numberOfLines = 0
        return someText
    }()
    
    var locationButton: UIButton = {
        let currentLocationButton = UIButton(type: .system)
        currentLocationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        currentLocationButton.tintColor = .black
        currentLocationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        return currentLocationButton
    }()
    
    var searchTextField: UITextField = {
        let searchField = UITextField()
        searchField.borderStyle = .roundedRect
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.placeholder = "Type location"
        searchField.tintColor = .lightGray
        searchField.isEnabled = true
        searchField.isUserInteractionEnabled = true
        searchField.autocorrectionType = .no
        return searchField
    }()
    
    var searchButton: UIButton = {
        let locationSearchButton = UIButton(type: .system)
        locationSearchButton.setImage(UIImage(named: "searchIcon"), for: .normal)
        locationSearchButton.translatesAutoresizingMaskIntoConstraints = false
        locationSearchButton.tintColor = .black
        locationSearchButton.contentMode = .scaleAspectFit
        locationSearchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return locationSearchButton
    }()
    
    var background: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    var searchBarStackView: UIStackView = {
        let horizontalSearchBarView = UIStackView()
        horizontalSearchBarView.axis = .horizontal
        horizontalSearchBarView.backgroundColor = UIColor.clear
        horizontalSearchBarView.translatesAutoresizingMaskIntoConstraints = false
        horizontalSearchBarView.distribution = .fillProportionally
        horizontalSearchBarView.spacing = 10
        return horizontalSearchBarView
    }()
    
    var weatherInfoStackView: UIStackView = {
        let verticalWeatherStackview = UIStackView()
        verticalWeatherStackview.axis = .vertical
        verticalWeatherStackview.translatesAutoresizingMaskIntoConstraints = false
//        verticalWeatherStackview.distribution = .
        verticalWeatherStackview.backgroundColor = UIColor.clear
        verticalWeatherStackview.spacing = 2
        verticalWeatherStackview.alignment = .trailing
        return verticalWeatherStackview
    }()
    
    let conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(red: 22/255, green: 53/255, blue: 56/255, alpha: 1)
        imageView.image = UIImage(systemName: "sun.max.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    var temperatureLabel: UILabel = {
        let tempNumberLable = UILabel()
        tempNumberLable.text = "21°C"
        tempNumberLable.font = UIFont.systemFont(ofSize: 72)
        tempNumberLable.translatesAutoresizingMaskIntoConstraints = false
        tempNumberLable.numberOfLines = 0
        return tempNumberLable
    }()
    
    var cityLabel: UILabel = {
        let cityNameLable = UILabel()
        cityNameLable.text = "Helsinki"
        cityNameLable.translatesAutoresizingMaskIntoConstraints = false
        cityNameLable.font = UIFont.systemFont(ofSize: 36)
        cityNameLable.numberOfLines = 0
        return cityNameLable
    }()
    
    var messageWhenNoWeatherHasBeenDisplayed: UILabel = {
        let message = UILabel()
        message.text = "Please provide location to check weather"
        message.translatesAutoresizingMaskIntoConstraints = false
        message.numberOfLines = 0
        message.font = UIFont.preferredFont(forTextStyle: .headline)
        return message
    }()
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    //MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureWeatherManager()
        configureLocationManager()
        self.searchTextField.delegate = self
    }
    
    // MARK: Helpers
    private func setupViews() {
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            background.topAnchor.constraint(equalTo: self.view.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        view.addSubview(messageWhenNoWeatherHasBeenDisplayed)
        NSLayoutConstraint.activate([
            messageWhenNoWeatherHasBeenDisplayed.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageWhenNoWeatherHasBeenDisplayed.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
        
        showScreeenWhenNoWeatherHasBeenDisplayed()
        
        self.view.addSubview(searchBarStackView)
        NSLayoutConstraint.activate([
            searchBarStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            searchBarStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            searchBarStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
        ])
        
        searchBarStackView.addArrangedSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.widthAnchor.constraint(equalToConstant: 50),
            locationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        searchBarStackView.addArrangedSubview(searchTextField)
        searchBarStackView.addArrangedSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(weatherInfoStackView)
        NSLayoutConstraint.activate([
            weatherInfoStackView.topAnchor.constraint(equalTo: searchBarStackView.bottomAnchor, constant: 30),
            weatherInfoStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            weatherInfoStackView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -100)
        ])
        
        weatherInfoStackView.addArrangedSubview(conditionImageView)
        NSLayoutConstraint.activate([
            conditionImageView.trailingAnchor.constraint(equalTo: weatherInfoStackView.trailingAnchor, constant: -10),
            conditionImageView.widthAnchor.constraint(equalToConstant: 100),
            conditionImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        weatherInfoStackView.addArrangedSubview(temperatureLabel)
        weatherInfoStackView.addArrangedSubview(cityLabel)
    }
    
    private func showScreeenWhenNoWeatherHasBeenDisplayed() {
        conditionImageView.image = nil
        temperatureLabel.text = ""
        cityLabel.text = ""
        messageWhenNoWeatherHasBeenDisplayed.text = "Please enter location to see weather"
    }
    
    private func configureWeatherManager() {
        self.weatherManager.delegate = self
    }
    
    private func configureLocationManager(){
        self.locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            self.locationManager.startUpdatingLocation()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        }
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
//            self.loadingSpinner.startAnimating()
            self.temperatureLabel.text = "\(weather.temperatureString)°C"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.messageWhenNoWeatherHasBeenDisplayed.text = ""
//            self.loadingSpinner.stopAnimating()
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    @objc func searchButtonPressed(_ sender: UIButton) {
        self.searchTextField.endEditing(true)
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
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
//            loadingSpinner.startAnimating()
        }
        searchTextField.text = ""
        messageWhenNoWeatherHasBeenDisplayed.text = ""
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
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    @objc func locationButtonPressed() {
        if(CLLocationManager.authorizationStatus() ==
            .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
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
}
