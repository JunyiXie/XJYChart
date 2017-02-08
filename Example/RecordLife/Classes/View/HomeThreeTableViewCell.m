//
//  HomeThreeTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "HomeThreeTableViewCell.h"
#import "XJYBarChart.h"

@interface HomeThreeTableViewCell ()

@property (nonatomic, strong) XJYBarChart *barChart;

@end

@implementation HomeThreeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        XJYBarChart *barChart = [[XJYBarChart alloc] init];
        
        //纵坐标最高值
        barChart.top = @60;
        //纵坐标最低值
        barChart.bottom = @0;
        
        
        NSMutableArray *itemArray = [[NSMutableArray alloc] init];
        XJYBarItem *item1 = [[XJYBarItem alloc] initWithDataNumber:@(0.93) color:[UIColor greenColor] dataDescribe:@"MAC Os"];
        [itemArray addObject:item1];
        XJYBarItem *item2 = [[XJYBarItem alloc] initWithDataNumber:@(7.04) color:[UIColor greenColor] dataDescribe:@"Win10"];
        [itemArray addObject:item2];
        XJYBarItem *item3 = [[XJYBarItem alloc] initWithDataNumber:@(4.99) color:[UIColor redColor] dataDescribe:@"Win8"];
        [itemArray addObject:item3];
        XJYBarItem *item4 = [[XJYBarItem alloc] initWithDataNumber:@(28.48) color:[UIColor greenColor] dataDescribe:@"WinXP"];
        [itemArray addObject:item4];
        XJYBarItem *item5 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:[UIColor greenColor] dataDescribe:@"Win7"];
        [itemArray addObject:item5];
        
        
        //设置dataItemArray
        barChart.dataItemArray = itemArray;
        
        self.barChart = barChart;
        [self addSubview:self.barChart];
    }
    return self;
}


#pragma mark Auto Layout 
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.barChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [super updateConstraints];
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
