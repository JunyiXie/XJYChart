//
//  BarChartCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

class BarChartCell: UITableViewCell, XJYChartDelegate {
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
        let waveColor = UIColor.wave()
        let item1 = XBarItem(dataNumber: 50.93, color: waveColor, dataDescribe: "MAC Os")
        itemArray.append(item1!)
        let item2 = XBarItem(dataNumber: 90.04, color: waveColor, dataDescribe: "Win10")
        itemArray.append(item2!)
        let item3 = XBarItem(dataNumber: 80.99, color: waveColor, dataDescribe: "Win8")
        itemArray.append(item3!)
        let item4 = XBarItem(dataNumber: 110.48, color: waveColor, dataDescribe: "WinXP")
        itemArray.append(item4!)
        let item5 = XBarItem(dataNumber: 92.91, color: waveColor, dataDescribe: "Win7")
        itemArray.append(item5!)
        let item6 = XBarItem(dataNumber: 74.93, color: waveColor, dataDescribe: "MAC Os")
        itemArray.append(item6!)
        let item7 = XBarItem(dataNumber: 50.04, color: waveColor, dataDescribe: "Win10")
        itemArray.append(item7!)
        let item8 = XBarItem(dataNumber: 44.99, color: waveColor, dataDescribe: "Win8")
        itemArray.append(item8!)
        let item9 = XBarItem(dataNumber: 28.48, color: waveColor, dataDescribe: "WinXP")
        itemArray.append(item9!)
        let item10 = XBarItem(dataNumber: 52.91, color: waveColor, dataDescribe: "Win7")
        itemArray.append(item10!)
        //
        let item11 = XBarItem(dataNumber: 10.93, color: waveColor, dataDescribe: "MAC Os")
        itemArray.append(item11!)
        let item12 = XBarItem(dataNumber: 17.04, color: waveColor, dataDescribe: "Win10")
        itemArray.append(item12!)
        let item13 = XBarItem(dataNumber: 14.99, color: waveColor, dataDescribe: "Win8")
        itemArray.append(item13!)
        let configuration = XBarChartConfiguration()
        configuration.isScrollable = false
        configuration.x_width = 20
        let barChart = XBarChart(frame: CGRect(x: 0, y: 0, width: 375, height: 200), dataItemArray: NSMutableArray(array: itemArray), topNumber: 150, bottomNumber: 0, chartConfiguration: configuration)
        barChart!.barChartDelegate = self
        contentView.addSubview(barChart!)
        selectionStyle = UITableViewCellSelectionStyle.none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: XBarChartDelegate
    func userClickedOnBar(at idx: Int) {
        print("XBarChartDelegate touch Bat At idx \(idx)")
    }
}
