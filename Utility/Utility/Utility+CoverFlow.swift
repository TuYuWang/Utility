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
        return 2
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
    case coverFlowCell(UICollectionViewCell)
    case text([UIColor])
    case `default`
    
}

enum CoverFlowBackground: String {
    case item1
    case item2
    case item3
    case item4
    
    var image: UIImage? {
        return rawValue.ul.img
    }
}

//
//extension Collection where Iterator.Element == Configuration {
//    func lastMatchIgnoringAssociatedValue(_ target: Iterator.Element) -> Iterator.Element? {
//        return reversed().first { $0 +== target }
//    }
//}
//
//extension Collection where Iterator.Element == Configuration {
//
//     var coverFlowView: UICollectionViewCell {
//        if let item = lastMatchIgnoringAssociatedValue(.coverFlowView(CoverFlowCell)), case .coverFlowView(let collectionView) = item {
//            return collectionView
//        }
//        return self.coverFlowView
//    }
//}
//
//precedencegroup ItemPrecedence {
//    associativity: none
//    higherThan: LogicalConjunctionPrecedence
//}
//
//infix operator +== : ItemPrecedence
//
//func +== (lhs: Configuration, rhs: Configuration) -> Bool {
//    switch (lhs, rhs) {
//    case (.coverFlowCell(_), .coverFlowCell(_)): return true
//    case (.text(_), .text(_)): return true
//    default: return false
//    }
//}

private var coverFlowKey: Void?

extension UIView: CoverFlowProtocol {
    
    var coverFlowView: UICollectionView {
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
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coverFlowCell", for: indexPath) as! CoverFlowCell
        cell.lab.text = "\(indexPath.row)"
        
        let images: [CoverFlowBackground] = [.item1, .item2, .item3, .item4]
        cell.backgroundImageView.image = images[indexPath.row].image
        
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

        let page = Int((targetContentOffset.pointee.x + frame.width/2) / pageWidth)
        
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
        let inset = base.coverFlowView.bounds.size.width / 2 - base.layout.itemSize.width / 2
        base.coverFlowView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset)
        
    }
}

// MARK: - Cell
class CoverFlowCell: UICollectionViewCell {
    
    var lab: UILabel!
    var backgroundImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        backgroundImageView = UIImageView()
        backgroundImageView.frame = bounds
        addSubview(backgroundImageView)
        
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
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        let attributes = NSArray(array: layoutAttributes, copyItems: true) as! [UICollectionViewLayoutAttributes]
        
        guard let collectionView = collectionView else { return attributes }

        let contentOffsetX = collectionView.contentOffset.x
        let collectionViewCenterX = collectionView.frame.width*0.5

        attributes.forEach({ (attribute) in
            var scale = 1 - fabs(attribute.center.x - contentOffsetX - collectionViewCenterX) / collectionView.frame.width
            scale = max(scale, 0.7)
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale*1.5)
            let red = 240/255*scale
            let green = 151/255*scale
            let blue = 56/255*scale
            let font = 36+16*scale

            let cell = collectionView.cellForItem(at: attribute.indexPath)
            cell?.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)

        })

        
        return attributes
    }
  
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
