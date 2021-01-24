//
//  CustomCViewCell.swift
//  WeatherApp
//
//  Created by spezza on 20.01.2021.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {

    
    lazy var cityNameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var imageViewIcon: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
//    fileprivate let bg: UIImageView = {
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        iv.layer.cornerRadius = 12
//        //        iv.image = UIImage(systemName: "sun.max.fill")
//
//        return iv
//    }()
//
//    var cityNameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "City"
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupForCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
        contentView.backgroundColor = .systemTeal
    }
    
    func setupForCell() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setCornerRadius()
        
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(imageViewIcon)
        
        setLayoutConstrains()
    }
    
    func setLayoutConstrains() {
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 85),
            
            imageViewIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            imageViewIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            imageViewIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            imageViewIcon.widthAnchor.constraint(equalTo: imageViewIcon.widthAnchor),
            
            cityNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
//            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    private func setCornerRadius() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
    }
}
