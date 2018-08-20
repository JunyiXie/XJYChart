//
//  PieChartCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

class PieChartCell: XJYTableViewCell, XJYChartDelegate {
    private var pieChartView: XPieChart?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

            // change data button
        let controlButton = UIButton(frame: CGRect(x: 10, y: 10, width: 80, height: 40))
        controlButton.setTitle("改变数据", for: .normal)
        controlButton.setTitleColor(UIColor.black, for: .normal)
        controlButton.addTarget(self, action: #selector(PieChartCell.updateData), for: .touchUpInside)
        addSubview(controlButton)
        pieChartView = XPieChart()
        var pieItems: [AnyHashable] = []
        let colorArray = [Constants.RGB(145, 235, 253), Constants.RGB(198, 255, 150), Constants.RGB(254, 248, 150), Constants.RGB(253, 210, 147)]
        let dataArray = ["iPhone6", "iPhone6 Plus", "iPhone6s", "其\r他"]
        let item1 = XPieItem(dataNumber: 20.9, color: colorArray[0], dataDescribe: dataArray[0])
        pieItems.append(item1!)
        let item2 = XPieItem(dataNumber: 14.82, color: colorArray[1], dataDescribe: dataArray[1])
        pieItems.append(item2!)
        let item3 = XPieItem(dataNumber: 13.43, color: colorArray[2], dataDescribe: dataArray[2])
        pieItems.append(item3!)
        let item4 = XPieItem(dataNumber: 52, color: colorArray[3], dataDescribe: dataArray[3])
        pieItems.append(item4!)
        //设置dataItemArray
        pieChartView?.dataItemArray = NSMutableArray(array: pieItems)
        pieChartView?.descriptionTextColor = UIColor.black25Percent()
        pieChartView?.delegate = self
        pieChartView?.frame = CGRect(x: 50, y: 5, width: 300, height: 190)
        if let aView = pieChartView {
            contentView.addSubview(aView)
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomColor() -> UIColor? {
        let red = CGFloat(arc4random()) / CGFloat(INT_MAX)
        let green = CGFloat(arc4random()) / CGFloat(INT_MAX)
        let blue = CGFloat(arc4random()) / CGFloat(INT_MAX)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func userClicked(onPieIndexItem pieIndex: Int) {
        print("XBarChartDelegate touch Pie At idx \(pieIndex)")
    }
    
    // MARK: Change Data Simple
    @objc func updateData() {
        var pieItems: [AnyHashable] = []
        let colorArray = [Constants.RGB(145, 235, 253), Constants.RGB(198, 255, 150), Constants.RGB(254, 248, 150), Constants.RGB(253, 210, 147)]
        let dataArray = ["iPhone6", "iPhone6 Plus", "iPhone6s", "其\r他"]
        let item1 = XPieItem(dataNumber: 10.9, color: colorArray[0], dataDescribe: dataArray[0])
        pieItems.append(item1!)
        let item2 = XPieItem(dataNumber: 24.82, color: colorArray[1], dataDescribe: dataArray[1])
        pieItems.append(item2!)
        let item3 = XPieItem(dataNumber: 33.43, color: colorArray[2], dataDescribe: dataArray[2])
        pieItems.append(item3!)
        let item4 = XPieItem(dataNumber: 12, color: colorArray[3], dataDescribe: dataArray[3])
        pieItems.append(item4!)
        pieChartView?.dataItemArray = NSMutableArray(array: pieItems)
        pieChartView?.refreshChart()
    }
}
