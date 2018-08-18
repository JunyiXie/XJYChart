//
//  HomeFourTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 15/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "BarChartCell.h"
#import <XJYChart/XJYChart.h>
@interface BarChartCell ()<XJYChartDelegate>

@end

@implementation BarChartCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    NSMutableArray* itemArray = [[NSMutableArray alloc] init];

    UIColor* waveColor = [UIColor waveColor];

    XBarItem* item1 = [[XBarItem alloc] initWithDataNumber:@(50.93)
                                                     color:waveColor
                                              dataDescribe:@"macOS"];
    [itemArray addObject:item1];
    XBarItem* item2 = [[XBarItem alloc] initWithDataNumber:@(90.04)
                                                     color:waveColor
                                              dataDescribe:@"Win10"];
    [itemArray addObject:item2];
    XBarItem* item3 = [[XBarItem alloc] initWithDataNumber:@(80.99)
                                                     color:waveColor
                                              dataDescribe:@"Win8"];
    [itemArray addObject:item3];
    XBarItem* item4 = [[XBarItem alloc] initWithDataNumber:@(110.48)
                                                     color:waveColor
                                              dataDescribe:@"WinXP"];
    [itemArray addObject:item4];
    XBarItem* item5 = [[XBarItem alloc] initWithDataNumber:@(92.91)
                                                     color:waveColor
                                              dataDescribe:@"Win7"];
    [itemArray addObject:item5];

    XBarItem* item6 = [[XBarItem alloc] initWithDataNumber:@(74.93)
                                                     color:waveColor
                                              dataDescribe:@"macOS"];
    [itemArray addObject:item6];
    XBarItem* item7 = [[XBarItem alloc] initWithDataNumber:@(50.04)
                                                     color:waveColor
                                              dataDescribe:@"Win10"];
    [itemArray addObject:item7];
    XBarItem* item8 = [[XBarItem alloc] initWithDataNumber:@(44.99)
                                                     color:waveColor
                                              dataDescribe:@"Win8"];
    [itemArray addObject:item8];
    XBarItem* item9 = [[XBarItem alloc] initWithDataNumber:@(28.48)
                                                     color:waveColor
                                              dataDescribe:@"WinXP"];
    [itemArray addObject:item9];
    XBarItem* item10 = [[XBarItem alloc] initWithDataNumber:@(52.91)
                                                      color:waveColor
                                               dataDescribe:@"Win7"];
    [itemArray addObject:item10];
    //
    XBarItem* item11 = [[XBarItem alloc] initWithDataNumber:@(10.93)
                                                      color:waveColor
                                               dataDescribe:@"macOS"];
    [itemArray addObject:item11];
    XBarItem* item12 = [[XBarItem alloc] initWithDataNumber:@(17.04)
                                                      color:waveColor
                                               dataDescribe:@"Win10"];
    [itemArray addObject:item12];
    XBarItem* item13 = [[XBarItem alloc] initWithDataNumber:@(14.99)
                                                      color:waveColor
                                               dataDescribe:@"Win8"];
    [itemArray addObject:item13];

    XBarChartConfiguration *configuration = [XBarChartConfiguration new];
    configuration.isScrollable = NO;
    configuration.x_width = 20;
    XBarChart* barChart =
        [[XBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200)
                           dataItemArray:itemArray
                               topNumber:@150
                            bottomNumber:@(0)
                      chartConfiguration:configuration];
    barChart.barChartDelegate = self;
    [self.contentView addSubview:barChart];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

#pragma mark XBarChartDelegate

- (void)userClickedOnBarAtIndex:(NSInteger)idx {
  NSLog(@"XBarChartDelegate touch Bat At idx %lu", idx);
}
@end
