//
//  HomeCell.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 18.10.2023.
//

import UIKit
import Kingfisher

protocol HomeCellProtocol: AnyObject {
    func increaseQuantity(in cell: HomeCell)
    func decreaseQuantity(in cell: HomeCell)
    func addToBasket(in cell: HomeCell,item basket: Basket)
}

final class HomeCell: UICollectionViewCell {
    // MARK: - Properties
    weak var delegate: HomeCellProtocol?
    var food: Food? {
        didSet { configure()}
    }
    
    private let decreaseQuantityButton: UIButton = {
       let buttton = UIButton()
        buttton.setImage(UIImage(systemName:"minus.square.fill"), for: .normal)
        buttton.tintColor = .systemOrange
        return buttton
    }()
    private let increaseQuantityButton: UIButton = {
       let buttton = UIButton()
        buttton.setImage(UIImage(systemName:"plus.app.fill"), for: .normal)
        buttton.tintColor = .systemBlue
        return buttton
    }()
     let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private let appImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notes")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
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
         label.text = "6 TL"
         label.font = UIFont.systemFont(ofSize: 16)
         return label
     }()
    private let addBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 12
        return button
    }()
    var quantityStackView: UIStackView!
    var imageQuantityStackView: UIStackView!
    var fullStackView: UIStackView!
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = 12
        decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        increaseQuantityButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        addBasketButton.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    // MARK: - Helpers
extension HomeCell {
    private func style() {
        quantityStackView = UIStackView(arrangedSubviews: [increaseQuantityButton, quantityLabel, decreaseQuantityButton])
        quantityStackView.axis = .vertical
        quantityStackView.spacing = 18
        quantityLabel.textAlignment = .center
        imageQuantityStackView = UIStackView(arrangedSubviews: [appImage,quantityStackView ])
        imageQuantityStackView.spacing = 8
        fullStackView = UIStackView(arrangedSubviews: [imageQuantityStackView, nameLabel, priceLabel, addBasketButton])
        fullStackView.axis = .vertical
        fullStackView.spacing = 8
        fullStackView.alignment = .center
    }
    private func layout() {
        contentView.addSubview(fullStackView)
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appImage.widthAnchor.constraint(equalToConstant: 120),
            appImage.heightAnchor.constraint(equalToConstant: 120),
            addBasketButton.widthAnchor.constraint(equalToConstant: 160),
            fullStackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            fullStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    private func configure() {
        guard let data = food else { return }
        appImage.setImage(fromURL: "\(URL_IMAGE)\(data.yemek_resim_adi)")
        nameLabel.text = data.yemek_adi
        priceLabel.text = data.yemek_fiyat
    }
}
// MARK: - Selectors
extension HomeCell {
    @objc func increaseQuantity() {
        delegate?.increaseQuantity(in: self)
    }
    @objc func decreaseQuantity() {
        delegate?.decreaseQuantity(in: self)
    }
    @objc func addToBasket() {
        guard let data = food else { return}
        let basket = Basket(sepet_yemek_id: data.yemek_id
                            ,yemek_adi: data.yemek_adi
                            ,yemek_resim_adi: data.yemek_resim_adi
                            ,yemek_fiyat: data.yemek_fiyat
                            ,yemek_siparis_adet: quantityLabel.text ?? "1"
                            ,kullanici_adi: "Guven")
        delegate?.addToBasket(in: self,item: basket)
    }
}

