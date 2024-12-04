//
//  CryptoCoinTableViewCell.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import UIKit

final class CryptoCoinTableViewCell: UITableViewCell {

    private lazy var coinNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var coinSymbolLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var newLabelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        activateConstraints()
    }

    private func setupUI() {
        contentView.addSubview(coinNameLabel)
        contentView.addSubview(coinSymbolLabel)
        contentView.addSubview(coinImageView)
        contentView.addSubview(newLabelImageView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        coinNameLabel.text = nil
        coinSymbolLabel.text = nil
        coinImageView.image = nil
        newLabelImageView.image = nil
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            coinNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coinNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            coinNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -150),

            coinSymbolLabel.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 10),
            coinSymbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            coinSymbolLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -150),
            coinSymbolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            coinImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            coinImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -36),
            coinImageView.widthAnchor.constraint(equalToConstant: 60),
            coinImageView.heightAnchor.constraint(equalToConstant: 60),

            newLabelImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            newLabelImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            newLabelImageView.widthAnchor.constraint(equalToConstant: 30),
            newLabelImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(with coin: CryptoCoin) {
        coinNameLabel.text = coin.name
        coinSymbolLabel.text = coin.symbol
        coinImageView.image = coin.coinImage
        newLabelImageView.image = coin.newImage
        contentView.alpha = coin.isActive ? 1.0 : 0.5
    }

}
