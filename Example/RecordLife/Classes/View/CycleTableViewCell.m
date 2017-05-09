//
//  CycleTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 01/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "CycleTableViewCell.h"

@interface CycleTableViewCell ()<XJYCycleViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *showMoneyRangeLabel;

@property (nonatomic, strong) UITapGestureRecognizer *ges1;
@property (nonatomic, strong) UITapGestureRecognizer *ges2;
@property (nonatomic, strong) UITapGestureRecognizer *ges3;


@property (nonatomic, strong) NSArray<XJYTapCycleView *> *tapArray;



@end

@implementation CycleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cycleView.cycleViewDeleagte = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 接口
    self.min = 500;
    self.max = 2000;
    
    //
    self.moneyLabel.text = [NSString stringWithFormat:@"0元"];
    self.moneyLabel.font = [UIFont systemFontOfSize:20];
//        
//    self.tapArray = @[self.tap1,self.tap2,self.tap3];
//    
//    self.tap1.tag = 1;
//    self.tap2.tag = 2;
//    self.tap3.tag = 3;
//    
//    [self.tap1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.tap2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.tap3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark 回调
- (void)ratioChange:(CGFloat)ratio {
    
    //传给你比例!
    self.moneyLabel.text = [NSString stringWithFormat:@"%.0f元",ratio * self.max];
    if (ratio >= 0.95) {
        self.moneyLabel.text = [NSString stringWithFormat:@"%.0f元",1 * self.max];
    }
}

//#pragma mark Tap
//
//- (void)buttonAction:(XJYTapCycleView *)button {
//    if (button.tag == 1) {
//        [self.tapArray enumerateObjectsUsingBlock:^(XJYTapCycleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj tapChange:false];
//        }];
//        [button tapChange:true];
//        NSLog(@"1");
//    } else if (button.tag == 2) {
//        [self.tapArray enumerateObjectsUsingBlock:^(XJYTapCycleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj tapChange:false];
//        }];
//        [button tapChange:true];
//        NSLog(@"2");
//        
//    } else if (button.tag == 3) {
//        [self.tapArray enumerateObjectsUsingBlock:^(XJYTapCycleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj tapChange:false];
//        }];
//        [button tapChange:true];
//        NSLog(@"3");
//        
//    }
//}


@end
