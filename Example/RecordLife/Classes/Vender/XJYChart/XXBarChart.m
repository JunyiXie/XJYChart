//
//  XXBarChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XXBarChart.h"
#import "XBarChartView.h"
#import "OrdinateView.h"
#import "XJYNotificationBridge.h"

#define OrdinateWidth 30
#define BarChartViewTopInterval 10



@interface XXBarChart ()

@property (nonatomic, strong) XBarChartView *barChartView;
@property (nonatomic, strong) OrdinateView *ordinateView;

@end


@implementation XXBarChart

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XJYBarItem *> *)dataItemArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        
        self.dataItemArray = dataItemArray;
        self.top = topNumbser;
        self.bottom = bottomNumber;
        
        [self addSubview:self.ordinateView];
        [self addSubview:self.barChartView];
        
        // Notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchNotification:) name:[XJYNotificationBridge shareXJYNotificationBridge].TouchBarNotification object:nil];
    
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark Get 

- (XBarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[XBarChartView alloc] initWithFrame:CGRectMake(OrdinateWidth, BarChartViewTopInterval, self.frame.size.width - OrdinateWidth, self.frame.size.height - BarChartViewTopInterval) dataItemArray:self.dataItemArray topNumber:self.top bottomNumber:self.bottom];
    }
    return _barChartView;
}

- (OrdinateView *)ordinateView {
    if (!_ordinateView) {
        _ordinateView = [[OrdinateView alloc] initWithFrame:CGRectMake(0, 0, OrdinateWidth, self.frame.size.height) topNumber:self.top bottomNumber:self.bottom];
        _ordinateView.backgroundColor = [UIColor whiteColor];
    }
    return _ordinateView;
}


#pragma mark Notification 
- (void)touchNotification:(NSDictionary *)info {
//    NSNumber *idxNumber = info[[XJYNotificationBridge shareXJYNotificationBridge].BarIdxNumberKey];
//    [self.barChartDeleagte touchBarAtIdx:idxNumber.integerValue];
}

@end
