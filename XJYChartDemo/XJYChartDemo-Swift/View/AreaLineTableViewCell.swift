//
//  AreaLineTableViewCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

class AreaLineTableViewCell : UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        var itemArray: [AnyHashable] = []
        let numberArray = [75, 63, 183, 109, 88]
        let item = XLineChartItem(dataNumber: NSMutableArray(array:numberArray), color: Constants.XJYWhite)
        itemArray.append(item!)
        let configuration = XAreaLineChartConfiguration()
        configuration.isShowPoint = true
        configuration.lineMode = XLineMode.CurveLine
        configuration.ordinateDenominator = 6
            //    configuration.isEnableNumberLabel = YES;
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: 375, height: 200), dataItemArray: NSMutableArray(array: itemArray), dataDiscribeArray: ["January", "February", "March", "April", "May"], topNumber: 240, bottomNumber: 0, graphMode: XLineGraphMode.AreaLineGraph, chartConfiguration: nil)
        contentView.addSubview(lineChart!)
        selectionStyle = UITableViewCellSelectionStyle.none
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
