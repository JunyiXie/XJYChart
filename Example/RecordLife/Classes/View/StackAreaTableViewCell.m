//
//  StackAreaTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 11/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "StackAreaTableViewCell.h"
#import "XChart.h"
@implementation StackAreaTableViewCell

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
                int num = 30 * i;
                NSNumber *number = [NSNumber numberWithInt:num];
                [numberArray addObject:number];
            }
            
            [numbersArray addObject:numberArray];
        }
        
        NSArray *colorArray = @[[UIColor robinEggColor], [UIColor fadedBlueColor], [UIColor salmonColor], [UIColor coolGrayColor], [UIColor successColor]];
        NSArray *colorArray1 = @[@"", @"", @"", @"", @""];
        
        for (int i = 0; i<5; i++) {
            
            XLineChartItem *item = [[XLineChartItem alloc] initWithDataNumberArray:numbersArray[i] color:colorArray[i] dataDescribe:@"111"];
            [itemArray addObject:item];
        }
        XLineChart *lineChart = [[XLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray dataDiscribeArray:[NSMutableArray arrayWithArray:@[@"January", @"February", @"March", @"April", @"May"]] topNumber:@1000 bottomNumber:@0  graphMode:StackAreaLineGraph];
        lineChart.colorMode = Custom;
        lineChart.lineMode = CurveLine;
        [self.contentView addSubview:lineChart];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
