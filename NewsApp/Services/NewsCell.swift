//
//  NewsCell.swift
//  NewsApp
//
//  Created by Andrey Gordienko on 21.03.2025.
//

import UIKit
import Kingfisher

final class NewsCell: UITableViewCell {
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var backgroundImage = UIImageView()

    func configureCell(news: News) {
        backgroundImage.kf.setImage(with: news.urlToImage)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = news.title
        descriptionLabel.text = news.description
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        titleLabel.tintColor = .label
        descriptionLabel.tintColor = .label
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(backgroundImage)

        setUpConstraints()
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            backgroundImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            contentView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

