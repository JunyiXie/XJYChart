//
//  XJYViewController.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit

public class XJYViewController : UIViewController {
    // tell UIKit that you are using AutoLayout
    class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // this is Apple's recommended place for adding/updating constraints
    override public func updateViewConstraints() {
        super.updateViewConstraints()
    }
}
