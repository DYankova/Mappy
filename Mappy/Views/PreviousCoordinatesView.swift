//
//  PreviousCoordinatesView.swift
//  Mappy
//
//  Created by Didi on 18.02.20.
//  Copyright © 2020 DroneSense. All rights reserved.
//

import UIKit

class PreviousCoordinatesView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        GlobalVar.previousCoordinates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.backgroundColor = Constants.gray
        if GlobalVar.previousCoordinates.count >= 1 {
            let reversedNames : [LocationViewModel] = Array(GlobalVar.previousCoordinates.reversed())
            cell.coordView.text = reversedNames[indexPath.item].previousCoordinateText
        }
        cell.leftButton.addTarget(self, action: #selector(moveToNextCoord), for: .touchUpInside)
        cell.rightButton.addTarget(self, action: #selector(moveToPreviousCoord), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: self.collectionView.frame.size.width , height: self.collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc private func moveToPreviousCoord(_ sender: Any) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }

     @objc private func moveToNextCoord(_ sender: Any) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }

    private func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupCollectionView(){
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
