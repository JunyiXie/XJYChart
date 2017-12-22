//
//  HomeTwoTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 22/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "PieChartCell.h"
#import <XJYChart/XChart.h>
@interface PieChartCell ()

@property(nonatomic, strong) XPieChart* pieChartView;

@end

@implementation PieChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.pieChartView = [[XPieChart alloc] init];
    NSMutableArray* pieItems = [[NSMutableArray alloc] init];

    NSArray* colorArray = @[
      RGB(145, 235, 253), RGB(198, 255, 150), RGB(254, 248, 150),
      RGB(253, 210, 147)
    ];

    NSArray* dataArray = @[ @"iPhone6", @"iPhone6 Plus", @"iPhone6s", @"其"
                                                                      @"他" ];
    XPieItem* item1 =
        [[XPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:20.9]
                                       color:colorArray[0]
                                dataDescribe:dataArray[0]];
    [pieItems addObject:item1];
    XPieItem* item2 =
        [[XPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:14.82]
                                       color:colorArray[1]
                                dataDescribe:dataArray[1]];
    [pieItems addObject:item2];
    XPieItem* item3 =
        [[XPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:13.43]
                                       color:colorArray[2]
                                dataDescribe:dataArray[2]];
    [pieItems addObject:item3];
    XPieItem* item4 =
        [[XPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:52]
                                       color:colorArray[3]
                                dataDescribe:dataArray[3]];
    [pieItems addObject:item4];

    //设置dataItemArray
    self.pieChartView.dataItemArray = pieItems;
    self.pieChartView.descriptionTextColor = [UIColor black25PercentColor];
    
    self.pieChartView.frame = CGRectMake(5, 5, 365, 190);

    [self.contentView addSubview:self.pieChartView];
  }

  return self;
}

- (UIColor*)randomColor {
  CGFloat red = arc4random() / (CGFloat)INT_MAX;

  CGFloat green = arc4random() / (CGFloat)INT_MAX;

  CGFloat blue = arc4random() / (CGFloat)INT_MAX;

  return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
