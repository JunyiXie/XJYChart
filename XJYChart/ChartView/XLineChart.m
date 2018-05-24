//
//  XXLineChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XLineChart.h"
#import "OrdinateView.h"
#import "UIGestureRecognizer+XGesHelper.h"

// 这个类最好只关心LineChart这一抽象
// 这样不好，暴露了细节。
#import "XAreaLineChartConfiguration.h"
#import "XStackAreaLineChartConfiguration.h"

#define OrdinateWidth 30
#define LineChartViewTopInterval 10

@interface XLineChart ()

@property(nonatomic, strong) NSNumber* top;
@property(nonatomic, strong) NSNumber* bottom;
@property(nonatomic, strong) NSMutableArray<XLineChartItem*>* dataItemArray;
@property(nonatomic, strong) NSMutableArray<NSString*>* dataDescribeArray;

@property(nonatomic, strong) OrdinateView* ordinateView;
@property(nonatomic, strong) XLineChartView* lineChartView;

@end

@implementation XLineChart

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
            dataDiscribeArray:(NSMutableArray<NSString*>*)dataDiscribeArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
                    graphMode:(XLineGraphMode)graphMode {
  if (self = [super initWithFrame:frame]) {
    self.isAllowGesture = NO;
    self.top = topNumbser;
    self.bottom = bottomNumber;
    self.dataItemArray = dataItemArray;
    self.dataDescribeArray = dataDiscribeArray;
    self.lineGraphMode = graphMode;
    self.layer.masksToBounds = YES;
    [self addGesForView:self.lineChartView];
    self.lineChartView.layer.masksToBounds = YES;
    [self addSubview:self.ordinateView];
    [self addSubview:self.lineChartView];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
            dataDiscribeArray:(NSMutableArray<NSString*>*)dataDiscribeArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
                    graphMode:(XLineGraphMode)graphMode
           chartConfiguration:(XLineChartConfiguration*)configuration {
  if (self = [super initWithFrame:frame]) {
    self.configuration = configuration;
    self.isAllowGesture = NO;
    self.top = topNumbser;
    self.bottom = bottomNumber;
    self.dataItemArray = dataItemArray;
    self.dataDescribeArray = dataDiscribeArray;
    self.lineGraphMode = graphMode;
    self.layer.masksToBounds = YES;
    [self addGesForView:self.lineChartView];
    self.lineChartView.layer.masksToBounds = YES;
    [self addSubview:self.ordinateView];
    [self addSubview:self.lineChartView];
  }
  return self;
}
#pragma mark Ges

- (void)addGesForView:(UIView*)view {
  UIPinchGestureRecognizer* pinchGes =
      [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(pinchView:)];
  [view addGestureRecognizer:pinchGes];

  UITapGestureRecognizer* tapGes =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(tapView:)];
  tapGes.numberOfTapsRequired = 2;
  tapGes.numberOfTouchesRequired = 1;
  [view addGestureRecognizer:tapGes];
}
- (void)pinchView:(UIPinchGestureRecognizer*)pinchGes {
  if (self.isAllowGesture == NO) {
    return;
  }

  if (pinchGes.state == UIGestureRecognizerStateEnded) {
    CGAffineTransform transform = CGAffineTransformIdentity;
    pinchGes.view.transform = CGAffineTransformScale(transform, 1, 1);
  }
  pinchGes.view.transform = CGAffineTransformScale(
      pinchGes.view.transform, pinchGes.scale, pinchGes.scale);
  pinchGes.scale = 1;
}

- (void)tapView:(UITapGestureRecognizer*)tapGes {
  if (self.isAllowGesture == NO) {
    return;
  }

  if (tapGes.hasTapedBoolNumber.boolValue == YES) {
    CGAffineTransform transform = CGAffineTransformIdentity;
    tapGes.view.transform = transform;
    tapGes.hasTapedBoolNumber = [NSNumber numberWithBool:NO];
  } else {
    //每次缩放以上一次为标准
    tapGes.view.transform =
        CGAffineTransformScale(tapGes.view.transform, 1.5, 1.5);
    tapGes.hasTapedBoolNumber = [NSNumber numberWithBool:YES];
  }
}

#pragma mark Get

- (OrdinateView*)ordinateView {
  if (!_ordinateView) {
    _ordinateView = [[OrdinateView alloc]
        initWithFrame:CGRectMake(0, 0, OrdinateWidth, self.frame.size.height)
            topNumber:self.top
         bottomNumber:self.bottom
                     configuration:self.configuration];
  }
  return _ordinateView;
}

- (XLineChartView*)lineChartView {
  if (!_lineChartView) {
    _lineChartView = [[XLineChartView alloc]
            initWithFrame:CGRectMake(
                              OrdinateWidth, LineChartViewTopInterval,
                              self.frame.size.width - OrdinateWidth,
                              self.frame.size.height - LineChartViewTopInterval)
            dataItemArray:self.dataItemArray
        dataDescribeArray:self.dataDescribeArray
                topNumber:self.top
             bottomNumber:self.bottom
                graphMode:self.lineGraphMode
            configuration:self.configuration];

    _lineChartView.chartBackgroundColor = self.chartBackgroundColor;
  }
  return _lineChartView;
}

- (XLineChartConfiguration *)configuration {
  if (!_configuration) {
    
    switch (self.lineGraphMode) {
      case MutiLineGraph:
        _configuration = [XNormalLineChartConfiguration new];
        break;
      case AreaLineGraph:
        _configuration = [XAreaLineChartConfiguration new];
        break;
        
      case StackAreaLineGraph:
        _configuration = [XStackAreaLineChartConfiguration new];
        break;
      default:
        break;
    }
  }
  return _configuration;
}



@end
