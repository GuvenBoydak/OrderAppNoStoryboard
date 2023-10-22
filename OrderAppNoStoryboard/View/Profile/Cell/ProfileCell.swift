//
//  ProfileCell.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 22.10.2023.
//

import UIKit

final class ProfileCell: UICollectionViewCell {
    // MARK: - Properties
    var activity: Activity? {
        didSet { configure()}
    }
    
    private let containerView: UIView = {
       let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "container")?.cgColor
        view.layer.cornerRadius = 14
        return view
    }()
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Izgara Somon"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
         label.text = "Fiyat"
         label.font = UIFont.systemFont(ofSize: 20)
         return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
         label.text = "Sepeten silindi"
         label.font = UIFont.systemFont(ofSize: 14)
         return label
    }()
    var fullStackView: UIStackView!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    // MARK: - Helpers
extension ProfileCell {
    private func style() {
        fullStackView = UIStackView(arrangedSubviews: [nameLabel,priceLabel,statusLabel])
        fullStackView.axis = .horizontal
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        containerView.addSubview(fullStackView)
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 60),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            fullStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            fullStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 160),
            statusLabel.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -120),
        ])
    }
    private func configure() {
        guard let data = activity else { return }
        nameLabel.text = data.name
        priceLabel.text = "\(data.price)₺"
        statusLabel.text = data.status
    }
}
