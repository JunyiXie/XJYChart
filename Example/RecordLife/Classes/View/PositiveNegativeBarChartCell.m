//
//  HomeSixTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/04/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "PositiveNegativeBarChartCell.h"
#import "XJYChart.h"

@implementation PositiveNegativeBarChartCell

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
        XJYBarItem *item1 = [[XJYBarItem alloc] initWithDataNumber:@(-80.93) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item1];
        XJYBarItem *item2 = [[XJYBarItem alloc] initWithDataNumber:@(-107.04) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item2];
        XJYBarItem *item3 = [[XJYBarItem alloc] initWithDataNumber:@(77.99) color:XJYDarkBlue  dataDescribe:@"test"];
        [itemArray addObject:item3];
        XJYBarItem *item4 = [[XJYBarItem alloc] initWithDataNumber:@(57.48) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item4];
        XJYBarItem *item5 = [[XJYBarItem alloc] initWithDataNumber:@(-89.91) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item5];
        
        XJYBarItem *item6 = [[XJYBarItem alloc] initWithDataNumber:@(66.93) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item6];
        XJYBarItem *item7 = [[XJYBarItem alloc] initWithDataNumber:@(7.04) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item7];
        XJYBarItem *item8 = [[XJYBarItem alloc] initWithDataNumber:@(-77.99) color:XJYDarkBlue  dataDescribe:@"test"];
        [itemArray addObject:item8];
        XJYBarItem *item9 = [[XJYBarItem alloc] initWithDataNumber:@(-28.48) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item9];
        XJYBarItem *item10 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item10];
        //
        XJYBarItem *item11 = [[XJYBarItem alloc] initWithDataNumber:@(-0.93) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item11];
        XJYBarItem *item12 = [[XJYBarItem alloc] initWithDataNumber:@(-7.04) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item12];
        XJYBarItem *item13 = [[XJYBarItem alloc] initWithDataNumber:@(44.99) color:XJYDarkBlue  dataDescribe:@"test"];
        [itemArray addObject:item13];
        XJYBarItem *item14 = [[XJYBarItem alloc] initWithDataNumber:@(28.48) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item14];
        XJYBarItem *item15 = [[XJYBarItem alloc] initWithDataNumber:@(-52.91) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item15];
        
        XJYBarItem *item16 = [[XJYBarItem alloc] initWithDataNumber:@(0.93) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item16];
        XJYBarItem *item17 = [[XJYBarItem alloc] initWithDataNumber:@(77.04) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item17];
        XJYBarItem *item18 = [[XJYBarItem alloc] initWithDataNumber:@(4.99) color:XJYDarkBlue  dataDescribe:@"test"];
        [itemArray addObject:item18];
        XJYBarItem *item19 = [[XJYBarItem alloc] initWithDataNumber:@(-28.48) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item19];
        XJYBarItem *item20 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item20];
        
        XJYBarItem *item21 = [[XJYBarItem alloc] initWithDataNumber:@(0.93) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item21];
        XJYBarItem *item22 = [[XJYBarItem alloc] initWithDataNumber:@(7.04) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item22];
        XJYBarItem *item23 = [[XJYBarItem alloc] initWithDataNumber:@(4.99) color:XJYDarkBlue  dataDescribe:@"test"];
        [itemArray addObject:item23];
        XJYBarItem *item24 = [[XJYBarItem alloc] initWithDataNumber:@(44.48) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item24];
        XJYBarItem *item25 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:XJYDarkBlue dataDescribe:@"test"];
        [itemArray addObject:item25];
        
        XXPositiveNegativeBarChart *barChart = [[XXPositiveNegativeBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@100 bottomNumber:@(-170)];
        
        [self.contentView addSubview:barChart];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
