//
//  XJYTableViewCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

class XJYTableViewCell : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //        self.backgroundColor = [UIColor colorWithRed:235/255.0
        //        green:235/255.0 blue:235/255.0 alpha:1];
        selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
