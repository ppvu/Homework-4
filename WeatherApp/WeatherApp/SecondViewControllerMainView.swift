//
//  SecondViewControllerMainView.swift
//  WeatherApp
//
//  Created by spezza on 23.01.2021.
//

import UIKit

class SecondViewControllerMainView: UIView {
    
    
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "---"
        label.textColor = .white
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "---"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 80)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemTeal
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(cityNameLabel)
        addSubview(temperatureLabel)
        
        setLayoutConstraints()
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityNameLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: 0),
            
            
        ])
    }
}
