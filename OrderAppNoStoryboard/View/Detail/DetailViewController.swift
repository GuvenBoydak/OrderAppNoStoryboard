//
//  DetailViewController.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 18.10.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Properties
    var food: Food? {
        didSet { configure() }
    }
    var detailVM = DetailViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ürün Detay"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .lightGray
        return label
    }()
    private let closeViewButton: UIButton = {
       let buttton = UIButton()
        buttton.setImage(UIImage(systemName:"xmark"), for: .normal)
        buttton.tintColor = .black
        return buttton
    }()
    private let addToFavoriteButton: UIButton = {
       let buttton = UIButton()
        buttton.setImage(UIImage(systemName:"star"), for: .normal)
        buttton.tintColor = .black
        return buttton
    }()
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
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    private let appImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pizza")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Ayran"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
         label.text = "6 TL"
         label.font = UIFont.boldSystemFont(ofSize: 20)
         return label
     }()
    private let addToBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 12
        return button
    }()
    private let totalContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        return view
    }()
    private let totalLabel: UILabel = {
        let label = UILabel()
         label.text = "Toplam :"
        label.textColor = .black
         label.font = UIFont.boldSystemFont(ofSize: 24)
         return label
    }()
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
         label.text = "10 TL"
        label.textColor = .black
         label.font = UIFont.boldSystemFont(ofSize: 20)
         return label
    }()
    var totalStackView: UIStackView!
    var quantityStackView: UIStackView!
    var namePriceLabelStackView: UIStackView!
    var topStackView: UIStackView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        view.backgroundColor = .white
        decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        increaseQuantityButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        closeViewButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        addToFavoriteButton.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        addToBasketButton.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
    }
}
    // MARK: - Helpers
extension DetailViewController {
    private func style() {
        totalStackView = UIStackView(arrangedSubviews: [totalLabel,totalPriceLabel])
        totalStackView.axis = .horizontal
        totalStackView.spacing = 30
        totalStackView.alignment = .center
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        totalContainerView.translatesAutoresizingMaskIntoConstraints = false
        addToBasketButton.translatesAutoresizingMaskIntoConstraints = false
        quantityStackView = UIStackView(arrangedSubviews: [increaseQuantityButton,quantityLabel,decreaseQuantityButton])
        quantityStackView.axis = .horizontal
        quantityStackView.spacing = 25
        quantityStackView.translatesAutoresizingMaskIntoConstraints = false
        namePriceLabelStackView = UIStackView(arrangedSubviews: [nameLabel,priceLabel])
        namePriceLabelStackView.axis = .vertical
        namePriceLabelStackView.spacing = 24
        namePriceLabelStackView.alignment = .center
        namePriceLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        appImage.translatesAutoresizingMaskIntoConstraints = false
        topStackView = UIStackView(arrangedSubviews: [closeViewButton,titleLabel,addToFavoriteButton])
        topStackView.spacing = 90
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout() {
        totalContainerView.addSubview(totalStackView)
        view.addSubview(totalContainerView)
        view.addSubview(addToBasketButton)
        view.addSubview(quantityStackView)
        view.addSubview(namePriceLabelStackView)
        view.addSubview(appImage)
        view.addSubview(topStackView)
        NSLayoutConstraint.activate([
            totalContainerView.heightAnchor.constraint(equalToConstant: 40),
            totalContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -200),
            totalContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 75),
            totalContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -75),
            totalStackView.centerXAnchor.constraint(equalTo: totalContainerView.centerXAnchor),
            totalStackView.topAnchor.constraint(equalTo: totalContainerView.topAnchor, constant: 4),
            addToBasketButton.topAnchor.constraint(equalTo: totalContainerView.bottomAnchor,constant: 30),
            addToBasketButton.centerXAnchor.constraint(equalTo: totalContainerView.centerXAnchor),
            quantityStackView.bottomAnchor.constraint(equalTo: totalContainerView.topAnchor, constant: -40),
            quantityStackView.centerXAnchor.constraint(equalTo: totalContainerView.centerXAnchor),
            namePriceLabelStackView.centerXAnchor.constraint(equalTo: totalContainerView.centerXAnchor),
            namePriceLabelStackView.bottomAnchor.constraint(equalTo: quantityStackView.topAnchor, constant: -40),
            appImage.heightAnchor.constraint(equalToConstant: 200),
            appImage.widthAnchor.constraint(equalToConstant: 200),
            appImage.centerXAnchor.constraint(equalTo: totalContainerView.centerXAnchor),
            appImage.bottomAnchor.constraint(equalTo: namePriceLabelStackView.topAnchor,constant: -55),
            addToBasketButton.widthAnchor.constraint(equalToConstant: 200),
            topStackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 24),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
        ])
    }
    private func configure() {
        guard let data = food else { return }
        appImage.setImage(fromURL: "\(URL_IMAGE)\(data.yemek_resim_adi)")
        nameLabel.text = data.yemek_adi
        priceLabel.text = "\(data.yemek_fiyat) ₺"
        setTotalPrice()
    }
    private func setTotalPrice(){
        guard let quantity = Int(quantityLabel.text ?? "0"),let price = Int(food?.yemek_fiyat ?? "0") else { return }
        totalPriceLabel.text = "\(price * quantity) ₺"
    }
}
// MARK: Selectors
extension DetailViewController {
    @objc private func increaseQuantity() {
        guard var quantity = Int(quantityLabel.text ?? "0") else { return }
        quantity += 1
        quantityLabel.text = String(quantity)
        setTotalPrice()
    }
    @objc private func decreaseQuantity() {
        guard var quantity = Int(quantityLabel.text ?? "0"),quantity > 1 else { return }
        quantity -= 1
        quantityLabel.text = String(quantity)
        setTotalPrice()
    }
    @objc private func closePage() {
        self.dismiss(animated: true)
    }
    @objc private func addToFavorite() {
        guard let data = food else {return}
        detailVM.addToFavorite(food: data)
    }
    @objc private func addToBasket() {
        guard let data = food else {return}
        let basket = Basket(sepet_yemek_id: food?.yemek_id ?? "",
                            yemek_adi: food?.yemek_adi ?? "",
                            yemek_resim_adi: food?.yemek_resim_adi ?? "",
                            yemek_fiyat: food?.yemek_fiyat ?? "",
                            yemek_siparis_adet: quantityLabel.text ?? "",
                            kullanici_adi: "Guven")
        detailVM.addToBasket(item: basket)
        detailVM.addBasketToFirebase(item: basket)
    }
}
