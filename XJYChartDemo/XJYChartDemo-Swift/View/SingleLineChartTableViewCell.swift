//
//  SingleLineChartTableViewCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

class SingleLineChartTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

            // XJYChart init Design for muti line
            // So @[oneitem] draw one line
        let numberArray = [120, 80, 160, 120, 150]
        let item = XLineChartItem(dataNumber: NSMutableArray(array: numberArray), color: UIColor.salmon())
        let configuration = XNormalLineChartConfiguration()
        configuration.isShowShadow = false
            //    configuration.isEnableNumberLabel = YES;
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: 375, height: 200), dataItemArray: [item as Any], dataDiscribeArray: ["January", "February", "March", "April", "May"], topNumber: 240, bottomNumber: 0, graphMode: XLineGraphMode.MutiLineGraph, chartConfiguration: configuration)
        contentView.addSubview(lineChart!)
        selectionStyle = UITableViewCellSelectionStyle.none
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
