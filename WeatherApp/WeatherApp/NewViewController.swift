//
//  NewViewController.swift
//  WeatherApp
//
//  Created by spezza on 20.01.2021.
//

import Foundation
import UIKit

class NewViewController: UIViewController {
    
    let networkServise = NetworkService()
    
    var location: (Double, Double)? {
        didSet {
            getData()
        }
    }
    
    var forecast: Forecast?
    
    var weather: CurrentWeather? {
        didSet {
            guard let weather = weather else {
                return
            }
            
            mainView.cityNameLabel.text = weather.city
            mainView.temperatureLabel.text = "\(Int(weather.main.temperature))°C"
        }
    }
    
    var mainView = SecondViewControllerMainView()
    var bottom = ForecastCustomView()
    
    
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(mainView)
        view.backgroundColor = .systemTeal
        
        setupView()
        getData()
        
    }
    
    func setupView() {
        
        view.addSubview(bottomView)
        view.addSubview(bottom)
        bottomViewRoundedCorners()
        setLayoutConstraints()
    }
    
    
    func setLayoutConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: mainView.widthAnchor),
            
            bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            bottomView.topAnchor.constraint(equalTo: mainView.bottomAnchor)
            
            
        ])
    }
    
    func getData() {
        
        guard let location = location else {
            return
        }
        
        networkServise.getWeatherByCoords(
            lat: location.0,
            lon: location.1,
            onSuccess: { forecast in
                self.forecast = forecast
                print(forecast)
                // collectionView.reloadData()
            }, onError: { error in
                print(error)})
    }
    
    func bottomViewRoundedCorners() {
        bottomView.layer.cornerRadius = 12
        bottomView.layer.masksToBounds = true
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = UIColor.clear.cgColor
        
    }
    
}
