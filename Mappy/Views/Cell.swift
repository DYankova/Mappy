//
//  Cell.swift
//  Mappy
//
//  Created by Didi on 18.02.20.
//  Copyright © 2020 DroneSense. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var leftButton: UIButton = {
        let btn = UIButton()
        if let image = UIImage(named: "left-arrow") {
            btn.setImage(image, for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var rightButton: UIButton = {
        let btn = UIButton()
        if let image = UIImage(named: "right-arrow") {
            btn.setImage(image, for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
     lazy var leftView: UIView = {
         let view = UIView()
         view.backgroundColor = Constants.gray
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     lazy var coordView: UILabel = {
         let label = UILabel()
         label.text = "Previous selected"
         label.textColor = Constants.textColor
         label.numberOfLines = 3
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private func setupViews() {
        addSubview(coordView)
        addSubview(leftButton)
        addSubview(rightButton)

        coordView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.buttonSize).isActive = true
        coordView.widthAnchor.constraint(equalToConstant: Constants.coordViewLength).isActive = true
        coordView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true

        leftButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.viewHeight/2 ).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize ).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        
        rightButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.viewHeight/2 ).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        rightButton.leadingAnchor.constraint(equalTo: coordView.trailingAnchor, constant: -Constants.padding).isActive = true    
    }
}
