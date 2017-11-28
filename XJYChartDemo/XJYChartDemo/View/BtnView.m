//
//  BtnView.m
//  RecordLife
//
//  Created by 谢俊逸 on 01/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "BtnView.h"
#import "XJYTapCycleView.h"
@implementation BtnView


- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat eachX = self.frame.size.width/3;
    for (int i = 0; i<3; i++) {
        XJYTapCycleView *tap = [[XJYTapCycleView alloc] initWithFrame:CGRectMake((i+1)*eachX - 35, 20, 70, 70)];
        [tap addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tap];
        [self.tapArray addObject:tap];
    }
    

}


#pragma mark Tap

- (void)buttonAction:(XJYTapCycleView *)button {
    if (button.tag == 1) {
        [self.tapArray enumerateObjectsUsingBlock:^(XJYTapCycleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj tapChange:false];
        }];
        [button tapChange:true];
        NSLog(@"1");
    } else if (button.tag == 2) {
        [self.tapArray enumerateObjectsUsingBlock:^(XJYTapCycleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj tapChange:false];
        }];
        [button tapChange:true];
        NSLog(@"2");
        
    } else if (button.tag == 3) {
        [self.tapArray enumerateObjectsUsingBlock:^(XJYTapCycleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj tapChange:false];
        }];
        [button tapChange:true];
        NSLog(@"3");
        
    }
}



@end
