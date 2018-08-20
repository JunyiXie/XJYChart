//
//  StackAreaTableViewCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

class StackAreaTableViewCell :UITableViewCell {
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

        var itemArray: [AnyHashable] = []
            //    NSMutableArray* numbersArray = [NSMutableArray new];
        var numbersArray = [[45, 73, 155, 72, 53], [88, 97, 245, 166, 99], [81, 112, 133, 111, 90]]
        let colorArray = [UIColor.blueberry(), UIColor.pastelGreen(), UIColor.danger()]
        for i in 0..<3 {
            let item = XLineChartItem(dataNumber: NSMutableArray(array: numbersArray[i]), color: colorArray[i])
            itemArray.append(item!)
        }
        let configuration = XStackAreaLineChartConfiguration()
        configuration.lineMode = XLineMode.CurveLine
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: 375, height: 200), dataItemArray: NSMutableArray(array: itemArray), dataDiscribeArray: ["January", "February", "March", "April", "May"], topNumber: 750, bottomNumber: 0, graphMode: XLineGraphMode.StackAreaLineGraph, chartConfiguration: configuration)
        contentView.addSubview(lineChart!)
        selectionStyle = UITableViewCellSelectionStyle.none
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
