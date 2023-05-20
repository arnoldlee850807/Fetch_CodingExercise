//
//  DessertDetailTypeCell.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import UIKit
import SnapKit

class DessertDetailTypeCell: UITableViewCell {
    
    private lazy var categoryLabel = UILabel {
        $0.text = ""
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.semibold)
    }
    
    private lazy var areaLabel = UILabel {
        $0.text = ""
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.semibold)
    }
    
    private lazy var typeLabel = UILabel {
        $0.text = ""
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.semibold)
    }
    
    public func cellSetup(category: String, area: String, type: String) {
        categoryLabel.text = category != "" ? "Category: \(category)" : ""
        areaLabel.text = area != "" ? "Area: \(area)" : ""
        typeLabel.text = type != "" ? "Type: \(type)" : ""
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

extension DessertDetailTypeCell {
    private func viewSetup() {
        selectionStyle = .none
        backgroundColor = .white
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(30)
        }
        
        contentView.addSubview(areaLabel)
        areaLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(30)
        }
        
        contentView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(areaLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(30)
        }
    }
}
