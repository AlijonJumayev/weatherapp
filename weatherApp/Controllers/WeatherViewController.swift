//
//  ViewController.swift
//  weatherApp
//
//  Created by Alijon Jumayev on 3/23/24.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate, CLLocationManagerDelegate {
    
    var weatherManager = WeatherManager()
    let locationManager  = CLLocationManager()
    
    let background     = UIImageView()
    let location       = UIButton()
    let search         = UIButton()
    let temp           = UILabel()
    let image          = UIImageView()
    let label          = UILabel()
    let cityName       = UILabel()
    
    private let searchTextfield: UITextField = {
        return UITextField().textField(withPlaceholder: "search")
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        searchTextfield.delegate = self
        weatherManager.delegate  = self
        
        setbackground()
        setLocation()
        setSearch()
        setImage()
        tempereture()
        imagelabel()
        nameCity()
        
        
        view.addSubview(searchTextfield)
        searchTextfield.anchor(top: location.topAnchor, bottom: nil, leading: location.trailingAnchor, trailing: search.leadingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 40))
        
        search.addTarget(self, action: #selector(setButton), for: .touchUpInside)
        
        location.addTarget(self, action: #selector(loc), for: .touchUpInside)
        
    }
    @objc func loc(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    @objc func setButton(_ sender: UIButton) {
        searchTextfield.endEditing(true)
        print(searchTextfield.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextfield.endEditing(true)
        print(searchTextfield.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "type somthing"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextfield.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextfield.text = ""
    }
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temp.text = weather.temperatureString
            self.image.image = UIImage(systemName: weather.condtionName)
            self.cityName.text = weather.cityName
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
    private func locationManager(_ manager: CLLocationManager, didUpdateLocation locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitute: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
   
    
    
    
    

    
    //MARK: - all view function
    
    func nameCity() {
        view.addSubview(cityName)
        cityName.text = "Uzbekistan"
        cityName.textAlignment = .center
        cityName.font = UIFont.systemFont(ofSize: 30)
        cityName.anchor(top: temp.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 25))
    }
    func setImage() {
        view.addSubview(image)
        image.image = UIImage(systemName: "cloud.moon.rain")
        image.tintColor = .white
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.anchor(top: search.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 120, height: 120))
    }
    func tempereture() {
        temp.text = "22"
        view.addSubview(temp)
        temp.textColor = .white
        temp.textAlignment = .center
        temp.font = UIFont.systemFont(ofSize: 80)
        temp.anchor(top: image.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 95, bottom: 0, right: 0),size: .init(width: 0, height: 80))
    }
    func imagelabel() {
        label.text = "ºC"
        view.addSubview(label)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 80)
        label.anchor(top: image.bottomAnchor, bottom: nil, leading: temp.trailingAnchor, trailing: nil, padding: .init(top: 5, left: 10 , bottom: 0, right: 0),size: .init(width: 0, height: 80))
    }
    func setSearch() {
        let image = UIImage(systemName: "magnifyingglass")
        search.setBackgroundImage(image, for: .normal)
        view.addSubview(search)
        search.tintColor = .black
        search.anchor(top: location.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 20),size: .init(width: 40, height: 40))
    }
    func setLocation() {
        let image = UIImage(systemName: "location.north.circle.fill")
        location.setBackgroundImage(image, for: .normal)
        view.addSubview(location)
        location.tintColor = .black
        location.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 5, left: 20, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
    }
   
    func setbackground() {
        background.image = UIImage(named: "IMG_0715")
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        background.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
    }

}

