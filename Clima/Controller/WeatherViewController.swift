

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
    
    var errorMessage: UILabel = {
        let errMessage = UILabel()
        errMessage.text = ""
        errMessage.translatesAutoresizingMaskIntoConstraints = false
        return errMessage
    }()
    
    let loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
           messageWhenNoWeatherHasBeenDisplayed.text = ""
           locationManager.startUpdatingLocation()
       }
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
        view.addSubview(loadingSpinner)
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(errorMessage)
        NSLayoutConstraint.activate([
            errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
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
            searchBarStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 10)
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
    
    private func clearView(){
        conditionImageView.image = nil
        temperatureLabel.text = ""
        cityLabel.text = ""
        messageWhenNoWeatherHasBeenDisplayed.text = ""
        errorMessage.text = ""
    }
    
    private func showScreeenWhenNoWeatherHasBeenDisplayed() {
        clearView()
        messageWhenNoWeatherHasBeenDisplayed.text = "Please enter location to see weather"
    }
    
    private func showErrorMessage() {
        clearView()
        self.errorMessage.text = "Sorry, we can not find the location"
        loadingSpinner.stopAnimating()
    }
    
    private func configureWeatherManager() {
        self.weatherManager.delegate = self
    }
    
    private func configureLocationManager(){
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            self.locationManager.startUpdatingLocation()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        }
    }
    
    private func showAskingLocationPermissionMessage() {
        let alert = UIAlertController(title: "Notice", message: "Please allow location to check weather of where you are", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Go to settings", style: UIAlertAction.Style.default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.redirectToAppLocationSettings()
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func redirectToAppLocationSettings(){
        let url = URL(string:UIApplication.openSettingsURLString)
        if UIApplication.shared.canOpenURL(url!){
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    @objc func locationButtonPressed() {
        let status = CLLocationManager.authorizationStatus()
        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            showAskingLocationPermissionMessage()
        } else if (CLLocationManager.authorizationStatus() == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
            return
        } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways ){
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(WeatherViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.showErrorMessage()
        }
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.clearView()
            self.loadingSpinner.startAnimating()
            self.temperatureLabel.text = "\(weather.temperatureString)°C"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.messageWhenNoWeatherHasBeenDisplayed.text = ""
            self.loadingSpinner.stopAnimating()
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @objc func searchButtonPressed(_ sender: UIButton) {
        self.searchTextField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print(searchTextField.text!)
        searchButtonPressed(searchButton)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            self.clearView()
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            self.loadingSpinner.startAnimating()
        }
        searchTextField.text = ""
        messageWhenNoWeatherHasBeenDisplayed.text = ""
    }
}
//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            switch clErr {
            case CLError.locationUnknown:
                print("Sorry, we can not find location")
            case CLError.denied:
                print("denied")
            default:
                print("Other Core Location error")
            }
        } else {
            print("other error:", error.localizedDescription)
        }
    }
}


