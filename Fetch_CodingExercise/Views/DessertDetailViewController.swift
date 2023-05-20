//
//  DessertDetailViewController.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import UIKit
import SnapKit

class DessertDetailViewController: UIViewController {
    
    private var viewModel = DessertDetailViewModel()
    
    private lazy var tableView = UITableView {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = true
        $0.estimatedRowHeight = 85.0
        $0.rowHeight = UITableView.automaticDimension
        $0.delegate = self
        $0.dataSource = self
        $0.register(DessertDetailImageCell.self, forCellReuseIdentifier: "DessertDetailImageCell")
        $0.register(DessertDetailTypeCell.self, forCellReuseIdentifier: "DessertDetailTypeCell")
    }
    
    init(viewModel: DessertDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        bindersSetup()
        viewModel.fetchDessertData()
    }
}

extension DessertDetailViewController {
    private func viewSetup() {
        title = viewModel.dessertName
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindersSetup() {
        viewModel.dessertDetailList.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension DessertDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in _: UITableView) -> Int {
        return 4
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return viewModel.dessertDetailList.value?.meals.first?.materialDictionary.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 350
        } else if indexPath.section == 1 {
            return 90
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currDessertList = viewModel.dessertDetailList.value else { return UITableViewCell() }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DessertDetailImageCell", for: indexPath) as! DessertDetailImageCell
            cell.cellSetup(image: viewModel.dessertImage, name: viewModel.dessertName)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DessertDetailTypeCell", for: indexPath) as! DessertDetailTypeCell
            cell.cellSetup(category: currDessertList.meals.first!.strCategory ?? "", area: currDessertList.meals.first!.strArea ?? "", type: currDessertList.meals.first!.strTags ?? "")
            return cell
        } else if indexPath.section == 2 {
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel!.text = "Instructions:\n" + (currDessertList.meals.first!.strInstructions ?? "None")
            return cell
        } else if indexPath.section == 3 {
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            let curr = currDessertList.meals.first!.materialDictionary[indexPath.row+1]
            
            guard let ingredient = curr?.ingredient, let measure = curr?.measure else { return cell }
            cell.textLabel!.text = ingredient + ": " + measure
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
