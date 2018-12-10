//
//  XBarChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 15/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XBarChartView.h"
#import "XBarItem.h"
#import "XAbscissaView.h"
#import "XBarItem.h"
#import "XAuxiliaryCalculationHelper.h"
#import "XBarContainerView.h"
#import "XPositiveNegativeBarContainerView.h"
#import "XBarChartConfiguration.h"

#define PartWidth 30.0
#define BarBackgroundFillColor \
  [UIColor colorWithRed:232 / 255.0 green:232 / 255.0 blue:232 / 255.0 alpha:1]
@interface XBarChartView ()

@property(nonatomic, strong) XBarContainerView* barContainerView;
@property(nonatomic, strong) NSMutableArray<UIColor*>* colorArray;
@property(nonatomic, strong) NSMutableArray<NSString*>* dataDescribeArray;
@property(nonatomic, strong) NSMutableArray<NSNumber*>* dataNumberArray;
@property(nonatomic, assign) BOOL needScroll;
@property(nonatomic, strong) XAbscissaView* XAbscissaView;

@end

@implementation XBarChartView
- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XBarItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
           chartConfiguration:(XBarChartConfiguration *)configuration {
  if (self = [self initWithFrame:frame]) {
    self.dataItemArray = [[NSMutableArray alloc] init];
    self.colorArray = [[NSMutableArray alloc] init];
    self.dataNumberArray = [[NSMutableArray alloc] init];
    self.dataItemArray = dataItemArray;
    self.top = topNumbser;
    self.bottom = bottomNumber;
    self.configuration = configuration;
    self.backgroundColor = [UIColor whiteColor];
    self.contentSize =
    [self computeSrollViewCententSizeFromItemArray:self.dataItemArray];
    [self addSubview:self.barContainerView];
    
    [self addSubview:self.XAbscissaView];
  }
  return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
  }
  return self;
}

//计算是否需要滚动
- (CGSize)computeSrollViewCententSizeFromItemArray:
    (NSMutableArray<XBarItem*>*)itemArray {
  if (self.configuration.x_width) {
    CGFloat calWidth = self.configuration.x_width*itemArray.count * 1.35;
    CGFloat width = calWidth >  self.frame.size.width ? calWidth : self.frame.size.width;
    return CGSizeMake(width, self.frame.size.height);
  }
  if (itemArray.count <= 10 || !self.configuration.isScrollable) {
    self.needScroll = NO;
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
  } else {
    self.needScroll = YES;
    CGFloat width = PartWidth * itemArray.count;
    CGFloat height = self.frame.size.height;
    return CGSizeMake(width, height);
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark Get
- (XAbscissaView*)XAbscissaView {
  if (!_XAbscissaView) {
    _XAbscissaView = [[XAbscissaView alloc]
        initWithFrame:CGRectMake(0, self.frame.size.height - AbscissaHeight,
                                 self.contentSize.width, AbscissaHeight)
        dataItemArray:self.dataItemArray
        configuration:self.configuration];
    _XAbscissaView.backgroundColor = [UIColor whiteColor];
  }
  return _XAbscissaView;
}

- (XBarContainerView*)barContainerView {
  if (!_barContainerView) {
    _barContainerView = [[XBarContainerView alloc]
        initWithFrame:CGRectMake(0, 0, self.contentSize.width,
                                 self.contentSize.height - AbscissaHeight)
        dataItemArray:self.dataItemArray
            topNumber:self.top
         bottomNumber:self.bottom
      chartConfiguration:self.configuration
                         ];
    _barContainerView.chartBackgroundColor = _chartBackgroundColor;
  }
  return _barContainerView;
}




@end
