//
//  XBarChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XBarChart.h"
#import "XBarChartView.h"
#import "OrdinateView.h"
#import "XNotificationBridge.h"
#import "XBarChartConfiguration.h"
#define OrdinateWidth 30
#define BarChartViewTopInterval 10

@interface XBarChart ()

@property(nonatomic, strong) XBarChartView* barChartView;
@property(nonatomic, strong) OrdinateView* ordinateView;

@end

@implementation XBarChart
- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XBarItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
           chartConfiguration:(XBarChartConfiguration*)configuration {
  if (self = [super initWithFrame:frame]) {
    self.dataItemArray = dataItemArray;
    self.top = topNumbser;
    self.bottom = bottomNumber;
    self.configuration = configuration;
    [self addSubview:self.ordinateView];
    [self addSubview:self.barChartView];
    
    // Notification
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(touchNotification:)
     name:[XNotificationBridge shareXNotificationBridge]
     .TouchBarNotification
     object:nil];
  }
  return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
  }
  return self;
}

#pragma mark Get

- (XBarChartView*)barChartView {
  if (!_barChartView) {
    _barChartView = [[XBarChartView alloc]
        initWithFrame:CGRectMake(
                          OrdinateWidth, BarChartViewTopInterval,
                          self.frame.size.width - OrdinateWidth,
                          self.frame.size.height - BarChartViewTopInterval)
        dataItemArray:self.dataItemArray
            topNumber:self.top
         bottomNumber:self.bottom
           chartConfiguration:self.configuration
                     ];
    _barChartView.chartBackgroundColor = _chartBackgroundColor;
  }
  return _barChartView;
}

- (OrdinateView*)ordinateView {
  if (!_ordinateView) {
    _ordinateView = [[OrdinateView alloc]
        initWithFrame:CGRectMake(0, 0, OrdinateWidth, self.frame.size.height)
            topNumber:self.top
         bottomNumber:self.bottom];
    _ordinateView.backgroundColor = [UIColor whiteColor];
  }
  return _ordinateView;
}

#pragma mark Notification
- (void)touchNotification:(NSNotification*)noti {
  NSDictionary* info = noti.userInfo;
  NSNumber* idxNumber =
      info[[[XNotificationBridge shareXNotificationBridge] BarIdxNumberKey]];
  if ([self.barChartDeleagte respondsToSelector:@selector(userClickedOnBarAtIndex:)]) {
    [self.barChartDeleagte userClickedOnBarAtIndex:idxNumber.integerValue];
  }
}

#pragma mark Lazy
- (XBarChartConfiguration *)configuration {
  if (!_configuration) {
    _configuration = [XBarChartConfiguration new];
  }
  return _configuration;
}

@end
