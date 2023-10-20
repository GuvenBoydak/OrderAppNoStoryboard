//
//  BasketCell.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 20.10.2023.
//

import UIKit
protocol BasketCellProtocol: AnyObject {
    func deleteFromBasket(cell: BasketCell,id: Int)
}

final class BasketCell: UICollectionViewCell {
    // MARK: - Properties
    var basketItem: Basket? {
        didSet { configure()}
    }
    var basketVM = BasketViewModel()
    
    private let cellContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "container")?.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    private let appImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "pizza")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Ayran"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "Fiyat : 5 TL"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    private let quantityLabel: UILabel = {
       let label = UILabel()
        label.text = "Adet : 1"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    private let totalPriceLabel: UILabel = {
       let label = UILabel()
        label.text = "50 TL"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let deletefromBasketButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "minus.diamond.fill"), for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    private var buttonStackView: UIStackView!
    private var labelStackView: UIStackView!
    private var fullStackView: UIStackView!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
        deletefromBasketButton.addTarget(self, action: #selector(deletefromBasket), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    // MARK: - Helpers
extension BasketCell {
    private func setup() {
        buttonStackView = UIStackView(arrangedSubviews: [deletefromBasketButton,totalPriceLabel])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 72
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        cellContainerView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView = UIStackView(arrangedSubviews: [nameLabel,priceLabel,quantityLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 24
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        fullStackView = UIStackView(arrangedSubviews: [appImage,labelStackView,buttonStackView])
        fullStackView.axis = .horizontal
        fullStackView.spacing = 20
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        cellContainerView.addSubview(buttonStackView)
        cellContainerView.addSubview(labelStackView)
        cellContainerView.addSubview(fullStackView)
        addSubview(cellContainerView)
        NSLayoutConstraint.activate([
            cellContainerView.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            cellContainerView.heightAnchor.constraint(equalToConstant: 150),
            cellContainerView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            cellContainerView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            buttonStackView.topAnchor.constraint(equalTo: cellContainerView.topAnchor,constant: 12),
            buttonStackView.trailingAnchor.constraint(equalTo: cellContainerView.trailingAnchor,constant: -12),
            labelStackView.topAnchor.constraint(equalTo: cellContainerView.topAnchor, constant: 8),
            labelStackView.centerXAnchor.constraint(equalTo: cellContainerView.centerXAnchor),
            fullStackView.topAnchor.constraint(equalTo: cellContainerView.topAnchor, constant: 18),
            appImage.widthAnchor.constraint(equalToConstant: 110),
            appImage.heightAnchor.constraint(equalToConstant: 110),
            fullStackView.leadingAnchor.constraint(equalTo: cellContainerView.leadingAnchor, constant: 8)
        ])
    }
    private func configure() {
        guard let data = basketItem else { return }
        nameLabel.text = data.yemek_adi
        priceLabel.text = data.yemek_fiyat
        quantityLabel.text = data.yemek_siparis_adet
        appImage.setImage(fromURL: "\(URL_IMAGE)\(data.yemek_resim_adi ?? "")")
    }
}
// MARK: - Selectors
extension BasketCell {
    @objc private func deletefromBasket(id: Int) {
        guard let id = Int(basketItem?.sepet_yemek_id ?? "0") else { return }
        basketVM.deleteFromBasket(id: id)
    }
}
