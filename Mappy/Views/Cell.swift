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
//            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            btn.setImage(image, for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var rightButton: UIButton = {
        let btn = UIButton()
        if let image = UIImage(named: "right-arrow") {
//            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            btn.setImage(image, for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
     var leftView: UIView = {
         let view = UIView()
         view.backgroundColor = .lightGray
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     var coordView: UILabel = {
         let textView = UILabel()
         textView.text = "Previous selected"
         textView.textColor = .white
         textView.numberOfLines = 3
         textView.translatesAutoresizingMaskIntoConstraints = false
         return textView
     }()
    
    func setupViews() {
        addSubview(coordView)
        addSubview(leftButton)
        addSubview(rightButton)

        coordView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        coordView.widthAnchor.constraint(equalToConstant: 120 ).isActive = true
        coordView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true

        leftButton.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 15 ).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 15 ).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        
        rightButton.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 15 ).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 15 ).isActive = true
        rightButton.leadingAnchor.constraint(equalTo: coordView.trailingAnchor, constant: -20).isActive = true
        
        
    }
}
