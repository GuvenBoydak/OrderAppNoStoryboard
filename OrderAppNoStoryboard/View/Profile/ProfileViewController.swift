//
//  ProfileViewController.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 16.10.2023.
//

import UIKit

private let reuseProfileCell = "ProfileCell"
final class ProfileViewController: UICollectionViewController {
    // MARK: - Properties
    var profileVM = ProfileViewModel()
    
    private let segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: [Status.added.rawValue,Status.deleted.rawValue,Status.favorited.rawValue])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    private let foodNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Yemek Adi"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        return label
    }()
    private let foodPriceLabel: UILabel = {
        let label = UILabel()
         label.text = "Fiyat"
         label.font = UIFont.systemFont(ofSize: 20)
         label.textColor = .lightGray
         return label
    }()
    private let foodStatusLabel: UILabel = {
        let label = UILabel()
         label.text = "Durum"
         label.font = UIFont.systemFont(ofSize: 20)
         label.textColor = .lightGray
         return label
    }()   
    var fullStackView: UIStackView!
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        filterActivity()
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        style()
        layout()
        segmentControl.addTarget(self, action: #selector(filterActivity), for: .valueChanged)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    // MARK: - Helpers
extension ProfileViewController {
    private func style() {
        view.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: reuseProfileCell)
        fullStackView = UIStackView(arrangedSubviews: [foodNameLabel,foodPriceLabel,foodStatusLabel])
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        foodPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        foodStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        fullStackView.axis = .horizontal
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        view.addSubview(segmentControl)
        view.addSubview(fullStackView)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fullStackView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor,constant: 4),
            foodNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            foodPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 170),
            foodStatusLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor,constant: -110),
            collectionView.topAnchor.constraint(equalTo: fullStackView.bottomAnchor, constant: 6),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
// MARK: - UICollectionViewDatasource
extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileVM.numberOfItems()
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseProfileCell, for: indexPath) as! ProfileCell
        cell.activity = profileVM.activities[indexPath.row]
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
}
// MARK: - Selectors
extension ProfileViewController {
    @objc private func filterActivity() {
        let selectedIndex = segmentControl.selectedSegmentIndex
        switch selectedIndex {
        case 0 :
            profileVM.filterActivity(filter: Status.added.rawValue)
        case 1 :
            profileVM.filterActivity(filter: Status.deleted.rawValue)
        default :
            profileVM.filterActivity(filter: Status.favorited.rawValue)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


