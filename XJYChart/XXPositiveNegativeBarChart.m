//
//  XXPositiveNegativeBarChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/04/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XXPositiveNegativeBarChart.h"
#import "XXPositiveNegativeBarChartView.h"
#import "OrdinateView.h"
#define OrdinateWidth 30
#define BarChartViewTopInterval 10

@interface XXPositiveNegativeBarChart ()

@property (nonatomic, strong) XXPositiveNegativeBarChartView *barChartView;
@property (nonatomic, strong) OrdinateView *ordinateView;

@end

@implementation XXPositiveNegativeBarChart

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XJYBarItem *> *)dataItemArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        
        self.dataItemArray = dataItemArray;
        self.top = topNumbser;
        self.bottom = bottomNumber;
        
        [self addSubview:self.ordinateView];
        [self addSubview:self.barChartView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark Get

- (XXPositiveNegativeBarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[XXPositiveNegativeBarChartView alloc] initWithFrame:CGRectMake(OrdinateWidth, BarChartViewTopInterval, self.frame.size.width - OrdinateWidth, self.frame.size.height - BarChartViewTopInterval) dataItemArray:self.dataItemArray topNumber:self.top bottomNumber:self.bottom];
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


@end
