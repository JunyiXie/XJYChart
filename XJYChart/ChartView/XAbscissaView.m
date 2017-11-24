//
//  XAbscissaView.m
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAbscissaView.h"
#import "XChart.h"

@interface XAbscissaView()

@property (nonatomic, strong) NSMutableArray<UILabel *> *labelArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;
@property (nonatomic, strong) NSMutableArray *dataItemArray;

@end

@implementation XAbscissaView

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray *)dataItemArray {
    if (self = [self initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataDescribeArray = [NSMutableArray new];
        self.labelArray = [NSMutableArray new];
        self.dataItemArray = dataItemArray;
        
        [self dealData];
        [self setupUI];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)dealData {
    
    [self.dataItemArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [self.dataDescribeArray addObject:obj];
        } else if([obj isKindOfClass:[XBarItem class]]) {
            [self.dataDescribeArray addObject:((XBarItem *)obj).dataDescribe];
        }
    }];
}

- (void)setupUI {
    CGFloat labelWidth = self.frame.size.width / self.dataDescribeArray.count;
    CGFloat intervalWidth = labelWidth/6;
    for (int i = 0; i < self.dataDescribeArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth * i + intervalWidth, 0, labelWidth - 2*intervalWidth, self.frame.size.height)];
        label.text = self.dataDescribeArray[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}

@end
