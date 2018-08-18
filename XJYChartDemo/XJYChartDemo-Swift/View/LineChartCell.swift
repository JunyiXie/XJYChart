//
//  LineChartCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

class LineChartCell :UITableViewCell {
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
        var numbersArray = [[Int32]]()
        //点的数据
        for _ in 0..<2 {
            var numberArray = [Int32]()
            for _ in 0..<5 {
                let num: Int = Int(XRandomNumerHelper.shareRandomNumber().randomNumberSmallThan(14)) * Int(XRandomNumerHelper.shareRandomNumber().randomNumberSmallThan(14))
                let number = Int32(num)
                numberArray.append(number)
            }
            numbersArray.append(numberArray)
        }
        let colorArray = [UIColor.teal(), UIColor.brickRed(), UIColor.babyBlue(), UIColor.banana(), UIColor.orchid()]
        for i in 0..<2 {
            let item = XLineChartItem(dataNumber: NSMutableArray(array: numbersArray[i]), color: colorArray[i])
            itemArray.append(item!)
        }
        let configuration = XNormalLineChartConfiguration()
        configuration.lineMode = XLineMode.CurveLine
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: 375, height: 200), dataItemArray: NSMutableArray(array: itemArray), dataDiscribeArray: ["January", "February", "March", "April", "May"], topNumber: 240, bottomNumber: 0, graphMode: XLineGraphMode.MutiLineGraph, chartConfiguration: configuration)
        contentView.addSubview(lineChart!)
        selectionStyle = UITableViewCellSelectionStyle.none
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
