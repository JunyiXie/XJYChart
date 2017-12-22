//
//  StackAreaTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 11/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "StackAreaTableViewCell.h"
#import <XJYChart/XChart.h>
@implementation StackAreaTableViewCell

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

//    NSMutableArray* numbersArray = [NSMutableArray new];
    
    NSMutableArray* numbersArray= @[
                                    @[@45,@73,@155,@72,@53],
                                    @[@88,@97,@245,@166,@99],
                                    @[@81,@112,@133,@111,@90],
                                    ];

    NSArray* colorArray = @[
      [UIColor blueberryColor], [UIColor pastelGreenColor], [UIColor dangerColor],

    ];

    for (int i = 0; i < 3; i++) {
      XLineChartItem* item =
          [[XLineChartItem alloc] initWithDataNumberArray:numbersArray[i]
                                                    color:colorArray[i]];
      [itemArray addObject:item];
    }
    XNormalLineChartConfiguration* configuration =
        [[XNormalLineChartConfiguration alloc] init];
    configuration.lineMode = CurveLine;

    XLineChart* lineChart =
        [[XLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200)
                            dataItemArray:itemArray
                        dataDiscribeArray:[NSMutableArray arrayWithArray:@[
                          @"January", @"February", @"March", @"April", @"May"
                        ]]
                                topNumber:@750
                             bottomNumber:@0
                                graphMode:StackAreaLineGraph
                       chartConfiguration:configuration];
    [self.contentView addSubview:lineChart];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}
@end
