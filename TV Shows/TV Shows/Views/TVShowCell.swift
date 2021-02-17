//
//  TVShowCell.swift
//  TV Shows
//
//  Created by Ali Hassan on 09/02/2021.
//

import UIKit


class TVShowCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var tvShowData:TVShowResult? {
        didSet {
            guard let showInfo = tvShowData else {return}
            if let name = showInfo.show?.name {
                titleLabel.text = name
            }
            if let genres = showInfo.show?.genres {
                subtitleLabel.text = genres.joined(separator: ", ")
            }
            if let rating = showInfo.show?.rating?.average {
                descriptionLabel.text = "Rating: \(rating)"
            }
            if let imageURL = showInfo.show?.image?.medium {
                thumbImageView.downloadImageFrom(urlString: imageURL)
            }
        }
    }
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = Constants.AppColors.primaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.textColor = Constants.AppColors.primaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.textColor = Constants.AppColors.primaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rating: N/A"
        return label
    }()
    
    private let thumbImageView:CacheImageView = {
        let img = CacheImageView()
        img.image = UIImage(named: "tvShow")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = Constants.AppColors.primaryColor
        return img
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbImageView.cancelLoadingImage()
    }
    
    // MARK: - View Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func setUpData(tvShowData: TVShowResult?){
        thumbImageView.image = UIImage(named: "tvShow")
        self.tvShowData = tvShowData
    }

}
// MARK: - UI Setup

extension TVShowCell {
    private func setupUI() {
        self.contentView.addSubview(thumbImageView)
        let infoSV = UIStackView()
        infoSV.translatesAutoresizingMaskIntoConstraints = false
        infoSV.axis = .vertical
        infoSV.spacing = 5
        self.contentView.addSubview(infoSV)
        infoSV.addArrangedSubview(titleLabel)
        infoSV.addArrangedSubview(subtitleLabel)
        infoSV.addArrangedSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            thumbImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            thumbImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:16),
            thumbImageView.widthAnchor.constraint(equalToConstant:60),
            thumbImageView.heightAnchor.constraint(equalToConstant:60),
            infoSV.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            infoSV.leadingAnchor.constraint(equalTo:self.thumbImageView.trailingAnchor, constant:16),
            infoSV.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-16),
        ])
    }
}



