//
//  Layout.swift
//  tvtest
//
//  Created by Richard Adem on 13/1/18.
//  Copyright © 2018 Richard Adem. All rights reserved.
//

import UIKit

class Layout: UICollectionViewFlowLayout {
    
    var layoutInfo = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        itemSize = CGSize(width: 200, height: 150)
        estimatedItemSize = itemSize
        scrollDirection = .horizontal
        headerReferenceSize = CGSize.zero
        footerReferenceSize = CGSize.zero
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else {
            return
        }
        
        var cellLayoutInfo = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
        
        let sectionCount = collectionView.numberOfSections
        for section in 0...sectionCount-1 {
            let itemCount = collectionView.numberOfItems(inSection: section)
            
            for item in 0...itemCount-1 {
                let indexPath = IndexPath(item: item, section: section)
                let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                
                itemAttributes.frame = CGRect(x: CGFloat(200 * indexPath.item), y: 0, width: itemSize.width, height: itemSize.height)
                
                cellLayoutInfo[indexPath] = itemAttributes
            }
        }
        
        layoutInfo = cellLayoutInfo
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes = Array<UICollectionViewLayoutAttributes>()
        
        let focusedCell = self.collectionView?.focusedCell
        
        for (indexPath, attributes) in layoutInfo {
            if rect.intersects(attributes.frame) {
                
                
                if let focusedCell = focusedCell {
                    
                    guard let focusedCellIndexPath = self.collectionView?.focusedCellIndexPath else {
                        break
                    }
                    if focusedCellIndexPath == indexPath {
                        attributes.size = CGSize(width: 300, height: 225)
                    } else {
                        attributes.size = CGSize(width: 200, height: 150)
                        if attributes.center.x < focusedCell.center.x {
                            attributes.center.x -= 50
                        } else if attributes.center.x > focusedCell.center.x {
                            attributes.center.x += 50
                        }
                    }
                }
                
                allAttributes.append(attributes)
            }
        }
        
        
        
        return allAttributes
    }
    }

extension UICollectionView {
    var focusedCell: UICollectionViewCell? {
        guard let focusedCell = UIScreen.main.focusedView as? UICollectionViewCell else {
            return nil
        }
        guard indexPath(for: focusedCell) != nil else {
            return nil
        }
        return focusedCell
    }
    
    var focusedCellIndexPath: IndexPath? {
        guard let focusedCell = UIScreen.main.focusedView as? UICollectionViewCell else {
            return nil
        }
        guard let indexPath = indexPath(for: focusedCell) else {
            return nil
        }
        return indexPath
    }
}
