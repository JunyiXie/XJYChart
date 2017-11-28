//
//  CycleTableViewCell.h
//  RecordLife
//
//  Created by 谢俊逸 on 01/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJYTapCycleView.h"
#import <XJYChart/XChart.h>

static NSString *kCycleTableViewCell = @"CycleTableViewCell";

@interface CycleTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet XCycleView *cycleView;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;

//@property (strong, nonatomic) IBOutlet XJYTapCycleView *tap1;
//@property (strong, nonatomic) IBOutlet XJYTapCycleView *tap2;
//@property (strong, nonatomic) IBOutlet XJYTapCycleView *tap3;

@property (nonatomic, assign) CGFloat min;
@property (nonatomic, assign) CGFloat max;

@end
