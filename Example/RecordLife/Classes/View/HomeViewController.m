//
//  HomeViewController.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeOneTableViewCell.h"
#import "HomeTwoTableViewCell.h"
#import "HomeThreeTableViewCell.h"
#import "HomeFourTableViewCell.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;

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
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    [super updateViewConstraints];
}



#pragma mark Lazy Loading

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
//        _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
#pragma mark Register Cell
        [_tableView registerClass:[HomeOneTableViewCell class] forCellReuseIdentifier:kHomeOneTableViewCell];
        [_tableView registerClass:[HomeTwoTableViewCell class] forCellReuseIdentifier:kHomeTwoTableViewCell];
        [_tableView registerClass:[HomeThreeTableViewCell class] forCellReuseIdentifier:kHomeThreeTableViewCell];
        [_tableView registerClass:[HomeFourTableViewCell class] forCellReuseIdentifier:kHomeFourTableViewCell];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIBarButtonItem *)leftBarItem {
    if (!_leftBarItem) {
        _leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings-Small.png"] style:UIBarButtonItemStyleDone target:self  action:nil];
    }
    return _leftBarItem;
}

- (UIBarButtonItem *)rightBarItem {
    if (!_rightBarItem) {
        _rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add-Small.png"] style:UIBarButtonItemStyleDone target:self  action:nil];
    }
    return _rightBarItem;
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeOneTableViewCell forIndexPath:indexPath];
        return cell;

    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeTwoTableViewCell forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeThreeTableViewCell forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeFourTableViewCell forIndexPath:indexPath];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeOneTableViewCell forIndexPath:indexPath];
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"折线图";
    } else if (section == 1) {
        return @"饼图";
    } else if (section == 2){
        return @"条形图";
    } else {
        return @"新条形图";
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

@end
