//
//  VideoCell.swift
//  tvtest
//
//  Created by Richard Adem on 13/1/18.
//  Copyright © 2018 Richard Adem. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
            }, completion: nil)
            
        } else if context.previouslyFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.backgroundColor = UIColor.green.withAlphaComponent(0.2)
            }, completion: nil)
        }
    }
}
