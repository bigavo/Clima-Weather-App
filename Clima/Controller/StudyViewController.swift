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



//
//func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    print("location manager authorization status changed")
//    switch status {
//    case .authorizedAlways:
//       print("user allow app to get location data when app is active or in background")
//    case .authorizedWhenInUse:
//       print("user allow app to get location data only when app is active")
//    case .denied:
//       print("user tap 'disallow' on the permission dialog, cant get location data")
//    case .restricted:
//       print("parental control setting disallow location data")
//    case .notDetermined:
//       print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
//    }
//}



//
//   
//

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


