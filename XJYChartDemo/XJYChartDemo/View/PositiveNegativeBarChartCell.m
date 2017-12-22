//
//  HomeSixTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/04/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "PositiveNegativeBarChartCell.h"
#import <XJYChart/XChart.h>
@interface PositiveNegativeBarChartCell ()<XPNBarChartDelegate>

@end
@implementation PositiveNegativeBarChartCell

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
    XBarItem* item1 = [[XBarItem alloc] initWithDataNumber:@(-80.93)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item1];
    XBarItem* item2 = [[XBarItem alloc] initWithDataNumber:@(-107.04)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item2];
    XBarItem* item3 = [[XBarItem alloc] initWithDataNumber:@(77.99)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item3];
    XBarItem* item4 = [[XBarItem alloc] initWithDataNumber:@(57.48)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item4];
    XBarItem* item5 = [[XBarItem alloc] initWithDataNumber:@(-89.91)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item5];

    XBarItem* item6 = [[XBarItem alloc] initWithDataNumber:@(66.93)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item6];
    XBarItem* item7 = [[XBarItem alloc] initWithDataNumber:@(7.04)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item7];
    XBarItem* item8 = [[XBarItem alloc] initWithDataNumber:@(-77.99)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item8];
    XBarItem* item9 = [[XBarItem alloc] initWithDataNumber:@(-28.48)
                                                     color:XJYDarkBlue
                                              dataDescribe:@"test"];
    [itemArray addObject:item9];
    XBarItem* item10 = [[XBarItem alloc] initWithDataNumber:@(52.91)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item10];
    //
    XBarItem* item11 = [[XBarItem alloc] initWithDataNumber:@(-0.93)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item11];
    XBarItem* item12 = [[XBarItem alloc] initWithDataNumber:@(-7.04)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item12];
    XBarItem* item13 = [[XBarItem alloc] initWithDataNumber:@(44.99)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item13];
    XBarItem* item14 = [[XBarItem alloc] initWithDataNumber:@(28.48)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item14];
    XBarItem* item15 = [[XBarItem alloc] initWithDataNumber:@(-52.91)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item15];

    XBarItem* item16 = [[XBarItem alloc] initWithDataNumber:@(0.93)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item16];
    XBarItem* item17 = [[XBarItem alloc] initWithDataNumber:@(77.04)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item17];
    XBarItem* item18 = [[XBarItem alloc] initWithDataNumber:@(4.99)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item18];
    XBarItem* item19 = [[XBarItem alloc] initWithDataNumber:@(-28.48)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item19];
    XBarItem* item20 = [[XBarItem alloc] initWithDataNumber:@(52.91)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item20];

    XBarItem* item21 = [[XBarItem alloc] initWithDataNumber:@(0.93)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item21];
    XBarItem* item22 = [[XBarItem alloc] initWithDataNumber:@(7.04)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item22];
    XBarItem* item23 = [[XBarItem alloc] initWithDataNumber:@(4.99)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item23];
    XBarItem* item24 = [[XBarItem alloc] initWithDataNumber:@(44.48)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item24];
    XBarItem* item25 = [[XBarItem alloc] initWithDataNumber:@(52.91)
                                                      color:XJYDarkBlue
                                               dataDescribe:@"test"];
    [itemArray addObject:item25];

    XPositiveNegativeBarChart* barChart = [[XPositiveNegativeBarChart alloc]
        initWithFrame:CGRectMake(0, 0, 375, 200)
        dataItemArray:itemArray
            topNumber:@100
         bottomNumber:@(-170)];
    barChart.barChartDeleagte = self;
    [self.contentView addSubview:barChart];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

- (void)touchBarAtIdx:(NSUInteger)idx {
  NSLog(@"XBarChartDelegate touch Bat At idx %lu", idx);
}
@end
