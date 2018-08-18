//
//  CycleTableViewCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

public class CycleTableViewCell: UITableViewCell, XCycleViewDelegate {
    @IBOutlet var cycleView: XCycleView!
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var showMoneyRangeLabel: UILabel!
    private var min: CGFloat = 0.0
    private var max: CGFloat = 0.0
    private var ges1: UITapGestureRecognizer?
    private var ges2: UITapGestureRecognizer?
    private var ges3: UITapGestureRecognizer?

    override public func awakeFromNib() {
        super.awakeFromNib()
        cycleView.cycleViewDelegate = self
        selectionStyle = UITableViewCellSelectionStyle.none
        // 接口
        self.min = 500
        self.max = 2000
        //
        self.moneyLabel.text = "0元"
        self.moneyLabel.font = UIFont.systemFont(ofSize: 20)
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

// MARK: 回调
    public func ratioChange(_ ratio: CGFloat) {
        //传给你比例!
        self.moneyLabel.text = String(format: "%.0f元", ratio * max)
        if ratio >= 0.95 {
            self.moneyLabel.text = String(format: "%.0f元", 1 * max)
        }
    }
}
