//
//  TableCell.swift
//  DemoToDo
//
//  Created by Azizbek Abdulkhakimov on 10/01/24.
//

import UIKit
import Stevia

class TableCell: UITableViewCell {
    var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView() {
        contentView.subviews(titleLabel)
        
        titleLabel
            .centerVertically()
            .left(8)
    }
}
