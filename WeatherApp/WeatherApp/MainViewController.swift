//
//  ViewController.swift
//  WeatherApp
//
//  Created by spezza on 19.01.2021.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var cities = ["Kyiv", "Dnipro"]
    
    var weathers = [CurrentWeather]()
    
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        collectionView.delegate = self
        
        collectionView.backgroundColor = .white
        
        getData()
        setupNavigationBar()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 40, height: 90)
        return layout
    }
    
    private func setupNavigationBar() {
        title = "My Weather"
        
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(handleAddButton)),
            animated: true)
        
        navigationItem.setLeftBarButton(
            UIBarButtonItem(
                barButtonSystemItem: .refresh,
                target: self,
                action: #selector(handleRefreshButton)),
            animated: true)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewViewController()
        
        let lat = weathers[indexPath.row].coord.lat
        let lon = weathers[indexPath.row].coord.lon
        
        vc.weather = weathers[indexPath.row]
        vc.location = (lat, lon)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell
        else {
            fatalError("Error")
        }
        
        cell.centralLabel.text = weathers[indexPath.row].city
        cell.leftLabel.text = "\(Int(weathers[indexPath.row].main.temperature))°C"
        cell.imageViewIcon.image = iconMap[weathers[indexPath.row].weather.first?.main ?? "Clear"]
        
        return cell
    }
    
    func getData() {
        networkService.getWeatherForAllCities(cities: cities) { [weak self] weathers in
            self?.weathers = weathers
            self?.collectionView.reloadData()
        }
    }
}

extension ViewController {
    
    @objc func handleAddButton() {
        let alertController = UIAlertController(
            title: "Add the city",
            message: "Enter your city",
            preferredStyle: .alert)
        
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let answer = alertController.textFields![0]
            let newCity = answer.text ?? ""
            
            self.cities.append(newCity)
            self.getData()
            
            self.collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        alertController.view.layoutIfNeeded()
        
        present(alertController, animated: true)
    }
    
    @objc func handleRefreshButton() {
        self.getData()
    }
}
