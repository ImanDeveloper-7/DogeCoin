//
//  ViewController.swift
//  DogeCoin
//
//  Created by Iman Zabihi on 19/05/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(DogeTableViewCell.self, forCellReuseIdentifier: DogeTableViewCell.identifier)
        return tableView
    }()
    
    var data: DogeCoineData?
    
    private var viewModels = [DogeTableViewCellViewMode]()
    
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFractionalSeconds
        formatter.timeZone = .current
        return formatter
    }()
    
    static let prettyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DogeCoin"
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getDogeCoinData {[weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                DispatchQueue.main.async {
                    self?.setUpViewModels()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpViewModels() {
        guard let model = data else { return }
        guard let date = Self.dateFormatter.date(from: model.date_added) else { return }
        viewModels = [
            DogeTableViewCellViewMode(title: "Name", value: model.name),
            DogeTableViewCellViewMode(title: "Symbol", value: model.symbol),
            DogeTableViewCellViewMode(title: "Identifier", value: String(model.id)),
            DogeTableViewCellViewMode(title: "Date Added", value: Self.prettyDateFormatter.string(from: date)),
            DogeTableViewCellViewMode(title: "Total Supply", value: String(model.total_supply))
        ]
        setUpTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        createTableHeader()
    }
    
    private func createTableHeader() {
        guard let price = data?.quote["USD"]?.price else {
            return
        }
        // ImageView
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/3))
        header.clipsToBounds = true
        let imageView = UIImageView(image: UIImage(named: "dogecoin"))
        imageView.contentMode = .scaleAspectFit
        let size: CGFloat = view.frame.size.width/4
        imageView.frame = CGRect(x: (view.frame.size.width-size)/2, y: 60, width: size, height: size)
        header.addSubview(imageView)
        // Price
        let number = NSNumber(value: price)
        let string = Self.formatter.string(from: number)
        let label = UILabel()
        label.text = string
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 42, weight: .medium)
        label.frame = CGRect(x: 10, y: 20+size, width: view.frame.size.width-20, height: 200)
        header.addSubview(label)
        tableView.tableHeaderView = header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DogeTableViewCell.identifier, for: indexPath) as? DogeTableViewCell else { fatalError() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}

