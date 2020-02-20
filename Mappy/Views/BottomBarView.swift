//
//  BottomBarView.swift
//  Mappy
//
//  Created by Didi on 17.02.20.
//  Copyright © 2020 DroneSense. All rights reserved.
//

import UIKit

class BottomBarView: UIView , UIScrollViewDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var previousCoordView : PreviousCoordinatesView  = {
        let view = PreviousCoordinatesView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var currentCoordView: UILabel = {
        let textView = UILabel()
        textView.text = "Select location"
        textView.textColor = .white
        textView.numberOfLines = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var rightView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setup(){
        addSubview(leftView)
        leftView.bringSubviewToFront(currentCoordView)
        leftView.addSubview(currentCoordView)
        
        addSubview(rightView)
        rightView.addSubview(previousCoordView)

        leftView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: Constants.viewWidth).isActive = true
        currentCoordView.heightAnchor.constraint(equalToConstant: 85).isActive = true

        rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 0).isActive = true
        rightView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        rightView.bringSubviewToFront(previousCoordView)
        
        previousCoordView.leadingAnchor.constraint(equalTo: rightView.leadingAnchor).isActive = true
        previousCoordView.trailingAnchor.constraint(equalTo: rightView.trailingAnchor).isActive = true
        previousCoordView.topAnchor.constraint(equalTo: rightView.topAnchor).isActive = true
        previousCoordView.bottomAnchor.constraint(equalTo: rightView.bottomAnchor).isActive = true
    }
       
}
