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
#import "XAreaLineContainerView.h"
#define PartWidth 40
#define AbscissaHeight 30

NSString *KVOKeyColorMode = @"colorMode";
NSString *KVOKeyLineGraphMode = @"lineMode";

@interface XLineChartView ()
@property (nonatomic, strong) AbscissaView *abscissaView;

@property (nonatomic, strong) UIView *contanierView;
@property (nonatomic, strong) XLineContainerView *lineContainerView;
@property (nonatomic, strong) XAreaLineContainerView *areaLineContainerView;

@end

@implementation XLineChartView



- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray dataDescribeArray:(NSMutableArray<NSString *> *)dataDescribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber  graphMode:(XXLineGraphMode)graphMode {
    if (self = [super initWithFrame:frame]) {
        self.top = topNumbser;
        self.bottom = bottomNumber;
        self.dataItemArray = dataItemArray;
        self.backgroundColor = [UIColor whiteColor];
        self.dataDescribeArray = dataDescribeArray;
        self.contentSize = [self computeSrollViewCententSizeFromItemArray:self.dataItemArray];
    
        // default line graph mode
        self.lineGraphMode = graphMode;
        
        [self addSubview:self.abscissaView];
        [self addSubview:[self getLineChartContainerViewWithGraphMode:self.lineGraphMode]];
        
    }
    return self;
}

// Acorrding Line Graph Mode Choose Which LineContanier View
- (UIView *)getLineChartContainerViewWithGraphMode:(XXLineGraphMode)lineGraphMode {
    if (lineGraphMode == AreaLineGraph) {
        self.contanierView = self.areaLineContainerView;
        return self.contanierView;
    } else if (lineGraphMode == BrokenLine){
        self.contanierView = self.lineContainerView;
        return self.contanierView;
    } else {
        self.contanierView = self.lineContainerView;
        return self.contanierView;
    }
    
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
        _abscissaView = [[AbscissaView alloc] initWithFrame:CGRectMake(0, self.contentSize.height - AbscissaHeight, self.contentSize.width, AbscissaHeight)
                                              dataItemArray:self.dataDescribeArray];
    }
    return _abscissaView;
}

#pragma mark Containers
- (XLineContainerView *)lineContainerView {
    if (!_lineContainerView) {
        _lineContainerView = [[XLineContainerView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height - AbscissaHeight)
                                                         dataItemArray:self.dataItemArray
                                                             topNumber:self.top
                                                          bottomNumber:self.bottom];
    }
    return _lineContainerView;
}

- (XAreaLineContainerView *)areaLineContainerView {
    if (!_areaLineContainerView) {
        _areaLineContainerView = [[XAreaLineContainerView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height - AbscissaHeight)
                                                                 dataItemArray:self.dataItemArray
                                                                     topNumber:self.top
                                                                  bottomNumber:self.bottom];
    }
    return _areaLineContainerView;
}


- (void)setColorMode:(XXColorMode)colorMode {
    _colorMode = colorMode;
    
    // two kind of containerview use kvo instand of inhert
    // not safe i will fix it !
    [self.contanierView setValue:@(colorMode) forKey:KVOKeyColorMode];
}
- (void)setLineMode:(XXLineMode)lineMode {
    _lineMode = lineMode;
    [self.contanierView setValue:@(lineMode) forKey:KVOKeyLineGraphMode];
}



@end
