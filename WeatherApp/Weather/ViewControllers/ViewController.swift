//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var temparatureLabel: UILabel!
    @IBOutlet weak var temparatureValue: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var minTempValue: UILabel!
    @IBOutlet weak var feelTempLabel: UILabel!
    @IBOutlet weak var feelTempValue: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var maxTempValue: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidityValue: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var pressureValue: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var changeCityButton: UIButton!
    
    let weatherDataController = WeatherDataController(service: WeatherWebService())
    let locationManager = CLLocationManager()
    var lat = 0.0
    var long = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setupBinding()
    }
    
    func getData() {
        weatherDataController.getWeatherDataUsinglatLong(lat: lat, long: long)
    }
    
    func setupBinding() {
        weatherDataController.refreshData.bind{ [weak self] refresh in
            if refresh {
                self?.refreshData()
            }
          }
        
        weatherDataController.isFetchingData.bind{ [weak self] fetching in
            if fetching {
                self?.activityView.startAnimating()
            } else {
                self?.activityView.stopAnimating()
            }
          }
        
        weatherDataController.errorMessage.bind{ [weak self] message in
            if message.count > 0 {
                self?.showError()
            }
          }
    }
    
    func refreshData() {
        guard let data = weatherDataController.weatherData else {return}
        guard let wData = data.main else {return}
        
        if let temp = wData.temp {
            temparatureValue.text = String(temp)
        }
        
        if let minTemp = wData.temp_min {
            minTempValue.text = String(minTemp)
        }
        
        if let feelTemp = wData.temp_min {
            feelTempValue.text = String(feelTemp)
        }
        
        if let maxTemp = wData.temp_min {
            maxTempValue.text = String(maxTemp)
        }
        
        if let humidity = wData.temp_min {
            humidityValue.text = String(humidity)
        }
        
        if let pressure = wData.temp_min {
            pressureValue.text = String(pressure)
        }
        
        if let name = data.name {
            locationLabel.text = name
        }
            
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    

    @IBAction func changeCityAction(_ sender: Any) {
        let vc: CitySearchViewController = self.storyboard!.instantiateViewController(withIdentifier: "citySearchViewController") as! CitySearchViewController
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        lat = locValue.latitude
        long = locValue.longitude
        getData()
    }
    
}

extension ViewController: CitySearchDelegate {
    func citySelected(name: String) {
        weatherDataController.getWeatherDataUsingCityName(name: name)
    }
    
    
}

