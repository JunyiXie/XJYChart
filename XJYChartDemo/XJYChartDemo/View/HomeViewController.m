//
//  HomeViewController.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "HomeViewController.h"
#import "PieChartCell.h"
#import "BarChartCell.h"
#import "LineChartCell.h"
#import "PositiveNegativeBarChartCell.h"
#import "CycleTableViewCell.h"
#import "AreaLineTableViewCell.h"
#import "StackAreaTableViewCell.h"
#import "SingleLineChartTableViewCell.h"

#import <Masonry/Masonry.h>
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) UIBarButtonItem* leftBarItem;
@property(nonatomic, strong) UIBarButtonItem* rightBarItem;

@end

@implementation HomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"XJYChart";
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self.view addSubview:self.tableView];
  self.navigationItem.leftBarButtonItem = self.leftBarItem;
  self.navigationItem.rightBarButtonItem = self.rightBarItem;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

- (void)updateViewConstraints {
  [_tableView mas_makeConstraints:^(MASConstraintMaker* make) {
    make.top.equalTo(self.view.mas_top).offset(64);
    make.left.equalTo(self.view.mas_left).offset(0);
    make.right.equalTo(self.view.mas_right).offset(0);
    make.bottom.equalTo(self.view.mas_bottom).offset(0);
  }];
  [super updateViewConstraints];
}

#pragma mark Lazy Loading
- (UITableView*)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] init];
//        _tableView.backgroundColor = [UIColor colorWithRed:235/255.0
//        green:235/255.0 blue:235/255.0 alpha:1];
#pragma mark Register Cell

    [_tableView registerClass:[PieChartCell class]
        forCellReuseIdentifier:kPieChartCell];

    [_tableView registerClass:[BarChartCell class]
        forCellReuseIdentifier:kBarChartCell];
    [_tableView registerClass:[LineChartCell class]
        forCellReuseIdentifier:kLineChartCell];
    [_tableView registerClass:[PositiveNegativeBarChartCell class]
        forCellReuseIdentifier:kPositiveNegativeBarChartCell];
    [_tableView registerNib:[UINib nibWithNibName:@"CycleTableViewCell"
                                           bundle:nil]
        forCellReuseIdentifier:@"CycleTableViewCell"];
    [_tableView registerClass:[AreaLineTableViewCell class]
        forCellReuseIdentifier:kAreaLineTableViewCell];
    [_tableView registerClass:[StackAreaTableViewCell class]
        forCellReuseIdentifier:kStackAreaTableViewCell];
    [_tableView registerClass:[SingleLineChartTableViewCell class]
        forCellReuseIdentifier:kSingleLineChartCell];

    _tableView.dataSource = self;
    _tableView.delegate = self;
  }
  return _tableView;
}

- (UIBarButtonItem*)leftBarItem {
  if (!_leftBarItem) {
    _leftBarItem = [[UIBarButtonItem alloc]
        initWithImage:[UIImage imageNamed:@"settings-Small.png"]
                style:UIBarButtonItemStyleDone
               target:self
               action:nil];
  }
  return _leftBarItem;
}

- (UIBarButtonItem*)rightBarItem {
  if (!_rightBarItem) {
    _rightBarItem = [[UIBarButtonItem alloc]
        initWithImage:[UIImage imageNamed:@"add-Small.png"]
                style:UIBarButtonItemStyleDone
               target:self
               action:nil];
  }
  return _rightBarItem;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return 8;
}

- (NSInteger)tableView:(UITableView*)tableView
    numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  if (indexPath.section == 0) {
    UITableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:kAreaLineTableViewCell
                                        forIndexPath:indexPath];
    return cell;

  } else if (indexPath.section == 1) {
    UITableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:kSingleLineChartCell
                                        forIndexPath:indexPath];
    return cell;

  } else if (indexPath.section == 2) {
    UITableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:kBarChartCell
                                        forIndexPath:indexPath];
    return cell;
  } else if (indexPath.section == 3) {
    UITableViewCell* cell = [tableView
        dequeueReusableCellWithIdentifier:kPositiveNegativeBarChartCell
                             forIndexPath:indexPath];
    return cell;
  } else if (indexPath.section == 4) {
    CycleTableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:kCycleTableViewCell
                                        forIndexPath:indexPath];
    return cell;
  } else if (indexPath.section == 5) {
    UITableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:kLineChartCell
                                        forIndexPath:indexPath];
    return cell;
  } else if (indexPath.section == 6) {
    UITableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:kStackAreaTableViewCell
                                        forIndexPath:indexPath];
    return cell;
  } else if (indexPath.section == 7) {
    UITableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:kPieChartCell
                                        forIndexPath:indexPath];
    return cell;
  }
  UITableViewCell* cell =
      [tableView dequeueReusableCellWithIdentifier:kPositiveNegativeBarChartCell
                                      forIndexPath:indexPath];
  return cell;
}

- (NSString*)tableView:(UITableView*)tableView
    titleForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return @"Area Line Chart";
  } else if (section == 1) {
    return @"Line Chart";
  } else if (section == 2) {
    return @"Bar Chart";
  } else if (section == 3) {
    return @"Bar Chart2";
  } else if (section == 4) {
    return @"Cycle Chart";
  } else if (section == 5) {
    return @"Line Chart2";
  } else if (section == 6) {
    return @"Area Line Chart2";
  } else if (section == 7) {
    return @"Pie Chart";
  } else {
    return @"";
  }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath {
  if (indexPath.section == 4) {
    return 350;
  } else {
    return 200;
  }
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForHeaderInSection:(NSInteger)section {
  return 25;
}


@end
