//
//  ColorListView.swift
//  Color
//
//  Created by Dima on 01.06.2023.
//

import UIKit

final class ColorListView: UIView {

    // MARK: - Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Helper.Text.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func configureStyle() {
        backgroundColor = Helper.Color.mainWhite
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 20
        addSubview(tableView)
    }
}

// MARK: - Extension
extension ColorListView {
    func setupConstraints() {
        let constant: CGFloat = 20
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: constant),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant)
        ])
    }
}
