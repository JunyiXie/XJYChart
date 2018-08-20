//
//  HomeViewController.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import Masonry
import UIKit
import XJYChart

public class HomeViewController: XJYViewController, UITableViewDelegate, UITableViewDataSource {
    override public func viewDidLoad() {
        super.viewDidLoad()
        title = "XJYChart"
        automaticallyAdjustsScrollViewInsets = false
        if let aView = tableView {
            view.addSubview(aView)
        }
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // tell UIKit that you are using AutoLayout
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override public func updateViewConstraints() {
        _ = tableView?.mas_makeConstraints({ make in
            _ = make?.top.equalTo()(self.view.mas_top)?.offset()(64)
            _ = make?.left.equalTo()(self.view.mas_left)?.offset()(0)
            _ = make?.right.equalTo()(self.view.mas_right)?.offset()(0)
            _ = make?.bottom.equalTo()(self.view.mas_bottom)?.offset()(0)
        })
        super.updateViewConstraints()
    }

    private var _tableView: UITableView?
    private var tableView: UITableView? {
        get {
            if _tableView == nil {
                _tableView = UITableView()
                //        _tableView.backgroundColor = [UIColor colorWithRed:235/255.0
                //        green:235/255.0 blue:235/255.0 alpha:1];
                // MARK: Register Cell
                _tableView?.register(PieChartCell.self, forCellReuseIdentifier: Constants.kPieChartCell)
                _tableView?.register(BarChartCell.self, forCellReuseIdentifier: Constants.kBarChartCell)
                _tableView?.register(LineChartCell.self, forCellReuseIdentifier: Constants.kLineChartCell)
                _tableView?.register(PositiveNegativeBarChartCell.self, forCellReuseIdentifier: Constants.kPositiveNegativeBarChartCell)
                _tableView?.register(UINib(nibName: "CycleTableViewCell", bundle: nil), forCellReuseIdentifier: "CycleTableViewCell")
                _tableView?.register(AreaLineTableViewCell.self, forCellReuseIdentifier: Constants.kAreaLineTableViewCell)
                _tableView?.register(StackAreaTableViewCell.self, forCellReuseIdentifier: Constants.kStackAreaTableViewCell)
                _tableView?.register(SingleLineChartTableViewCell.self, forCellReuseIdentifier: Constants.kSingleLineChartCell)
                _tableView?.dataSource = self
                _tableView?.delegate = self
            }
            return _tableView
        }
    }
    private var _leftBarItem: UIBarButtonItem?
    private var leftBarItem: UIBarButtonItem? {
        get {
            if _leftBarItem == nil {
                _leftBarItem = UIBarButtonItem(image: UIImage(named: "settings-Small.png"), style: .done, target: self, action: nil)
            }
            return _leftBarItem
        }
    }
    private var _rightBarItem: UIBarButtonItem?
    private var rightBarItem: UIBarButtonItem? {
        get {
            if _rightBarItem == nil {
                _rightBarItem = UIBarButtonItem(image: UIImage(named: "add-Small.png"), style: .done, target: self, action: nil)
            }
            return _rightBarItem
        }
    }
    
    // MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.kAreaLineTableViewCell, for: indexPath)
            if let aCell = cell {
                return aCell
            }
            return UITableViewCell()
        } else if indexPath.section == 1 {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.kSingleLineChartCell, for: indexPath)
            if let aCell = cell {
                return aCell
            }
            return UITableViewCell()
        } else if indexPath.section == 2 {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.kBarChartCell, for: indexPath)
            if let aCell = cell {
                return aCell
            }
            return UITableViewCell()
        } else if indexPath.section == 3 {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.kPositiveNegativeBarChartCell, for: indexPath)
            if let aCell = cell {
                return aCell
            }
            return UITableViewCell()
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kCycleTableViewCell, for: indexPath) as? CycleTableViewCell
            if let aCell = cell {
                return aCell
            }
            return UITableViewCell()
        } else if indexPath.section == 5 {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.kLineChartCell, for: indexPath)
            if let aCell = cell {
                return aCell
            }
            return UITableViewCell()
        } else if indexPath.section == 6 {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.kStackAreaTableViewCell, for: indexPath)
            if let aCell = cell {
                return aCell
            }
            return UITableViewCell()
        } else if indexPath.section == 7 {
            let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.kPieChartCell, for: indexPath)
            if let aCell = cell {
                return aCell
            }
            return UITableViewCell()
        }
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constants.kPositiveNegativeBarChartCell, for: indexPath)
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Area Line Chart"
        } else if section == 1 {
            return "Line Chart"
        } else if section == 2 {
            return "Bar Chart"
        } else if section == 3 {
            return "Bar Chart2"
        } else if section == 4 {
            return "Cycle Chart"
        } else if section == 5 {
            return "Line Chart2"
        } else if section == 6 {
            return "Area Line Chart2"
        } else if section == 7 {
            return "Pie Chart"
        } else {
            return ""
        }
    }
    
    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 350
        } else {
            return 200
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}

