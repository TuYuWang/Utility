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
    var layout: CoverFlowLayout { get }
    var pageWidth: CGFloat { get }
}

extension CoverFlowProtocol {
    
    var count: Int {
        return 8
    }
    
    var layout: CoverFlowLayout {
        let layout = CoverFlowLayout()
        let width = UIScreen.main.bounds.width/CGFloat(count)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 10
        return layout
    }
    
    var pageWidth: CGFloat {
        return layout.itemSize.width + layout.minimumLineSpacing
    }
}

enum Configuration {
    case view
    case image
    case text([UIColor])
    case `default`
    
}

private var coverFlowKey: Void?

extension UIView: CoverFlowProtocol {
    
    var coverFlowView: UICollectionView {
        
//        let coverFlowView = UICollectionView(frame:bounds, collectionViewLayout: layout)
//        coverFlowView.register(CoverFlowCell.self, forCellWithReuseIdentifier: "coverFlowCell")
//        coverFlowView.backgroundColor = .white
//        coverFlowView.delegate = self
//        coverFlowView.dataSource = self
//        coverFlowView.showsHorizontalScrollIndicator = false
//
////        coverFlowView.contentInset = UIEdgeInsetsMake(0, CGFloat(3*pageWidth)-layout.itemSize.width/2, 0, CGFloat(3*pageWidth)-layout.itemSize.width/2)
//        return coverFlowView
        
        set {
            objc_setAssociatedObject(self, &coverFlowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &coverFlowKey) as! UICollectionView
        }
    }
    

}

extension UIView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coverFlowCell", for: indexPath) as! CoverFlowCell
        cell.lab.text = "\(indexPath.row)"
    
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        let cellCenter = cell.center.x
        let convertCell = collectionView.convert(CGPoint(x: cellCenter, y: 0), to: self)
        
        var idx = CGPoint(x: convertCell.x - center.x, y: 0)
        idx = CGPoint(x: collectionView.contentOffset.x + idx.x, y: 0)
        collectionView.setContentOffset(idx, animated: true)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let page = Int(targetContentOffset.pointee.x / pageWidth)
        
        let targetIndexPath = IndexPath(row: page, section: 0)
        
        let targetCell = coverFlowView.dequeueReusableCell(withReuseIdentifier: "coverFlowCell", for: targetIndexPath)
        
        let convertCell = coverFlowView.convert(targetCell.center, to: self)
        
        var idxp = CGPoint(x: convertCell.x - center.x, y: 0)
        
        idxp = CGPoint(x: coverFlowView.contentOffset.x + idxp.x, y: 0)
        
        targetContentOffset.pointee.x = idxp.x
    
    }
    
}

// MARK: Utility
extension Utility where Base: UIView {
    
    func add(coverflow count: Int = 0, cofiguration: Configuration? = .default) {
       
        base.coverFlowView = UICollectionView(frame:base.bounds, collectionViewLayout: base.layout)
        base.coverFlowView.register(CoverFlowCell.self, forCellWithReuseIdentifier: "coverFlowCell")
        base.coverFlowView.backgroundColor = .white
        base.coverFlowView.delegate = base
        base.coverFlowView.dataSource = base
        base.coverFlowView.showsHorizontalScrollIndicator = false

        base.addSubview(base.coverFlowView)


    }
}

// MARK: - Cell
class CoverFlowCell: UICollectionViewCell {
    
    var lab: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        lab = UILabel()
        lab.frame = bounds
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
        let attributes = super.layoutAttributesForElements(in: rect)
        
//        guard let collectionView = collectionView else { return attributes }
//
//        let contentOffsetX = collectionView.contentOffset.x
//        let collectionViewCenterX = collectionView.frame.width*0.5
//
//        attributes?.forEach({ (attribute) in
//            var scale = 1 - fabs(attribute.center.x - contentOffsetX - collectionViewCenterX) / collectionView.frame.width
//            scale = max(scale, 0.7)
//            attribute.transform = CGAffineTransform(scaleX: scale, y: scale*1.5)
//            let red = 240/255*scale
//            let green = 151/255*scale
//            let blue = 56/255*scale
//            let font = 36+16*scale
//
//            let cell = collectionView.cellForItem(at: attribute.indexPath)
//            cell?.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
//
//        })

        
        return attributes
    }
  
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
