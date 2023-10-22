//
//  BasketViewController.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 16.10.2023.
//

import UIKit

private let reuseBasketCellIdentifier = "BasketCell"
final class BasketViewController: UICollectionViewController {
    // MARK: - Properties
    var basketVM = BasketViewModel()
    
    private let totalPriceContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "container")?.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    private let totalLabel: UILabel = {
       let label = UILabel()
        label.text = "Toplam :"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let totalPriceLabel: UILabel = {
       let label = UILabel()
        label.text = "50 TL"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let conformBasketButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sepet Onayla", for: .normal)
        button.backgroundColor = UIColor(named: "button")
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
   private var totalPriceStackView: UIStackView!
    
    // MARK: - Lifecycle
     init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
         style()
         layout()
     }
    override func viewWillAppear(_ animated: Bool) {
        getBasketItems()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    // MARK: - Helpers
extension BasketViewController {
    private func style() {
        view.backgroundColor = .white
        collectionView.register(BasketCell.self, forCellWithReuseIdentifier: reuseBasketCellIdentifier)
        totalPriceStackView = UIStackView(arrangedSubviews: [totalLabel,totalPriceLabel])
        totalPriceStackView.axis = .horizontal
        totalPriceStackView.spacing = 170
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        totalPriceContainerView.translatesAutoresizingMaskIntoConstraints = false
        super.collectionView!.translatesAutoresizingMaskIntoConstraints = false
        conformBasketButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
       totalPriceContainerView.addSubview(totalPriceStackView)
       view.addSubview(totalPriceContainerView)
        view.addSubview(conformBasketButton)
        NSLayoutConstraint.activate([
            totalPriceStackView.centerYAnchor.constraint(equalTo: totalPriceContainerView.centerYAnchor),
            totalPriceStackView.leadingAnchor.constraint(equalTo: totalPriceContainerView.leadingAnchor, constant: 24),
            totalPriceContainerView.heightAnchor.constraint(equalToConstant: 35),
            totalPriceContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -130),
            totalPriceContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            totalPriceContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            super.collectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            super.collectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            super.collectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            super.collectionView!.bottomAnchor.constraint(equalTo: totalPriceContainerView.topAnchor,constant: -8),
            conformBasketButton.topAnchor.constraint(equalTo: totalPriceContainerView.bottomAnchor, constant: 8),
            conformBasketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            conformBasketButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            conformBasketButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    private func calculateTotalprice() {
        let totalPrice = basketVM.basketFoods?.compactMap { item in
            if let price = Int(item.yemek_fiyat ?? "0"), let quantity = Int(item.yemek_siparis_adet ?? "0") {
                return price * quantity
            }
            return nil
        }.reduce(0, +)
        totalPriceLabel.text = "\(totalPrice ?? 0)₺"
    }
    private func getBasketItems() {
        basketVM.getBasketFoods { [weak self] basket in
            if basket != nil {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                self?.calculateTotalprice()
            }
        }
    }
}
// MARK: - UICollectionViewDatasource
extension BasketViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let basketList = basketVM.basketFoods else { return 0}
        return basketList.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseBasketCellIdentifier, for: indexPath) as! BasketCell
        cell.basketItem = basketVM.basketFoods?[indexPath.row]
        cell.delegate = self
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       getBasketItems()
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension BasketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 155)
    }
}
// MARK: - BasketCellProtocol
extension BasketViewController: BasketCellProtocol {
    func deleteFromBasket( id: Int) {
        basketVM.deleteFromBasket(id: id)
        getBasketItems()
        basketVM.addToFirebase(id: id)
    }
}
