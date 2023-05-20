//
//  DessertListCell.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import UIKit
import SnapKit

class DessertListCell: UICollectionViewCell {
    
    private var viewModel = DessertListCellViewModel() {
        didSet {
            dessertImage.loadImage(imageURL: URL(string: viewModel.dessertImage)!)
            dessertName.text = viewModel.dessertName
        }
    }
    
    private var dessertImage = UIImageView {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    private var dessertName = UILabel {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        $0.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dessertImage.image = nil
    }
    
    public func cellSetup(viewModel: DessertListCellViewModel) {
        self.viewModel = viewModel
    }
    
    public func getDessertId() -> String {
        return viewModel.dessertId
    }
    
    public func getDessertImage() -> UIImage? {
        return dessertImage.image
    }
    
    public func getDessertName() -> String {
        return dessertName.text!
    }
}

extension DessertListCell {
    private func viewSetup() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 3
        
        contentView.addSubview(dessertImage)
        dessertImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.addSubview(dessertName)
        dessertName.snp.makeConstraints {
            $0.leading.trailing.equalTo(dessertImage).offset(2)
            $0.bottom.equalTo(dessertImage.snp.bottom)
        }
    }
}
