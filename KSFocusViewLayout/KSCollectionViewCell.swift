//
//  KSCollectionViewCell.swift
//  KSFocusViewLayout
//
//  Created by Kenichi Saito on 11/21/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit

class KSCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let featuredHeight: CGFloat = 280
        let standardHeight: CGFloat = 100
        let delta: CGFloat = 1 - ((featuredHeight - CGRectGetHeight(self.frame)) / (featuredHeight - standardHeight))
        let scale: CGFloat = max(delta, 0.5)
        
        self.titleLabel.transform = CGAffineTransformMakeScale(scale, scale)
        self.descriptionLabel.alpha = delta
    }

}
