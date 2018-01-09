//
//  XXPositiveNegativeBarChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/04/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XPositiveNegativeBarChart.h"
#import "XPositiveNegativeBarChartView.h"
#import "OrdinateView.h"
#import "XNotificationBridge.h"
#define OrdinateWidth 30
#define BarChartViewTopInterval 10

@interface XPositiveNegativeBarChart ()

@property(nonatomic, strong) XPositiveNegativeBarChartView* barChartView;
@property(nonatomic, strong) OrdinateView* ordinateView;

@end

@implementation XPositiveNegativeBarChart

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XBarItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber {
  if (self = [super initWithFrame:frame]) {
    self.dataItemArray = dataItemArray;
    self.top = topNumbser;
    self.bottom = bottomNumber;

    [self addSubview:self.ordinateView];
    [self addSubview:self.barChartView];
    // Notification
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(touchNotification:)
               name:[XNotificationBridge shareXNotificationBridge]
                        .TouchPNBarNotification
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

- (XPositiveNegativeBarChartView*)barChartView {
  if (!_barChartView) {
    _barChartView = [[XPositiveNegativeBarChartView alloc]
        initWithFrame:CGRectMake(
                          OrdinateWidth, BarChartViewTopInterval,
                          self.frame.size.width - OrdinateWidth,
                          self.frame.size.height - BarChartViewTopInterval)
        dataItemArray:self.dataItemArray
            topNumber:self.top
         bottomNumber:self.bottom];
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
      info[[[XNotificationBridge shareXNotificationBridge] PNBarIdxNumberKey]];
  if ([self.barChartDeleagte respondsToSelector:@selector(userClickedOnBarAtIndex:)]) {
    [self.barChartDeleagte userClickedOnBarAtIndex:idxNumber.integerValue];
  }
}


@end
