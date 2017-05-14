//
//  XXPositiveNegativeBarChartView.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/04/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XXPositiveNegativeBarChartView.h"
#import "XJYBarItem.h"
#import "AbscissaView.h"
#import "XJYBarItem.h"
#import "XJYAuxiliaryCalculationHelper.h"
#import "XBarContainerView.h"
#import "XPositiveNegativeBarContainerView.h"

#define AbscissaHeight 30
#define PartWidth 50.0
#define BarBackgroundFillColor [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]

@interface XXPositiveNegativeBarChartView ()

@property (nonatomic, strong) XPositiveNegativeBarContainerView *barPNContainerView;
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *dataNumberArray;
@property (nonatomic, assign) BOOL needScroll;
@property (nonatomic, strong) AbscissaView *abscissaView;

@end

@implementation XXPositiveNegativeBarChartView
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XJYBarItem *> *)dataItemArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber {
    if (self = [self initWithFrame:frame]) {
        
        self.dataItemArray = [[NSMutableArray alloc] init];
        self.colorArray = [[NSMutableArray alloc] init];
        self.dataNumberArray = [[NSMutableArray alloc] init];
        self.dataItemArray = dataItemArray;
        self.top = topNumbser;
        self.bottom = bottomNumber;
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentSize = [self computeSrollViewCententSizeFromItemArray:self.dataItemArray];
        
        [self addSubview:self.barPNContainerView];
        [self addSubview:self.abscissaView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

//计算是否需要滚动
- (CGSize)computeSrollViewCententSizeFromItemArray:(NSMutableArray<XJYBarItem *> *)itemArray {
    
    if (itemArray.count <= 8) {
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
- (AbscissaView *)abscissaView {
    if (!_abscissaView) {
        _abscissaView = [[AbscissaView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - AbscissaHeight, self.contentSize.width, AbscissaHeight) dataItemArray:self.dataItemArray];
        _abscissaView.backgroundColor = [UIColor whiteColor];
    }
    return _abscissaView;
}

- (XPositiveNegativeBarContainerView *)barPNContainerView {
    if (!_barPNContainerView) {
        _barPNContainerView = [[XPositiveNegativeBarContainerView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height - AbscissaHeight) dataItemArray:self.dataItemArray topNumber:self.top bottomNumber:self.bottom];
    }
    return _barPNContainerView;
}

@end
