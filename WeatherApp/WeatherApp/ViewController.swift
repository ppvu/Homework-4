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
    
    var cities: [String] = ["Kyiv", "Dnipro"]
    
    var weather: Current?

    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        collectionView.delegate = self
        networkService.getWeather { (result) in
            print(result)
            self.weather = result.current
            self.collectionView.reloadData()
        } onError: { (error) in
            print(error)
        }

        
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 40, height: 60)
        return layout
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewViewController()
        let city = cities[indexPath.row]
        vc.title = city
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: (view.frame.width / 2) - 20, height: 120)
//    }
//}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        if let temp = weather?.temp {
            cell.cityNameLabel.text = String(temp)
        }
        return cell
    }
    
}
