//
//  Utility+CoverFlow.swift
//  Utility
//
//  Created by 涂育旺 on 2018/1/16.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

// MARK: CoverFlowProtocol
protocol CoverFlowProtocol {
    var count: Int { get }
    var coverFlowView: UICollectionView { get }
    var frame: CGRect { get }
    var layout: CoverFlowLayout { get }
}

extension CoverFlowProtocol {
    
    var count: Int {
        return 5
    }
    
    var frame: CGRect {
        return UIScreen.main.bounds
    }
    
    var layout: CoverFlowLayout {
        let layout = CoverFlowLayout()
        let width = UIScreen.main.bounds.width/CGFloat(count)
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
    
}

enum CoverFlowView {
    case view
    case image
    case text([UIColor])
}

extension UIView: CoverFlowProtocol {
    
    var coverFlowView: UICollectionView {
        
        let coverFlowView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coverFlowView.register(CoverFlowCell.self, forCellWithReuseIdentifier: "coverFlowCell")
        coverFlowView.backgroundColor = .white
        coverFlowView.delegate = self
        coverFlowView.dataSource = self
        coverFlowView.showsHorizontalScrollIndicator = false
        return coverFlowView
    }
}

extension UIView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coverFlowCell", for: indexPath)
        return cell
    }
    
    
}

// MARK: Utility
extension Utility where Base: UIView {
    
    func add(coverflow count: Int = 0) {
        base.coverFlowView.frame = base.bounds
        base.addSubview(base.coverFlowView)
    }
    
    
}

// MARK: - Cell
class CoverFlowCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        let lab = UILabel()
        lab.frame = self.bounds
        lab.text = "aaa"
        lab.textAlignment = .center
        addSubview(lab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Layout
class CoverFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        scrollDirection = .horizontal
        return super.layoutAttributesForElements(in: rect)
    }
    
}
