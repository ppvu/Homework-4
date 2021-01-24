//
//  CustomCViewCell.swift
//  WeatherApp
//
//  Created by spezza on 20.01.2021.
//

import UIKit

class CustomCell: UICollectionViewCell {

    lazy var centralLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var leftLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var imageViewIcon: UIImageView = {
        
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
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
        
        contentView.addSubview(centralLabel)
        contentView.addSubview(leftLabel)
        contentView.addSubview(imageViewIcon)
        
        setLayoutConstrains()
    }
    
    func setLayoutConstrains() {
        NSLayoutConstraint.activate([
            leftLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            leftLabel.widthAnchor.constraint(equalToConstant: 85),
            
            imageViewIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            imageViewIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            imageViewIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            imageViewIcon.widthAnchor.constraint(equalTo: imageViewIcon.widthAnchor),
            
            centralLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            centralLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
    }
    
    private func setCornerRadius() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
    }
}
