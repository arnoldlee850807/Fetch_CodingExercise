//
//  DessertDetailImageCell.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import UIKit
import SnapKit

class DessertDetailImageCell: UITableViewCell {
    
    private lazy var dessertImageView = UIImageView {
        $0.contentMode = .scaleAspectFill
    }
    private lazy var dessertNameLabel = UILabel {
        $0.text = ""
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.semibold)
    }
    
    public func cellSetup(image: UIImage, name: String) {
        dessertImageView.image = image
        dessertNameLabel.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DessertDetailImageCell {
    private func viewSetup() {
        selectionStyle = .none
        backgroundColor = .white
                
        contentView.addSubview(dessertImageView)
        dessertImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview()
        }
        dessertImageView.layoutIfNeeded()
        dessertImageView.layer.masksToBounds = true
        dessertImageView.layer.cornerRadius = 7
        
        contentView.addSubview(dessertNameLabel)
        dessertNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(dessertImageView.snp.bottom).inset(15)
            $0.leading.trailing.equalToSuperview().inset(35)
        }
    }
}
