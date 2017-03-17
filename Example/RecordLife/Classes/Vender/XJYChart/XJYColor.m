//
//  XJYColor.m
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYColor.h"


@interface XJYColor ()

@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;

@end

@implementation XJYColor


+ (instancetype)shareXJYColor {
    static XJYColor *xjyColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xjyColor = [[XJYColor alloc] init];
    });
    return xjyColor;
}

- (UIColor *)randomColorInColorArray {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupColorArray];
    });
    
    int idx = arc4random() % self.colorArray.count;
    return self.colorArray[idx];

}


- (void)setupColorArray {
    self.colorArray = [NSMutableArray new];
    [self.colorArray addObject:XJYLightBlue];
    [self.colorArray addObject:XJYGreen];
//    [self.colorArray addObject:XJYLightGreen];
    [self.colorArray addObject:XJYFreshGreen];
    [self.colorArray addObject:XJYDeepGreen];
    [self.colorArray addObject:XJYRed];
    [self.colorArray addObject:XJYMauve];
    [self.colorArray addObject:XJYBrown];
    [self.colorArray addObject:XJYBlue];
    [self.colorArray addObject:XJYDarkBlue];
    [self.colorArray addObject:XJYYellow];
    [self.colorArray addObject:XJYHealYellow];
    [self.colorArray addObject:XJYLightYellow];
    [self.colorArray addObject:XJYPinkDark];
    [self.colorArray addObject:XJYStarYellow];
    [self.colorArray addObject:XJYTwitterColor];
    [self.colorArray addObject:XJYWeiboColor];
    [self.colorArray addObject:XJYiOSGreenColor];
}

@end
