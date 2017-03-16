//
//  HomeFourTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 15/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "HomeFourTableViewCell.h"
#import "XJYChart.h"

@implementation HomeFourTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

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
        
        XJYBarItem *item6 = [[XJYBarItem alloc] initWithDataNumber:@(0.93) color:[UIColor greenColor] dataDescribe:@"MAC Os"];
        [itemArray addObject:item6];
        XJYBarItem *item7 = [[XJYBarItem alloc] initWithDataNumber:@(7.04) color:[UIColor greenColor] dataDescribe:@"Win10"];
        [itemArray addObject:item7];
        XJYBarItem *item8 = [[XJYBarItem alloc] initWithDataNumber:@(4.99) color:[UIColor redColor] dataDescribe:@"Win8"];
        [itemArray addObject:item8];
        XJYBarItem *item9 = [[XJYBarItem alloc] initWithDataNumber:@(28.48) color:[UIColor greenColor] dataDescribe:@"WinXP"];
        [itemArray addObject:item9];
        XJYBarItem *item10 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:[UIColor greenColor] dataDescribe:@"Win7"];
        [itemArray addObject:item10];
        
        XXBarChart *barChart = [[XXBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@100 bottomNumber:@0];
        
        [self.contentView addSubview:barChart];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
