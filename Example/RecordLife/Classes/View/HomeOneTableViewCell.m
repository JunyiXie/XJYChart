//
//  HomeOneTableViewCell.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "HomeOneTableViewCell.h"
@interface HomeOneTableViewCell ()

//@property (nonatomic, strong) XJYLineChartView *lineChartView;
@end

@implementation HomeOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
//        _lineChartView = [[XJYLineChartView alloc] init];
//        //设置纵坐标最大值
//        [_lineChartView setTop:@40];
//        //设置纵坐标最小值
//        [_lineChartView setBottom:@0];
//        //设置数据，二维数组
//        [_lineChartView setVerticalNumberDataArray:[[NSMutableArray alloc] initWithObjects:@[@30,@28,@26,@24,@23.5,@23.2],@[@3,@4,@5,@5.5,@6,@6.7],@[@25,@24,@23,@21,@20,@19.7], nil]];
//        //设置横坐标label的值
//        [_lineChartView setLevelDataArray:[[NSMutableArray alloc] initWithObjects:@"5月",@"6月",@"7月",@"8月",@"9月",@"10月", nil]];
//        //设置线的颜色
//        [_lineChartView setLineColorArray:[[NSMutableArray alloc] initWithObjects:XJYGreen,[UIColor purpleColor], [UIColor orangeColor], nil]];
//        //设置点的颜色
//        [_lineChartView setPointColorArray:[[NSMutableArray alloc] initWithObjects:XJYBlue,XJYRed, XJYBrown, nil]];
//        //设置数据的名称
//        [_lineChartView setDataNameArray:[[NSMutableArray alloc] initWithObjects:@"Win7",@"Win10",@"WinXP", nil]];
//        //设置背景颜色
//        [_lineChartView setChartBackgroundColor:[UIColor whiteColor]];
//        
//        
//        
//        [self addSubview:_lineChartView];
//        
        

        
    }
    return self;
}
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
//    [_lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(10);
//        make.bottom.equalTo(self.mas_bottom).offset(-10);
//        make.left.equalTo(self.mas_left).offset(10);
//        make.right.equalTo(self.mas_right).offset(-10);
//    }];


    [super updateConstraints];
    //必须要保证在布局成功后，bounds确定后，再来计算点
}





@end
