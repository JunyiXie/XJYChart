//
//  XLineChartView.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XLineChartView.h"
#import "AbscissaView.h"
#import "XLineContainerView.h"

#define PartWidth 10
#define AbscissaHeight 30

@interface XLineChartView ()
@property (nonatomic, strong) AbscissaView *abscissaView;
@property (nonatomic, strong) XLineContainerView *lineContainerView;

@end

@implementation XLineChartView



- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray dataDescribeArray:(NSMutableArray<NSString *> *)dataDescribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber  {
    if (self = [super initWithFrame:frame]) {
        self.top = topNumbser;
        self.bottom = bottomNumber;
        self.dataItemArray = dataItemArray;
        self.backgroundColor = [UIColor whiteColor];
        self.dataDescribeArray = dataDescribeArray;
        
        self.contentSize = [self computeSrollViewCententSizeFromItemArray:self.dataItemArray];
        
        [self addSubview:self.abscissaView];
        [self addSubview:self.lineContainerView];
        
    }
    return self;
}


//计算是否需要滚动
- (CGSize)computeSrollViewCententSizeFromItemArray:(NSMutableArray<XXLineChartItem *> *)itemArray {
    XXLineChartItem *item = itemArray[0];
    if (item.numberArray.count <= 8) {
        return CGSizeMake(self.frame.size.width, self.frame.size.height);
    } else {
        CGFloat width = PartWidth * item.numberArray.count;
        CGFloat height = self.frame.size.height;
        return CGSizeMake(width, height);
    }
    
}


#pragma mark Get
- (AbscissaView *)abscissaView {
    if (!_abscissaView) {
        _abscissaView = [[AbscissaView alloc] initWithFrame:CGRectMake(0, self.contentSize.height - AbscissaHeight, self.contentSize.width, AbscissaHeight) dataItemArray:self.dataDescribeArray];
    }
    return _abscissaView;
}

- (XLineContainerView *)lineContainerView {
    if (!_lineContainerView) {
        _lineContainerView = [[XLineContainerView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height - AbscissaHeight) dataItemArray:self.dataItemArray topNumber:self.top bottomNumber:self.bottom];
    }
    return _lineContainerView;
}

@end
