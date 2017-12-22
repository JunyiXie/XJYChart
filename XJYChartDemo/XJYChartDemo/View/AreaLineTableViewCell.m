//
//  AreaLineTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 09/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "AreaLineTableViewCell.h"

#import <XJYChart/XChart.h>
@implementation AreaLineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    NSMutableArray* itemArray = [[NSMutableArray alloc] init];

    NSMutableArray* numberArray = [NSMutableArray new];

    numberArray =
        [NSMutableArray arrayWithArray:@[ @75, @63, @183, @109, @88 ]];

    XLineChartItem* item =
        [[XLineChartItem alloc] initWithDataNumberArray:numberArray
                                                  color:XJYWhite];
    [itemArray addObject:item];

    XAreaLineChartConfiguration* configuration =
        [[XAreaLineChartConfiguration alloc] init];
    configuration.isShowPoint = YES;
    configuration.lineMode = CurveLine;
    XLineChart* lineChart =
        [[XLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200)
                            dataItemArray:itemArray
                        dataDiscribeArray:[NSMutableArray arrayWithArray:@[
                          @"January", @"February", @"March", @"April", @"May"
                        ]]
                                topNumber:@240
                             bottomNumber:@0
                                graphMode:AreaLineGraph
                       chartConfiguration:configuration];

    [self.contentView addSubview:lineChart];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

@end
