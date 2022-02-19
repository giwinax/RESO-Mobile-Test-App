//
//  TableViewCell.swift
//  RESO Moblie Test App
//
//  Created by s b on 18.02.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let name = UILabel()
    let address = UILabel()
    var state = UILabel()
    var distance = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        //self.name
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        
        name.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 14)
        name.textColor = .black
        name.font = .boldSystemFont(ofSize: 14)
        
        
        address.frame = CGRect(x: 0, y: 0, width: self.bounds.width , height: 12)
        address.textColor = .lightGray
        address.font = .systemFont(ofSize: 12)
        address.preferredMaxLayoutWidth = self.bounds.width / 5 * 4
        address.numberOfLines = 2
        address.lineBreakMode = .byWordWrapping
        address.sizeToFit()
        
        state.frame = CGRect(x: 0, y: 0, width: 5, height: 12)
        if state.text == "Открыт" {
            state.textColor = UIColor(red: 35/255, green: 128/255, blue: 63/255, alpha: 1.0)
        } else {
            state.textColor = .red
        }
        state.font = .systemFont(ofSize: 12)
        
        distance.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 12)
        distance.textColor = .lightGray
        distance.font = .systemFont(ofSize: 12)
        
        let buttomCellStack = UIStackView(arrangedSubviews: [state,distance])
        buttomCellStack.axis = .horizontal
        buttomCellStack.distribution = .fillProportionally
        buttomCellStack.alignment = .firstBaseline
        buttomCellStack.spacing = 3
        buttomCellStack.translatesAutoresizingMaskIntoConstraints = false
        
        let buttomCellStackView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        buttomCellStackView.addSubview(buttomCellStack)
        
        let textStack = UIStackView(arrangedSubviews: [name,address,buttomCellStackView])
        textStack.axis = .vertical
        textStack.distribution = .fill
        textStack.alignment = .fill
        textStack.spacing = 3
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let textStackHorizontalPadding = UIStackView(arrangedSubviews: [leftPadding,textStack,rightPadding])
        textStackHorizontalPadding.axis = .horizontal
        textStackHorizontalPadding.distribution = .fill
        textStackHorizontalPadding.alignment = .fill
        textStackHorizontalPadding.spacing = 7
        textStackHorizontalPadding.translatesAutoresizingMaskIntoConstraints = false
        
        let topPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let buttomPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let finalStack = UIStackView(arrangedSubviews: [topPadding,textStackHorizontalPadding,buttomPadding])
        finalStack.axis = .vertical
        finalStack.distribution = .fill
        finalStack.alignment = .fill
        finalStack.spacing = 7
        finalStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(finalStack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
