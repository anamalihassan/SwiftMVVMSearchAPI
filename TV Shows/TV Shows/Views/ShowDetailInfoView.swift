//
//  ShowDetailInfoView.swift
//  TV Shows
//
//  Created by Ali Hassan on 09/02/2021.
//

import UIKit

public class ShowDetailInfoView: UIView {
    
    // MARK: - Properties
    
    let showThumbIV: CacheImageView = {
        let image = CacheImageView()
        image.image = UIImage(named: "tvShow")
        image.contentMode = .scaleAspectFill
        image.accessibilityIdentifier = Constants.AccessibilityIdentifiers.ShowDetailInfoView.showThumbIV
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textColor = Constants.AppColors.primaryColor
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.accessibilityIdentifier = Constants.AccessibilityIdentifiers.ShowDetailInfoView.summaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let showInfoStackView: UIStackView  = {
        let infoSV = UIStackView()
        infoSV.translatesAutoresizingMaskIntoConstraints = false
        infoSV.axis = .vertical
        infoSV.spacing = 5
        infoSV.accessibilityIdentifier = Constants.AccessibilityIdentifiers.ShowDetailInfoView.showInfoStackView
        return infoSV
    }()
    
    // MARK: - View Initializer
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
    }
    
    
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI Setup

extension ShowDetailInfoView {
    private func setupUI() {
        addSubview(showThumbIV)
        addSubview(summaryLabel)
        addSubview(showInfoStackView)
        
        NSLayoutConstraint.activate([
            showThumbIV.topAnchor.constraint(equalTo:self.topAnchor, constant: 8),
            showThumbIV.widthAnchor.constraint(equalToConstant:70),
            showThumbIV.heightAnchor.constraint(equalToConstant:70),
            showThumbIV.centerXAnchor.constraint(equalTo:self.centerXAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo:showThumbIV.bottomAnchor, constant: 32),
            summaryLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor),
            
            showInfoStackView.topAnchor.constraint(equalTo:summaryLabel.bottomAnchor, constant: 16),
            showInfoStackView.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            showInfoStackView.trailingAnchor.constraint(equalTo:self.trailingAnchor),
            //            self.showInfoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    // MARK: Add Show Info 
    
    func addShowInfo(title: String, description: String){
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.accessibilityIdentifier = "titleLabel"
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        descriptionLabel.textColor = Constants.AppColors.primaryColor
        descriptionLabel.textAlignment = .center
        descriptionLabel.accessibilityIdentifier = "descriptionLabel"
        
        let infoSV = UIStackView()
        infoSV.axis = .horizontal
        infoSV.distribution = .equalSpacing
        infoSV.spacing = 5
        infoSV.addArrangedSubview(titleLabel)
        infoSV.addArrangedSubview(descriptionLabel)
        
        self.showInfoStackView.addArrangedSubview(infoSV)
    }
}


