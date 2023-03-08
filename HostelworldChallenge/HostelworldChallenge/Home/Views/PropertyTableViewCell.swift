//
//  PropertyTableViewCell.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation
import UIKit

final class PropertyTableViewCell: UITableViewCell {

    // MARK: Private Constants

    private struct Constants {
        static let type = "Type: "
        static let city = "City: "
        static let overallRating = "Overall rating: "
        static let percentageSimbol = "%"
        static let propertyImageViewSize: CGFloat = 70
        static let propertyImageViewCornerRadius: CGFloat = 35
    }

    // MARK: Constants

    static let cellIdentifier = "PropertyTableViewCell"

    // MARK: Private Properties

    private lazy var propertyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private lazy var propertyTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(16)
        return label
    }()

    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(16)
        return label
    }()

    private lazy var overallRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(16)
        return label
    }()

    private lazy var propertyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = Constants.propertyImageViewCornerRadius
        return imageView
    }()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellStyle()
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearViews()
    }
}

// MARK: Setup cell

extension PropertyTableViewCell {
    func setupCell(_ data: PropertyCellDataProtocol?) {
        guard let data else { return }
        propertyNameLabel.text = data.propertyName
        propertyTypeLabel.text = Constants.type + data.propertyType
        cityNameLabel.text = Constants.city + data.cityName
        overallRatingLabel.text = Constants.overallRating + String(data.overallRatingPercentage) + Constants.percentageSimbol
        propertyImageView.setRemoteImage(imageURL: data.thumbnailImage)
    }
}

// MARK: Private methods

private extension PropertyTableViewCell {
    func setupCellStyle() {
        backgroundColor = .white
    }

    func setupViews() {
        [
            propertyNameLabel,
            propertyTypeLabel,
            cityNameLabel,
            overallRatingLabel,
            propertyImageView
        ].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            propertyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            propertyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            propertyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            propertyImageView.heightAnchor.constraint(equalToConstant: Constants.propertyImageViewSize),
            propertyImageView.widthAnchor.constraint(equalToConstant: Constants.propertyImageViewSize),
            propertyImageView.topAnchor.constraint(equalTo: propertyNameLabel.bottomAnchor, constant: 10),
            propertyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            propertyTypeLabel.topAnchor.constraint(equalTo: propertyImageView.topAnchor),
            propertyTypeLabel.leadingAnchor.constraint(equalTo: propertyImageView.trailingAnchor, constant: 16),
            propertyTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            cityNameLabel.topAnchor.constraint(equalTo: propertyTypeLabel.bottomAnchor, constant: 8),
            cityNameLabel.leadingAnchor.constraint(equalTo: propertyTypeLabel.leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            overallRatingLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8),
            overallRatingLabel.leadingAnchor.constraint(equalTo: propertyTypeLabel.leadingAnchor),
            overallRatingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overallRatingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }

    func clearViews() {
        propertyNameLabel.text = ""
        propertyTypeLabel.text = ""
        cityNameLabel.text = ""
        overallRatingLabel.text = ""
        propertyImageView.image = nil
    }
}
