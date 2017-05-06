//
//  XJYViewController.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYViewController.h"

@interface XJYViewController ()

@end

@implementation XJYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// this is Apple's recommended place for adding/updating constraints
- (void)updateViewConstraints {
    [super updateViewConstraints];
}

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
@end
