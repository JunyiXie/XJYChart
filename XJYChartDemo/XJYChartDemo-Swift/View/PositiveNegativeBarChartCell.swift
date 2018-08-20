//
//  PositiveNegativeBarChartCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

class PositiveNegativeBarChartCell: UITableViewCell, XJYChartDelegate {
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
        let item1 = XBarItem(dataNumber: -80.93, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item1!)
        let item2 = XBarItem(dataNumber: -107.04, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item2!)
        let item3 = XBarItem(dataNumber: 77.99, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item3!)
        let item4 = XBarItem(dataNumber: 57.48, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item4!)
        let item5 = XBarItem(dataNumber: -89.91, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item5!)
        let item6 = XBarItem(dataNumber: 66.93, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item6!)
        let item7 = XBarItem(dataNumber: 7.04, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item7!)
        let item8 = XBarItem(dataNumber: -77.99, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item8!)
        let item9 = XBarItem(dataNumber: -28.48, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item9!)
        let item10 = XBarItem(dataNumber: 52.91, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item10!)
            //
        let item11 = XBarItem(dataNumber: -0.93, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item11!)
        let item12 = XBarItem(dataNumber: -7.04, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item12!)
        let item13 = XBarItem(dataNumber: 44.99, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item13!)
        let item14 = XBarItem(dataNumber: 28.48, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item14!)
        let item15 = XBarItem(dataNumber: -52.91, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item15!)
        let item16 = XBarItem(dataNumber: 0.93, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item16!)
        let item17 = XBarItem(dataNumber: 77.04, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item17!)
        let item18 = XBarItem(dataNumber: 4.99, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item18!)
        let item19 = XBarItem(dataNumber: -28.48, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item19!)
        let item20 = XBarItem(dataNumber: 52.91, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item20!)
        let item21 = XBarItem(dataNumber: 0.93, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item21!)
        let item22 = XBarItem(dataNumber: 7.04, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item22!)
        let item23 = XBarItem(dataNumber: 4.99, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item23!)
        let item24 = XBarItem(dataNumber: 44.48, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item24!)
        let item25 = XBarItem(dataNumber: 52.91, color: Constants.XJYDarkBlue, dataDescribe: "test")
        itemArray.append(item25!)
        let barChart = XPositiveNegativeBarChart(frame: CGRect(x: 0, y: 0, width: 375, height: 200), dataItemArray: NSMutableArray(array: itemArray), topNumber: 100, bottomNumber: -170)
        barChart!.barChartDelegate = self
        contentView.addSubview(barChart!)
        selectionStyle = UITableViewCellSelectionStyle.none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func userClickedOnBar(at idx: Int) {
        print("XBarChartDelegate touch Bat At idx \(idx)")
    }
}
