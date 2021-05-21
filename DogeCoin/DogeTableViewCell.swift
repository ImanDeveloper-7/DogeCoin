//
//  DogeTableViewCell.swift
//  DogeCoin
//
//  Created by Iman Zabihi on 20/05/2021.
//

import UIKit

struct DogeTableViewCellViewMode {
    let title: String
    let value: String
}

class DogeTableViewCell: UITableViewCell {
    static let identifier = "DogeTableViewCell"
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(valueLabel)
        contentView.addSubview(titlelabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titlelabel.sizeToFit()
        valueLabel.sizeToFit()
        
        titlelabel.frame = CGRect(x: 15, y: 0, width: titlelabel.frame.size.width, height: contentView.frame.size.height)
        valueLabel.frame = CGRect(x: contentView.frame.size.width - 15 - valueLabel.frame.size.width, y: 0, width: valueLabel.frame.size.width, height: contentView.frame.size.height)
    }
    
    func configure(with viewModel: DogeTableViewCellViewMode) {
        titlelabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
