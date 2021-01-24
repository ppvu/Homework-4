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
    
    var collectionView: UICollectionView!
    
    var forecast = [Daily]()
    
    var mainView = SecondViewControllerMainView()
    
    var location: (Double, Double)? {
        didSet {
            getData()
        }
    }
    
    var weather: CurrentWeather? {
        didSet {
            guard let weather = weather else {
                return
            }
            
            mainView.cityNameLabel.text = weather.city
            mainView.temperatureLabel.text = "\(Int(weather.main.temperature))°C"
            if let cv = collectionView {
                cv.reloadData()
            }
        }
    }
    
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
        
        configureCollectionView()
        setupView()
        getData()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .init(white: 1, alpha: 0.2)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 60, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    func setupView() {
        view.addSubview(collectionView)
        
        collectionViewRoundCorners()
        setLayoutConstraints()
    }
    
    
    func setLayoutConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.8),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: mainView.bottomAnchor)
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
                self.forecast = forecast.daily
                self.collectionView.reloadData()
                print(forecast)
            }, onError: { error in
                print(error)})
    }
    
    func collectionViewRoundCorners() {
        collectionView.layer.cornerRadius = 12
        collectionView.layer.masksToBounds = true
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.clear.cgColor
    }
}

extension NewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell
        else {
            fatalError("Error")
        }
        let date = Date(timeIntervalSince1970: TimeInterval(forecast[indexPath.row].dt))
        let formatDate = Date.getDateFrom(date: date)
        
        cell.leftLabel.text = formatDate
        cell.centralLabel.text = "\(Int(forecast[indexPath.row].temp.day))°C"
        cell.imageViewIcon.image = iconMap[forecast[indexPath.row].weather.first?.main ?? "Clear"]
        
        return cell
    }
}
