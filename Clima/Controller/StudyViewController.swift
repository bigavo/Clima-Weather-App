//
//  StudyViewController.swift
//  Clima
//
//  Created by Trinh Tran on 11.9.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import UIKit

class StudyViewController: UIViewController {
    // MARK: Properties
    var helloWorldTest: UILabel = {
        let someText = UILabel()
        someText.text = "Hello World "
        someText.translatesAutoresizingMaskIntoConstraints = false
        someText.numberOfLines = 0
        return someText
    }()
    
    var helloWorldTestSencond: UILabel = {
        let someText = UILabel()
        someText.text = "Hello World"
        someText.translatesAutoresizingMaskIntoConstraints = false
        return someText
    }()
    
    var helloWorldTestThird: UILabel = {
        let someText = UILabel()
        someText.text = "Hello World"
        someText.translatesAutoresizingMaskIntoConstraints = false
        return someText
    }()
    
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.gray
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .red
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupViews()
    }
    
    // MARK: Helpers
    private func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(helloWorldTest)
        verticalStackView.addArrangedSubview(helloWorldTestSencond)
        verticalStackView.addArrangedSubview(helloWorldTestThird)
        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
        ])
        
        
    }
}


//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        if let clErr = error as? CLError {
//            switch clErr {
//            case CLError.locationUnknown:
//                print("location unknown")
//            case CLError.denied:
//                print("denied")
//            default:
//                print("other Core Location error")
//            }
//        } else {
//            print("other error:", error.localizedDescription)
//        }
//    }
//    let loadingSpinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView()
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        return spinner
//    }()

//    
//
//   @objc func locationPressed(_ sender: Any) {
//    //        locationManager.startUpdatingLocation()
//    //        let status = CLLocationManager.authorizationStatus()
//
//    //            if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
//            if(CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted || !CLLocationManager.locationServicesEnabled()){
//                    // show alert to user telling them they need to allow location data to use some feature of your app
//                    showAskingLocationPermissionMessage()
//            } else if (CLLocationManager.authorizationStatus() == .notDetermined){
//    //            if haven't show location permission dialog before, show it to user
//                locationManager.requestWhenInUseAuthorization()
//
//                // if you want the app to retrieve location data even in background, use requestAlwaysAuthorization
//                // locationManager.requestAlwaysAuthorization()
//                return
//            } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways ){
//                locationManager.startUpdatingLocation()
//            }
//                // at this point the authorization status is authorized
//                // request location data once
//                locationManager.startUpdatingLocation()
//
//                // start monitoring location data and get notified whenever there is change in location data / every few seconds, until stopUpdatingLocation() is called
//                // locationManager.startUpdatingLocation()
//        }

//}
//
//        showScreeenWhenNoWeatherHasBeenDisplayed()
//
//        
//        
//
//        searchTextField.delegate = self
//        weatherManager.delegate = self

//
//    override func viewWillAppear(_ animated: Bool) {
//        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
//            messageWhenNoWeatherHasBeenDisplayed.text = ""
//            locationManager.startUpdatingLocation()
//        }
//    }
//


// 
//

//


//
//
//
//
//    func showAskingLocationPermissionMessage() {
//
//        // create the alert
//        let alert = UIAlertController(title: "Notice", message: "Please allow location to check weather of where you are", preferredStyle: UIAlertController.Style.alert)
//
//        // add the actions (buttons)
//        alert.addAction(UIAlertAction(title: "Go to settings", style: UIAlertAction.Style.default, handler: { action in
//                        switch action.style{
//                        case .default:
//
//                            print("default")
//                            self.redirectToAppLocationSettings()
//                        case .cancel:
//                            print("cancel")
//
//                        case .destructive:
//                            print("destructive")
//                        }
//                    }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//
//
////        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
////            switch action.style{
////            case .default:
////
////                print("default")
////                self.redirectToAppLocationSettings()
////            case .cancel:
////                print("cancel")
////
////            case .destructive:
////                print("destructive")
////            }
////        }))
//    }
//
////     This will open your app settings in settings App
//    func redirectToAppLocationSettings(){
//        let url = URL(string:UIApplication.openSettingsURLString)
//        if UIApplication.shared.canOpenURL(url!){
//    // can open succeeded.. opening the url
//        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
//        }
//    }
//
//}
//
//class LoadingViewController:  UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//
//            // Add the blurEffectView with the same
//            // size as view
//            blurEffectView.frame = self.view.bounds
//            view.insertSubview(blurEffectView, at: 0)
//
//            // Add the loadingActivityIndicator in the
//            // center of view
//            loadingActivityIndicator.center = CGPoint(
//                x: view.bounds.midX,
//                y: view.bounds.midY
//            )
//            view.addSubview(loadingActivityIndicator)
//    }
//
//    var loadingActivityIndicator: UIActivityIndicatorView {
//        let indicator = UIActivityIndicatorView()
//        indicator.style = .large
//        indicator.color = .white
//        indicator.startAnimating()
//        indicator.autoresizingMask = [
//            .flexibleLeftMargin, .flexibleRightMargin,
//            .flexibleTopMargin, .flexibleBottomMargin
//        ]
//        return indicator
//    }
//
//
//    var blurEffectView: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//
//        blurEffectView.alpha = 0.8
//
//        // Setting the autoresizing mask to flexible for
//        // width and height will ensure the blurEffectView
//        // is the same size as its parent view.
//        blurEffectView.autoresizingMask = [
//            .flexibleWidth, .flexibleHeight
//        ]
//
//        return blurEffectView
//    }()
//
//}


