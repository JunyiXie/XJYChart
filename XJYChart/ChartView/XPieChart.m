//
//  XJYPieChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 22/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XPieChart.h"
#import "XAuxiliaryCalculationHelper.h"

@interface XPieChart ()<CAAnimationDelegate>

@property(nonatomic, strong) NSNumber* radius;

@property(nonatomic, strong) CAShapeLayer* pieLayer;
@property(nonatomic, strong) CAShapeLayer* pieCenterMaskLayer;
@property(nonatomic, strong) CAShapeLayer* pieAnimationMaskLayer;
@property(nonatomic, strong) CAShapeLayer* heightLightSector;
@property(nonatomic, strong) NSMutableDictionary* selectedItems;
@property(nonatomic, strong) UIView* contentView;
@property(nonatomic, strong) UIView* informationView;
@property(nonatomic, assign) CGFloat outerRadius;
@property(nonatomic, assign) CGFloat innerRadius;
@property(nonatomic, strong) NSMutableArray<UIColor*>* colorArray;
@property(nonatomic, strong) NSMutableArray<NSString*>* dataDescribeArray;
@property(nonatomic, strong) NSMutableArray<NSNumber*>* dataNumberArray;
@property(nonatomic, strong) NSMutableArray<UILabel*>* labelArray;
@property(nonatomic, strong) NSMutableArray<NSNumber*>* strokeStartArray;
@property(nonatomic, strong) NSMutableArray<NSNumber*>* strokeEndArray;

@end

@implementation XPieChart

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.enableAnimation = YES;
    self.shouldHighlightSectorOnTouch = YES;
    self.enableMultipleSelection = NO;
    self.hideValueLabels = NO;
    self.showAbsoluteValues = NO;
    self.onlyShowValues = NO;

    self.descriptionTextShadowColor = [UIColor clearColor];
    self.descriptionTextShadowOffset = CGSizeMake(0, 0);

    self.descriptionTextColor = [UIColor blackColor];
    self.descriptionTextFont = [UIFont systemFontOfSize:10];
    self.dataItemArray = [[NSMutableArray alloc] init];
    self.colorArray = [[NSMutableArray alloc] init];
    self.dataNumberArray = [[NSMutableArray alloc] init];
    self.dataDescribeArray = [[NSMutableArray alloc] init];
    self.strokeEndArray = [[NSMutableArray alloc] init];
    self.strokeStartArray = [[NSMutableArray alloc] init];
    self.labelArray = [[NSMutableArray alloc] init];
    
    self.contentView = [[UIView alloc] init];

    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

- (instancetype)init {
  if (self = [super init]) {
  }
  return self;
}
- (void)cleanPreDraw {
  [self.dataNumberArray removeAllObjects];
  [self.colorArray removeAllObjects];
  [self.dataDescribeArray removeAllObjects];
  [self.pieLayer removeFromSuperlayer];
  [self.heightLightSector removeFromSuperlayer];
  [self.labelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj removeFromSuperview];
  }];
  [self.labelArray removeAllObjects];
  
}

- (void)strokePie {
  CGFloat diameter = (CGRectGetWidth(self.bounds) < CGRectGetWidth(self.bounds))
                         ? CGRectGetWidth(self.bounds)
                         : CGRectGetHeight(self.bounds);
  self.radius = @(diameter / 2);
  self.outerRadius = diameter / 2;
  self.innerRadius = diameter / 6;

  //从Items 中提取数据
  [self.dataItemArray
      enumerateObjectsUsingBlock:^(XPieItem* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [self.dataNumberArray addObject:obj.dataNumber];
        [self.colorArray addObject:obj.color];
        [self.dataDescribeArray addObject:obj.dataDescribe];
      }];

  //绘制基础饼
  self.pieLayer = [self
      newCircleLayerWithRadius:((self.outerRadius - self.innerRadius) / 2 +
                                self.innerRadius)
                   borderWidth:(self.outerRadius - self.innerRadius)
                     fillColor:[UIColor greenColor]
                   borderColor:[UIColor greenColor]
               startPercentage:0
                 endPercentage:1];
  [self.contentView.layer addSublayer:_pieLayer];

  //计算开始点
  self.strokeStartArray = [[XAuxiliaryCalculationHelper shareCalculationHelper]
      computeStrokeStartArrayWithDataArray:self.dataNumberArray];

  //计算结束点
  self.strokeEndArray = [[XAuxiliaryCalculationHelper shareCalculationHelper]
      computeStrokeEndArrayWithDataArray:self.dataNumberArray];

  //绘制各个部分,添加到pieLayer上
  for (int i = 0; i < self.dataItemArray.count; i++) {
    CAShapeLayer* layer = [self
        newCircleLayerWithRadius:((self.outerRadius - self.innerRadius) / 2 +
                                  self.innerRadius)
                     borderWidth:(self.outerRadius - self.innerRadius)
                       fillColor:[UIColor clearColor]
                     borderColor:self.colorArray[i]
                 startPercentage:self.strokeStartArray[i].doubleValue
                   endPercentage:self.strokeEndArray[i].doubleValue];
    [self.pieLayer addSublayer:layer];
  }

  //绘制中心空缺
  self.pieCenterMaskLayer = [self newCircleLayerWithRadius:self.innerRadius
                                               borderWidth:0
                                                 fillColor:[UIColor whiteColor]
                                               borderColor:[UIColor blackColor]
                                           startPercentage:0
                                             endPercentage:1];
  [self.pieLayer addSublayer:_pieCenterMaskLayer];

  if (self.enableAnimation) {
    [self addAnimationMask];
  }
  //描述Label
  [self.dataItemArray
      enumerateObjectsUsingBlock:^(XPieItem* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        UILabel *label = [self descriptionLabelForItemAtIndex:idx];
        [self.labelArray addObject:label];
        [self.contentView addSubview:label];
      }];
}

#pragma mark Pie Animation
- (void)addAnimationMask {
  CGFloat radius = _innerRadius + (_outerRadius - _innerRadius) / 2;
  CGFloat borderWidth = _outerRadius - _innerRadius;
  CAShapeLayer* maskLayer = [self newCircleLayerWithRadius:radius
                                               borderWidth:borderWidth
                                                 fillColor:[UIColor clearColor]
                                               borderColor:[UIColor blackColor]
                                           startPercentage:0
                                             endPercentage:1];

  _pieLayer.mask = maskLayer;
  [self pieAnimation];
}

- (void)pieAnimation {
  CABasicAnimation* animation =
      [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  animation.duration = 2;
  animation.fromValue = @0;
  animation.toValue = @1;
  animation.delegate = self;
  animation.timingFunction = [CAMediaTimingFunction
      functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.removedOnCompletion = YES;
  [_pieLayer.mask addAnimation:animation forKey:@"circleAnimation"];
}

#pragma mark Layout Subviews
// the default implementation uses any constraints you have set to determine the
// size and position of any subviews.
- (void)layoutSubviews {
  [super layoutSubviews];
  [self cleanPreDraw];
  [self strokePie];
}

#pragma mark AutoLayout

+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

- (void)updateConstraints {
  [super updateConstraints];

  [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];

  NSLayoutConstraint* topCons =
      [NSLayoutConstraint constraintWithItem:self.contentView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1.0
                                    constant:0];
  NSLayoutConstraint* leftCons =
      [NSLayoutConstraint constraintWithItem:self.contentView
                                   attribute:NSLayoutAttributeLeft
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeLeft
                                  multiplier:1.0
                                    constant:0];
  NSLayoutConstraint* rightCons =
      [NSLayoutConstraint constraintWithItem:self.contentView
                                   attribute:NSLayoutAttributeRight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeRight
                                  multiplier:1.0
                                    constant:0];
  NSLayoutConstraint* bottomCons =
      [NSLayoutConstraint constraintWithItem:self.contentView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                    constant:0];
  NSArray* consA = @[ topCons, leftCons, rightCons, bottomCons ];
  [self addConstraints:consA];
}

#pragma mark Touch handle

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
  for (UITouch* touch in touches) {
    [self XJYTouchHandle:touch];
  }
}

//判断触摸所在区域 并且高亮扇区
- (void)XJYTouchHandle:(UITouch*)touch {
  CGPoint touchLocation = [touch locationInView:self.contentView];
  CGPoint circleCenter = CGPointMake(_contentView.bounds.size.width / 2,
                                     _contentView.bounds.size.height / 2);
  CGFloat distanceFromCenter =
      sqrtf(powf((touchLocation.y - circleCenter.y), 2) +
            powf((touchLocation.x - circleCenter.x), 2));
  if (distanceFromCenter < _innerRadius) {
    if ([self.delegate respondsToSelector:@selector(didUnselectPieItem)]) {
      [self.delegate didUnselectPieItem];
    }
    [self.heightLightSector removeFromSuperlayer];
    return;
  }

  CGFloat percentage = [[XAuxiliaryCalculationHelper shareCalculationHelper]
      findPercentageOfAngleInCircle:circleCenter
                          fromPoint:touchLocation];

  __block NSUInteger selectorAreaIdx = 0;
  [self.strokeEndArray
      enumerateObjectsUsingBlock:^(NSNumber* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        if (percentage < obj.doubleValue) {
          selectorAreaIdx = idx;
          *stop = YES;
        }
      }];

  if ([self.delegate
          respondsToSelector:@selector(userClickedOnPieIndexItem:)]) {
    [self.delegate userClickedOnPieIndexItem:selectorAreaIdx];
  }

  if (self.shouldHighlightSectorOnTouch) {
    if (!self.enableMultipleSelection) {
      if (self.heightLightSector)
        [self.heightLightSector removeFromSuperlayer];
    }

    XPieItem* selectItem = self.dataItemArray[selectorAreaIdx];

    CGFloat red, green, blue, alpha;
    UIColor* old = selectItem.color;
    [old getRed:&red green:&green blue:&blue alpha:&alpha];
    alpha /= 2;
    UIColor* newColor =
        [UIColor colorWithRed:red green:green blue:blue alpha:alpha];

    CGFloat startPercentage =
        self.strokeStartArray[selectorAreaIdx].doubleValue;
    CGFloat endPercentage = self.strokeEndArray[selectorAreaIdx].doubleValue;

    self.heightLightSector = [self newCircleLayerWithRadius:_outerRadius + 5
                                                borderWidth:10
                                                  fillColor:[UIColor clearColor]
                                                borderColor:newColor
                                            startPercentage:startPercentage
                                              endPercentage:endPercentage];

    if (self.enableMultipleSelection) {
      NSString* dictIndex =
          [NSString stringWithFormat:@"%lu", (unsigned long)selectorAreaIdx];
      CAShapeLayer* indexShape = [self.selectedItems valueForKey:dictIndex];
      if (indexShape) {
        [indexShape removeFromSuperlayer];
        [self.selectedItems removeObjectForKey:dictIndex];
      } else {
        [self.selectedItems setObject:self.heightLightSector forKey:dictIndex];
        [_contentView.layer addSublayer:self.heightLightSector];
      }
    } else {
      [_contentView.layer addSublayer:self.heightLightSector];
    }
  }
}

#pragma mark Help Methods

- (CAShapeLayer*)newCircleLayerWithRadius:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                                fillColor:(UIColor*)fillColor
                              borderColor:(UIColor*)borderColor
                          startPercentage:(CGFloat)startPercentage
                            endPercentage:(CGFloat)endPercentage {
  CAShapeLayer* circle = [CAShapeLayer layer];

  CGPoint center =
      CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

  UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:center
                                                      radius:radius
                                                  startAngle:-M_PI_2
                                                    endAngle:M_PI_2 * 3
                                                   clockwise:YES];

  circle.fillColor = fillColor.CGColor;
  circle.strokeColor = borderColor.CGColor;
  circle.strokeStart = startPercentage;
  circle.strokeEnd = endPercentage;
  circle.lineWidth = borderWidth;
  circle.path = path.CGPath;

  return circle;
}

#pragma mark Describe Label

- (UILabel*)descriptionLabelForItemAtIndex:(NSUInteger)index {
  XPieItem* currentDataItem = self.dataItemArray[index];
  CGFloat distance = _innerRadius + (_outerRadius - _innerRadius) / 2;
  CGFloat centerPercentage = (self.strokeStartArray[index].doubleValue +
                              self.strokeEndArray[index].doubleValue) /
                             2;
  CGFloat rad = centerPercentage * 2 * M_PI;

  UILabel* descriptionLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
  NSString* titleText = currentDataItem.dataDescribe;

  NSString* titleValue;

  if (self.showAbsoluteValues) {
    titleValue = [NSString
        stringWithFormat:@"%.0f", currentDataItem.dataNumber.doubleValue];
  } else {
    titleValue = [NSString
        stringWithFormat:@"%.0f%%", (self.strokeEndArray[index].doubleValue -
                                     self.strokeStartArray[index].doubleValue) *
                                        100];
  }

  if (self.hideValueLabels)
    descriptionLabel.text = titleText;
  else if (!titleText || self.onlyShowValues)
    descriptionLabel.text = titleValue;
  else {
    NSString* str = [titleValue
        stringByAppendingString:[NSString stringWithFormat:@"\n%@", titleText]];
    descriptionLabel.text = str;
  }

  CGPoint center =
      CGPointMake(self.bounds.size.width / 2 + distance * sin(rad),
                  self.bounds.size.height / 2 - distance * cos(rad));

  descriptionLabel.font = _descriptionTextFont;
  CGSize labelSize = [descriptionLabel.text
      sizeWithAttributes:@{NSFontAttributeName : descriptionLabel.font}];
  descriptionLabel.frame = CGRectMake(
      descriptionLabel.frame.origin.x, descriptionLabel.frame.origin.y,
      descriptionLabel.frame.size.width, labelSize.height);
  descriptionLabel.numberOfLines = 0;
  descriptionLabel.textColor = _descriptionTextColor;
  descriptionLabel.shadowColor = _descriptionTextShadowColor;
  descriptionLabel.shadowOffset = _descriptionTextShadowOffset;
  descriptionLabel.textAlignment = NSTextAlignmentCenter;
  descriptionLabel.center = center;
  descriptionLabel.alpha = 1;
  descriptionLabel.backgroundColor = [UIColor clearColor];
  return descriptionLabel;
}

#pragma mark Refresh
- (void)refreshChart {
  [self cleanPreDraw];
  [self strokePie];
}

@end
