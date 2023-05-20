//
//  DessertListViewController.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/17.
//

import UIKit
import SnapKit

class DessertListViewController: UIViewController {
        
    private let viewModel = DessertListViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.register(DessertListCell.self, forCellWithReuseIdentifier: "DessertListCell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        bindersSetup()
        viewModel.fetchDessertListData()
    }
}

extension DessertListViewController {
    private func viewSetup() {
        title = "TheMealDB Dessert List"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindersSetup() {
        viewModel.dessertList.bind { value in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension DessertListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dessertList.value?.meals.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DessertListCell", for: indexPath)
        if let bodyCell = cell as? DessertListCell {
            let dessert = viewModel.dessertList.value?.meals[indexPath.row]
            bodyCell.cellSetup(viewModel: DessertListCellViewModel(dessertImage: dessert?.strMealThumb ?? "", dessertName: dessert?.strMeal ?? "", dessertId: dessert?.idMeal ?? ""))
            return bodyCell
        }
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 15) / 2
        return CGSize(width: width , height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionCell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.15) {
            collectionCell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { (Bool) in
            UIView.animate(withDuration: 0.15) {
                collectionCell?.transform = .identity
            }
        }
        
        if let currCell = collectionCell as? DessertListCell {
            let DessertDetailVC = DessertDetailViewController(viewModel: DessertDetailViewModel(dessertImage: currCell.getDessertImage()!, dessertName: currCell.getDessertName(), dessertId: currCell.getDessertId()))
            navigationController?.pushViewController(DessertDetailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let collectionCell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.15) {
            collectionCell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let collectionCell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.15) {
            collectionCell?.transform = .identity
        }
    }
}
