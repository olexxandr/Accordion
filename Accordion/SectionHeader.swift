//
//  SectionHeader.swift
//  Accordion
//
//  Created by asirotenko on 12/14/16.
//  Copyright © 2016 asirotenko. All rights reserved.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var img_down: UIImageView!
    
    @IBOutlet weak var img_right: UIImageView!
    
    func toggleSectionArrow(sectionIsVisible: Bool) -> Void {
        if (sectionIsVisible) {
            self.img_down.isHidden = false
            self.img_right.isHidden = true
        } else {
            self.img_down.isHidden = true
            self.img_right.isHidden = false
        }
    }
    
}
