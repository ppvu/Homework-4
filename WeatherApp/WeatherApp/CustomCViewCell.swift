//
//  CustomCViewCell.swift
//  WeatherApp
//
//  Created by spezza on 20.01.2021.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {

    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
//        iv.image = UIImage(systemName: "flame")
        iv.layer.cornerRadius = 12
        return iv
    }()

    var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "City"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .red
        contentView.addSubview(bg)
        contentView.addSubview(cityNameLabel)

        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        cityNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
