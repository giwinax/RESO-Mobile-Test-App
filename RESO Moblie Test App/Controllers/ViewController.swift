//
//  ViewController.swift
//  RESO Moblie Test App
//
//  Created by s b on 18.02.2022.
//

import UIKit

import CoreLocation
import CoreLocationUI
import MapKit



class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    
    
    
    override func loadView() {
        
        
        
        
        view = UIView()
        view.backgroundColor = .white
        let getOfficeListButton = UIButton()
        getOfficeListButton.setTitle("Получить список офисов", for: .normal)
        getOfficeListButton.titleLabel?.lineBreakMode = .byWordWrapping
        getOfficeListButton.setTitleColor(.black, for: .normal)
        getOfficeListButton.titleLabel?.textAlignment = .center
        getOfficeListButton.frame = CGRect(x: 15, y: -50, width: 600, height: 300)
        getOfficeListButton.backgroundColor = .clear
        getOfficeListButton.layer.cornerRadius = 20
        getOfficeListButton.layer.borderWidth = 2
        getOfficeListButton.layer.backgroundColor = UIColor.lightGray.cgColor
        getOfficeListButton.layer.borderColor = UIColor.lightGray.cgColor
        getOfficeListButton.addTarget(self, action: #selector(getOfficeListButtonPressed), for: .touchUpInside)
        getOfficeListButton.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = getOfficeListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = getOfficeListButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = getOfficeListButton.widthAnchor.constraint(equalToConstant: 150)
        let heightConstraint = getOfficeListButton.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        self.view.addSubview(getOfficeListButton)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self

    }
    

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
        }
    }

    
    @IBAction func getOfficeListButtonPressed() {
        locationManager.requestLocation()
        
        let office = Office()
        let officeList = office.List
        if office.error != nil {
            self.errorHandling(office.error!)
        } else {
            
            let OfficeListViewController = OfficeListViewController()
            OfficeListViewController.modalPresentationStyle = .fullScreen
            present(OfficeListViewController, animated: false, completion: nil)
            OfficeListViewController.officeList = officeList
            navigationController?.pushViewController(OfficeListViewController, animated: false)
        }
    }
    
    func errorHandling(_ error: Error) {
        // TODO: different cases of errors
        let alert = UIAlertController(title: "My Title", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

