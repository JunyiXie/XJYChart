//
//  HomeTwoTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 22/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "HomeTwoTableViewCell.h"

@interface HomeTwoTableViewCell ()

@property (nonatomic, strong) XJYPieChart *pieChartView;


@end

@implementation HomeTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.pieChartView = [[XJYPieChart alloc] init];
        NSMutableArray *pieItems = [[NSMutableArray alloc] init];
//        NSArray *colorArray = @[[[XJYColor shareXJYColor] randomColorInColorArray],[[XJYColor shareXJYColor] randomColorInColorArray],[[XJYColor shareXJYColor] randomColorInColorArray],[[XJYColor shareXJYColor] randomColorInColorArray]];
        NSArray *colorArray = @[RGB(145, 235, 253), RGB(198, 255, 150), RGB(254, 248, 150), RGB(253, 210, 147)];
        
        NSArray *dataArray = @[@"iPhone6",@"iPhone6 Plus",@"iPhone6s",@"其他"];
        XJYPieItem *item1 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:20.9] color:colorArray[0] dataDescribe:dataArray[0]];
            [pieItems addObject:item1];
        XJYPieItem *item2 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:14.82] color:colorArray[1] dataDescribe:dataArray[1]];
        [pieItems addObject:item2];
        XJYPieItem *item3 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:13.43] color:colorArray[2] dataDescribe:dataArray[2]];
        [pieItems addObject:item3];
        XJYPieItem *item4 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:52] color:colorArray[3] dataDescribe:dataArray[3]];
        [pieItems addObject:item4];
        
        //设置dataItemArray 
        self.pieChartView.dataItemArray = pieItems;
        
        [self.contentView addSubview:self.pieChartView];
    }
    
    return self;
}
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {

    [_pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [super updateConstraints];
    //必须要保证在布局成功后，bounds确定后，再来计算点
}

- (UIColor *)randomColor {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
