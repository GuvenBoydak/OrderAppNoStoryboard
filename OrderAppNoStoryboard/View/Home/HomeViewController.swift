//
//  HomeViewController.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 18.10.2023.
//
import UIKit


private let reuseHomeCellIdentifier = "HomeCell"
final class HomeViewController: UICollectionViewController {
// MARK: - Properties
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Yemek Ara"
        return search
    }()
    let homeVM = HomeViewModel()
// MARK: - Lifecycle
     init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
         style()
         layout()
         homeVM.fetchFoods() { [weak self] response,error in
             if error != nil {
                 print(error?.localizedDescription ?? "")
             }
             if let data = response,!data.isEmpty {
                 DispatchQueue.main.async {
                     self?.collectionView.reloadData()
                 }
             }
         }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension HomeViewController {
    private func style() {
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: reuseHomeCellIdentifier)
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    private func layout() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
// MARK: - UICollectionViewDataSource
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeVM.numberOfRows()
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseHomeCellIdentifier, for: indexPath) as! HomeCell
        cell.food = homeVM.foods[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.food = homeVM.foods[indexPath.row]
        self.present(detailVC, animated: true, completion: nil)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 10) / 2
        return .init(width: cellWidth - 10, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width - 10, height: 160)
    }
}
// MARK: - HomeCellProtocol
extension HomeViewController: HomeCellProtocol {
    func addToBasket(in cell: HomeCell,item: Basket) {
        homeVM.addToBasket(item: item)
        homeVM.addToFirebase(item: item)
    }
    func increaseQuantity(in cell: HomeCell) {
        if let text = cell.quantityLabel.text, var quantity = Int(text) {
            quantity += 1
            cell.quantityLabel.text = String(quantity)
        }
    }
    func decreaseQuantity(in cell: HomeCell) {
        if let text = cell.quantityLabel.text, var quantity = Int(text), quantity > 1 {
            quantity -= 1
            cell.quantityLabel.text = String(quantity)
        }
    }
}


