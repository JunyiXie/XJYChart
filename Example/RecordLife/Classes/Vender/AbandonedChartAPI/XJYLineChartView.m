//
//  XJYLineChartView.m
//  RecordLife
//
//  Created by 谢俊逸 on 18/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYLineChartView.h"

@interface XJYLineChartView (){
    
    UIView *_lineInformationView;
    NSMutableArray<UIView *> *_lineColorViewArray;
}

@property (nonatomic, strong) XJYLineChart *lineChart;
@property (nonatomic, strong) NSMutableArray *dataNameLabelArray;



@end

@implementation XJYLineChartView

- (instancetype)init {
    if (self = [super init]) {
        _lineColorViewArray = [[NSMutableArray alloc] init];
        _lineInformationView = [[UIView alloc] init];
//        _lineInformationView.backgroundColor = [UIColor greenColor];
        [self addSubview:_lineInformationView];
        [self addSubview:self.lineChart];
        self.dataNameLabelArray = [[NSMutableArray alloc] init];
    }
    return self;
}




#pragma mark Auto Layout

- (void)updateConstraints {

    if (self.dataNameArray.count > 0) {
        [_lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(40);
            make.right.equalTo(self.mas_right).offset(-60);
            make.top.equalTo(self.mas_top).offset(3);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        }];
        
        [_lineInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-5);
            make.width.equalTo(@50);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        
        }];
        
        [_dataNameLabelArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:20 leadSpacing:20 tailSpacing:20];
        [_dataNameLabelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *label = obj;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@40);
                make.right.equalTo(_lineInformationView.mas_right).offset(0);
            }];
        }];
        
        [_lineColorViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *lineView = obj;
            UILabel *helpLayoutLabel = _dataNameLabelArray[idx];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(helpLayoutLabel.mas_bottom).offset(5);
                make.width.equalTo(helpLayoutLabel.mas_width);
                make.right.equalTo(helpLayoutLabel.mas_right);
                make.height.equalTo(@5);
            }];
        }];
        
    } else {
        [_lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(40);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top).offset(3);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        }];
    }

    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark Lazy Loading

- (XJYLineChart *)lineChart {
    if (!_lineChart) {
        _lineChart = [[XJYLineChart alloc] init];
    }
    return _lineChart;
}

- (void)setLevelDataArray:(NSMutableArray *)levelDataArray {
    _levelDataArray = levelDataArray;
    self.lineChart.levelDataArray = _levelDataArray;
}

- (void)setVerticalNumberDataArray:(NSMutableArray *)verticalNumberDataArray {
    _verticalNumberDataArray = verticalNumberDataArray;
    
    NSCAssert(verticalNumberDataArray.count <= 3, @"最大支持 三组数据");
    if (verticalNumberDataArray.count == 0){
        self.lineChart.verticalNumberDataArray = [[NSMutableArray alloc] init];
    }
    if (verticalNumberDataArray.count >= 1) {
        self.lineChart.verticalNumberDataArray = [_verticalNumberDataArray[0] copy];
    }
    if (verticalNumberDataArray.count >= 2) {
        self.lineChart.verticalSecondNumberDataArray = [_verticalNumberDataArray[1] copy];
    }
    if (verticalNumberDataArray.count == 3) {
        self.lineChart.verticalThirdNumberDataArray = [_verticalNumberDataArray[2] copy];
    }
    
    
}

- (void)setTop:(NSNumber *)top {
    _top = top;
    self.lineChart.top = _top;
}

- (void)setBottom:(NSNumber *)bottom {
    _bottom = bottom;
    self.lineChart.bottom = _bottom;

}

- (void)setLineColorArray:(NSMutableArray<UIColor *> *)lineColorArray {
    _lineColorArray = lineColorArray;
    if (lineColorArray.count == 0){
        self.lineChart.lineColor = [UIColor blackColor];
    }
    if (lineColorArray.count >= 1) {
        self.lineChart.lineColor = [lineColorArray[0] copy];
    }
    if (lineColorArray.count >= 2) {
        self.lineChart.secondLineColor = [lineColorArray[1] copy];
    }
    if (lineColorArray.count == 3) {
        self.lineChart.thirdLineColor = [lineColorArray[2] copy];
    }
    
}

- (void)setPointColorArray:(NSMutableArray<UIColor *> *)pointColorArray {
    _pointColorArray = pointColorArray;
    if (pointColorArray.count == 0){
        self.lineChart.pointColor = [UIColor redColor];
    }
    if (pointColorArray.count >= 1) {
        self.lineChart.pointColor = [pointColorArray[0] copy];
    }
    if (pointColorArray.count >= 2) {
        self.lineChart.secondPointColor = [pointColorArray[1] copy];
    }
    if (pointColorArray.count == 3) {
        self.lineChart.thirdPointColor = [pointColorArray[2] copy];
    }
}

- (void)setDataNameArray:(NSMutableArray<NSString *> *)dataNameArray {
    _dataNameArray = dataNameArray;
    if (dataNameArray.count > 0) {
        for (int i = 0; i < dataNameArray.count; i++) {
            
            //line 信息label
            UILabel * LevelLabel= [[UILabel alloc] init];
            LevelLabel.textAlignment=NSTextAlignmentCenter;
            LevelLabel.text = _dataNameArray[i];
//            LevelLabel.backgroundColor=[UIColor redColor];
            LevelLabel.textColor = UIColorFromRGBHex(0x333333);
            LevelLabel.font = [UIFont systemFontOfSize:12];
            [_dataNameLabelArray addObject:LevelLabel];
            [_lineInformationView addSubview:LevelLabel];
            
            //line 颜色视图
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = self.lineColorArray[i];
            [_lineColorViewArray addObject:lineView];
            [_lineInformationView addSubview:lineView];
        }
    }
}

- (void)setChartBackgroundColor:(UIColor *)chartBackgroundColor {
    _chartBackgroundColor = chartBackgroundColor;
    self.lineChart.backgroundColor = chartBackgroundColor;
}


@end
