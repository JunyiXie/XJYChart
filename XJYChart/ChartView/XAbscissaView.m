//
//  XAbscissaView.m
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAbscissaView.h"
#import "XJYChart.h"
#import "XAlignLabel.h"
@interface XAbscissaView ()

@property(nonatomic, strong) NSMutableArray<UILabel*>* labelArray;
@property(nonatomic, strong) NSMutableArray<NSString*>* dataDescribeArray;
@property(nonatomic, strong) NSMutableArray* dataItemArray;
@property(nonatomic, strong) XBaseChartConfiguration *configuration;

@end

@implementation XAbscissaView

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray*)dataItemArray
                configuration:(XBaseChartConfiguration*)configuration
{
  if (self = [self initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];
    self.dataDescribeArray = [NSMutableArray new];
    self.labelArray = [NSMutableArray new];
    self.dataItemArray = dataItemArray;
    self.configuration = configuration;
    [self dealData];
    [self setupUI];
  }
  return self;
}

- (void)dealData {
  [self.dataItemArray
      enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
          [self.dataDescribeArray addObject:obj];
        } else if ([obj isKindOfClass:[XBarItem class]]) {
          [self.dataDescribeArray addObject:((XBarItem*)obj).dataDescribe];
        }
      }];
}

- (void)setupUI {
  if (!self.configuration.isShowXAbscissa) {
    return;
  }
  CGFloat labelWidth = self.frame.size.width / self.dataDescribeArray.count;
  CGFloat intervalWidth = labelWidth / 6;
  for (int i = 0; i < self.dataDescribeArray.count; i++) {
    XAlignLabel* label = [[XAlignLabel alloc]
        initWithFrame:CGRectMake(labelWidth * i + intervalWidth, 0,
                                 labelWidth - 2 * intervalWidth,
                                 self.frame.size.height)];
    label.text = self.dataDescribeArray[i];
    label.textColor = [UIColor black50PercentColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;

//    float largestFontSize = 12;
//    while ([label.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].width > label.frame.size.width)
//    {
//      largestFontSize--;
//    }
//    label.verticalAlignment = XVerticalAlignmentMiddle;
    label.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:12];
    if (label.frame.size.width < 20) {
      label.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:6];
      label.verticalAlignment = XVerticalAlignmentTop;
    } else  if (label.frame.size.width < 10) {
      label.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:3];
      label.verticalAlignment = XVerticalAlignmentTop;
    }
    [self addSubview:label];
  }
}

@end
