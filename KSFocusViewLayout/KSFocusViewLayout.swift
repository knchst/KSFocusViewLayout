//
//  KSFocusViewLayout.swift
//  KSFocusViewLayout
//
//  Created by Kenichi Saito on 11/18/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit

class KSFocusViewLayout: UICollectionViewLayout {
    
    var standardHeight: CGFloat = 0.0
    var focusedHeight: CGFloat = 0.0
    var dragOffset: CGFloat = 0.0
    
    var cachedLayoutAttributes: Array<UICollectionViewLayoutAttributes>!
    
    // Default Params
    let kKSFocusViewLayoutStandardHeight: CGFloat = 100.0
    let kKSFocusViewLayoutFocusedHeight: CGFloat = 280.0
    let kKSFocusViewLayoutDragOffset: CGFloat = 180.0

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        initializer()
    }
    
    func initializer() {
        standardHeight = kKSFocusViewLayoutStandardHeight
        focusedHeight = kKSFocusViewLayoutFocusedHeight
        dragOffset = kKSFocusViewLayoutDragOffset
    }
    
    override func collectionViewContentSize() -> CGSize {
        let numberOfItems = self.collectionView?.numberOfItemsInSection(0)
        let contentHeight = CGFloat(numberOfItems!) * dragOffset + (self.collectionView!.frame.size.height - dragOffset)
        
        return CGSizeMake(self.collectionView!.frame.size.width, contentHeight)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let proposedItemIndex = roundf(Float(proposedContentOffset.y / dragOffset))
        let nearestPageOffset = CGFloat(proposedItemIndex) * dragOffset
        
        return CGPointMake(0.0, nearestPageOffset)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]?()
        
        for attributes in cachedLayoutAttributes {
            if (CGRectIntersectsRect(attributes.frame, rect)) {
                layoutAttributes?.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override func prepareLayout() {
        var cache = [UICollectionViewLayoutAttributes]()
        let numberOfItems = self.collectionView?.numberOfItemsInSection(0)
        var frame = CGRectZero
        var y: CGFloat = 0.0
        
        for (var item = 0; item < numberOfItems; item++) {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            attributes.zIndex = item
            
            var height = standardHeight
            
            if (indexPath.item == _currentFocusedItemIndex()) {
                let yOffset = standardHeight * _nextItemPercentageOffset()
                y = self.collectionView!.contentOffset.y - yOffset
                height = self.focusedHeight
            } else if (indexPath.item == (_currentFocusedItemIndex() + 1) && indexPath.item != numberOfItems) {
                let maxY = y + standardHeight
                height = standardHeight + max((focusedHeight - standardHeight) * _nextItemPercentageOffset(), 0)
                y = maxY - height
            } else {
                y = frame.origin.y + frame.size.height
            }
            
            frame = CGRectMake(0, y, self.collectionView!.frame.size.width, height);
            attributes.frame = frame;
            cache.append(attributes)
            y = CGRectGetMaxY(frame)
        }
        
        cachedLayoutAttributes = cache
    }
    
    private func _currentFocusedItemIndex() -> Int {
        return max(0, Int(self.collectionView!.contentOffset.y / dragOffset))
    }
    
    private func _nextItemPercentageOffset() -> CGFloat {
        return (self.collectionView!.contentOffset.y / dragOffset) - CGFloat(_currentFocusedItemIndex())
    }
}
