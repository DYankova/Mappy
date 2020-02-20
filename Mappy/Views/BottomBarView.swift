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
        setupViews()
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
    
    lazy var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   lazy var currentCoordView: UILabel = {
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

    private func setupViews(){
        addSubview(leftView)
        leftView.addSubview(currentCoordView)
        
        addSubview(rightView)
        rightView.addSubview(previousCoordView)

        leftView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: Constants.viewHeight).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: Constants.viewWidth).isActive = true
        
        currentCoordView.heightAnchor.constraint(equalTo: leftView.heightAnchor).isActive = true

        rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor).isActive = true
        rightView.heightAnchor.constraint(equalTo: leftView.heightAnchor).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: 150).isActive = true
     
        previousCoordView.leadingAnchor.constraint(equalTo: rightView.leadingAnchor).isActive = true
        previousCoordView.trailingAnchor.constraint(equalTo: rightView.trailingAnchor).isActive = true
        previousCoordView.topAnchor.constraint(equalTo: rightView.topAnchor).isActive = true
        previousCoordView.bottomAnchor.constraint(equalTo: rightView.bottomAnchor).isActive = true
    }
       
}
