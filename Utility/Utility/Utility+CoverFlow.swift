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
        return 7
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

extension UIView: CoverFlowProtocol {
    
    var coverFlowView: UICollectionView {
        
        let coverFlowView = UICollectionView(frame:bounds, collectionViewLayout: layout)
        coverFlowView.register(CoverFlowCell.self, forCellWithReuseIdentifier: "coverFlowCell")
        coverFlowView.backgroundColor = .white
        coverFlowView.delegate = self
        coverFlowView.dataSource = self
        coverFlowView.showsHorizontalScrollIndicator = false
        
//        coverFlowView.contentInset = UIEdgeInsetsMake(0, CGFloat(3*pageWidth)-layout.itemSize.width/2, 0, CGFloat(3*pageWidth)-layout.itemSize.width/2)
        return coverFlowView
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
        
        let cell = collectionView.cellForItem(at: indexPath)
        let cellCenter = cell!.center.x
        let convertCell = collectionView.convert(CGPoint(x: cellCenter, y: 0), to: self)
        
        var idx = CGPoint(x: convertCell.x - center.x, y: 0)
        idx = CGPoint(x: collectionView.contentOffset.x + idx.x, y: 0)
        collectionView.setContentOffset(idx, animated: true)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let page = roundf(Float(targetContentOffset.pointee.x / pageWidth))
//        let targetX = Float(pageWidth) * page
//        targetContentOffset.pointee.x = CGFloat(targetX)
        
//        let x_collectionView = scrollView.convert(targetContentOffset.pointee, to: coverFlowView)
//
//        let point = CGPoint(x: targetContentOffset.pointee.x, y: targetContentOffset.pointee.y)
        
//        let indexPath = coverFlowView.indexPathForItem(at: x_collectionView)
//        coverFlowView.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: true)
//        var centerCell: CoverFlowCell
//        for item in coverFlowView.visibleCells {
//            let covertFrame = coverFlowView.convert(CGPoint.init(x: item.center.x, y: 0), to: self)
//            
//            
//        }
//        
        

    }
    
}

// MARK: Utility
extension Utility where Base: UIView {
    
    func add(coverflow count: Int = 0, cofiguration: Configuration? = .default) {
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
