//
//  XJYTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYTableViewCell.h"

@implementation XJYTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    //        self.backgroundColor = [UIColor colorWithRed:235/255.0
    //        green:235/255.0 blue:235/255.0 alpha:1];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}
@end
