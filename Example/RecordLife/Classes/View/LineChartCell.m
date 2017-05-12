//
//  HomeFiveTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "LineChartCell.h"
#import "XJYChart.h"
@implementation LineChartCell

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
        
        NSMutableArray *numbersArray = [NSMutableArray new];
        
        for (int j = 0; j<5; j++) {
            
            NSMutableArray *numberArray = [NSMutableArray new];
            
            for (int i = 0; i<5; i++) {
                int num = [[RandomNumerHelper shareRandomNumberHelper] randomNumberSmallThan:14] * [[RandomNumerHelper shareRandomNumberHelper] randomNumberSmallThan:14];
                NSNumber *number = [NSNumber numberWithInt:num];
                [numberArray addObject:number];
            }
            
            [numbersArray addObject:numberArray];
        }
        
        NSArray *colorArray = @[[UIColor robinEggColor], [UIColor fadedBlueColor], [UIColor salmonColor], [UIColor coolGrayColor], [UIColor successColor]];
        NSArray *colorArray1 = @[@"", @"", @"", @"", @""];
        
        for (int i = 0; i<5; i++) {
            
            XXLineChartItem *item = [[XXLineChartItem alloc] initWithDataNumberArray:numbersArray[i] color:colorArray[i] dataDescribe:@"111"];
            [itemArray addObject:item];
        }
        XXLineChart *lineChart = [[XXLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray dataDiscribeArray:[NSMutableArray arrayWithArray:@[@"January", @"February", @"March", @"April", @"May"]] topNumber:@200 bottomNumber:@0  graphMode:MutiLineGraph];
        lineChart.colorMode = Custom;
        lineChart.lineMode = CurveLine;
        [self.contentView addSubview:lineChart];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
