//
//  CycleTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 01/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "CycleTableViewCell.h"

@interface CycleTableViewCell ()<XCycleViewDelegate>

@property(strong, nonatomic) IBOutlet UILabel* showMoneyRangeLabel;

@property(nonatomic, strong) UITapGestureRecognizer* ges1;
@property(nonatomic, strong) UITapGestureRecognizer* ges2;
@property(nonatomic, strong) UITapGestureRecognizer* ges3;


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

  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

#pragma mark 回调
- (void)ratioChange:(CGFloat)ratio {
  //传给你比例!
  self.moneyLabel.text =
      [NSString stringWithFormat:@"%.0f元", ratio * self.max];
  if (ratio >= 0.95) {
    self.moneyLabel.text = [NSString stringWithFormat:@"%.0f元", 1 * self.max];
  }
}


@end
