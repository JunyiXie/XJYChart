//
//  XXLineChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XXLineChart.h"
#import "OrdinateView.h"

#define OrdinateWidth 30
#define LineChartViewTopInterval 10

@interface XXLineChart ()


@property (nonatomic, strong) NSNumber *top;
@property (nonatomic, strong) NSNumber *bottom;
@property (nonatomic, strong) NSMutableArray<XXLineChartItem *> *dataItemArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;

@property (nonatomic, strong) OrdinateView *ordinateView;
@property (nonatomic, strong) XLineChartView *lineChartView;

@end

@implementation XXLineChart

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray dataDiscribeArray:(NSMutableArray<NSString *> *)dataDiscribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        self.top = topNumbser;
        self.bottom = bottomNumber;
        self.dataItemArray = dataItemArray;
        self.dataDescribeArray = dataDiscribeArray;
        
        [self addSubview:self.ordinateView];
        [self addSubview:self.lineChartView];
    }
    return self;
}



#pragma mark Get 

- (OrdinateView *)ordinateView {
    if (!_ordinateView) {
        _ordinateView = [[OrdinateView alloc] initWithFrame:CGRectMake(0, 0, OrdinateWidth, self.frame.size.height) topNumber:self.top bottomNumber:self.bottom];
    }
    return _ordinateView;
}

- (XLineChartView *)lineChartView {
    if (!_lineChartView) {
        _lineChartView = [[XLineChartView alloc] initWithFrame:CGRectMake(OrdinateWidth, LineChartViewTopInterval, self.frame.size.width - OrdinateWidth, self.frame.size.height - LineChartViewTopInterval) dataItemArray:self.dataItemArray dataDescribeArray:self.dataDescribeArray topNumber:self.top bottomNumber:self.bottom];
    }
    return _lineChartView;
}

#pragma mark Set
- (void)setColorModel:(XXColorModel)colorModel {
    _colorModel = colorModel;
    self.lineChartView.colorModel = colorModel;
}


@end
