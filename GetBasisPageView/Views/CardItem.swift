
//
//  PageViewController.swift
//  GetBasisPageView
//
//  Created by Ramesh Madavaram on 22/09/20.
//  Copyright © 2020 Ramesh. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CardItem: UIView {
    static let CARD_ITEM_NIB = "CardItem"
    
    @IBOutlet var vwContent: UIView!
    @IBOutlet var vwBackground: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var progressLabel: UILabel!

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(titleText: String? = "", background: UIColor? = .red,progress:String? = "") {
        self.init()
        lblTitle.text = titleText
        lblTitle.backgroundColor = background
        progressLabel.text = progress
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CardItem.CARD_ITEM_NIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
    }
}
