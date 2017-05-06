//
//  SGLabel.m
//  SwiftGraphicsDemo
//
//  Created by 谢俊逸 on 30/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//



#import "SGLabel.h"
#import <CoreText/CoreText.h>
const CGFloat kGlobalLineLeading = 2.0;
const CGFloat kPerLineRatio = 1.4;
NSString *kAtRegularExpression = @"@[^\\s@]+?\\s{1}";
NSString *kNumberRegularExpression = @"\\d+[^\\d]{1}";

static NSString *AtRegularName = @"@name";
static NSString *NumberRegularName = @"continuousNumbers";

// 维护了一张表来实现
#pragma mark SpecialRangesTable
@interface SpecialRangesTable : NSObject
@property (nonatomic, assign) SGLabelRangeType type;
//RangeArray  @[startIndex, length]
@property (nonatomic, strong) NSMutableArray *rangeArray;
/**
 Range @[starIndex, length]

 @param range array
 */
- (void)addRange:(NSMutableArray *)range;

/**
 replace rangeArray

 @param rangeArray rangeArray
 */
- (void)updateRangeArray:(NSMutableArray *)rangeArray;
/**
 init

 @param type type
 @param rangeArray rangeArray
 @return instancetype
 */
- (instancetype)initWithRangeType:(SGLabelRangeType)type rangeArray:(NSMutableArray *)rangeArray;
@end

@implementation SpecialRangesTable

- (instancetype)initWithRangeType:(SGLabelRangeType)type rangeArray:(NSMutableArray *)rangeArray {
    if (self = [super init]) {
        self.type = type;
        self.rangeArray = [rangeArray copy];
    }
    return self;
}

- (void)addRange:(NSMutableArray *)range {
    [self.rangeArray addObject:range];
}

- (void)updateRangeArray:(NSMutableArray *)rangeArray {
    self.rangeArray = [rangeArray copy];
}
@end

#pragma mark SGLabel
@interface SGLabel ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) CTFrameRef ctFrame;

@property (nonatomic, strong) SpecialRangesTable *atRegularTable;
@property (nonatomic, strong) SpecialRangesTable *numberRegularTable;
@property (nonatomic, strong) NSArray *SpecialRangesTableArray;

@end


@implementation SGLabel

- (instancetype)init {
    if (self = [super init]) {

        
    }
    return self;
}

// 文字非 @"" 才会绘制
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    
        // 初始化表
        self.atRegularTable = [[SpecialRangesTable alloc] initWithRangeType:SGLabelRangeTypeAtRegularExpression rangeArray:[NSMutableArray new]];
        
        self.numberRegularTable = [[SpecialRangesTable alloc] initWithRangeType:SGLabelRangeNumberRegularExpression rangeArray:[NSMutableArray new]];
        
        // 把两种特殊的区域放到数组里
        self.SpecialRangesTableArray = @[self.atRegularTable,self.numberRegularTable];
        
        self.text = @"";
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text {
    if (self = [self initWithFrame:frame]) {
        self.text = text;
    }
    return self;
}

#pragma mark Setter

- (void)setText:(NSString *)text {
    _text = text;
    if (![_text  isEqual: @""]) {
        [self drawInBackgroundWithString:_text font:self.font];

    }
}

- (UIFont *)font {
    if (!_font) {
        _font = [UIFont systemFontOfSize:10];
    }
    return _font;
}


#pragma mark 给字符串添加全局属性，比如行距，字体大小，默认颜色

/**
 给整段文字添加行距，字体，颜色等属性，切记在设置特点属性前调用

 @param aContent content
 @param aFont font
 */
+ (void)addGlobalAttributeWithContent:(NSMutableAttributedString *)aContent font:(UIFont *)aFont
{
    CGFloat lineLeading = kGlobalLineLeading; // 行间距
    
    const CFIndex kNumberOfSettings = 2;
    
    
    CTParagraphStyleSetting lineBreakStyle;
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    lineBreakStyle.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakStyle.valueSize = sizeof(CTLineBreakMode);
    lineBreakStyle.value = &lineBreakMode;
    
    CTParagraphStyleSetting lineSpaceStyle;
    CTParagraphStyleSpecifier spec;
    spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    //    spec = kCTParagraphStyleSpecifierMaximumLineSpacing;
    //    spec = kCTParagraphStyleSpecifierMinimumLineSpacing;
    //    spec = kCTParagraphStyleSpecifierLineSpacing;
    
    lineSpaceStyle.spec = spec;
    lineSpaceStyle.valueSize = sizeof(CGFloat);
    lineSpaceStyle.value = &lineLeading;
    
    CTParagraphStyleSetting lineHeightStyle;
    lineHeightStyle.spec = kCTParagraphStyleSpecifierMinimumLineHeight;
    lineHeightStyle.valueSize = sizeof(CGFloat);
    lineHeightStyle.value = &lineLeading;
    
    // 结构体数组
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        
        lineBreakStyle,
        lineSpaceStyle,
        //        lineHeightStyle
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    
    // 将设置的行距应用于整段文字
    [aContent addAttribute:NSParagraphStyleAttributeName value:(__bridge id)(theParagraphRef) range:NSMakeRange(0, aContent.length)];
    
    
    CFStringRef fontName = (__bridge CFStringRef)aFont.fontName;
    CTFontRef fontRef = CTFontCreateWithName(fontName, aFont.pointSize, NULL);
    
    // 将字体大小应用于整段文字
    [aContent addAttribute:NSFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, aContent.length)];
    
    // 给整段文字添加默认颜色
    [aContent addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, aContent.length)];
    
    
    // 内存管理
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
}


// 简单的实现，保证高性能
// self.ctFrame 没有释放 放在dealloc 中释放
- (void)drawInBackgroundWithString:(NSString *)string font:(UIFont *)font {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 开辟一个图形上下文
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.bounds.size.width,self.bounds.size.height), NO, [UIScreen mainScreen].scale);
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextAddRect(con, self.bounds);
        
        CGContextSetFillColorWithColor(con, [UIColor whiteColor].CGColor);
        
        CGContextFillPath(con);
        
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
        //设置字体等信息
        [[self class] addGlobalAttributeWithContent:attributed font:font];
        //计算高度
        self.textHeight = [[self class] textHeightWithText3:self.text width:self.bounds.size.width font:self.font];
        //正则表达式匹配保存区域，改变特定区域颜色
        [self recognizeSpecialStringWithAttributed:attributed];
        
        //获取上下文
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        //转换坐标系
        CGContextSetTextMatrix(contextRef, CGAffineTransformIdentity);
        CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
        CGContextScaleCTM(contextRef, 1.0, -1.0);
        
        //创建绘制区域
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, self.bounds);
        //生成framesetter
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributed);
        self.ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributed.length), path, NULL);
        //赋值
        //绘制
        CTFrameDraw(self.ctFrame, contextRef);
        //释放
        CFRelease(path);
        CFRelease(framesetter);
        
        //放到dealloc
//        CFRelease(ctFrame);
        
        UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = im;
        });
    });

}

#pragma mark Touch
// 特地做了字典(Hash)来存储初始化时判断的特殊区域的 (name,[start,lenght])
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    //转CoreText坐标系
    CGPoint ctPoint = CGPointMake(currentPoint.x, self.bounds.size.
                                  height - currentPoint.y);
    
    
    CFArrayRef lines = CTFrameGetLines(self.ctFrame);
    CGPoint* lineOrigins = malloc(sizeof(CGPoint)*CFArrayGetCount(lines));
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0,0), lineOrigins);
    CGFloat lineHeight = self.font.pointSize * kPerLineRatio;
    //高度来除行高,currentPoint.y 可以当作行高
    int lineIndex = currentPoint.y/lineHeight;
    if (lineIndex < CFArrayGetCount(lines))
    {
        
        CTLineRef clickLine = CFArrayGetValueAtIndex(lines, lineIndex);
        // 点击处的字符位于总字符串的index
        //进行命中测试。
        //此功能可用于确定鼠标点击或其他事件的字符串索引。 此字符串索引对应于应插入下一个字符的字符。
        CFIndex strIndex = CTLineGetStringIndexForPosition(clickLine, ctPoint);
        [self.SpecialRangesTableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SpecialRangesTable *table = (SpecialRangesTable *)obj;
            NSMutableArray *rangeArray = table.rangeArray;
            [rangeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSNumber *start = ((NSArray *)obj)[0];
                NSNumber *length = ((NSArray *)obj)[1];
                if (strIndex >= start.intValue && strIndex <= start.intValue + length.intValue) {
                    // 调用 委托方法
                    [self.sgLabelDelegate touchUpInsideSpecialRangeType:table.type];
                }
            }];
        }];
    }
}

#pragma mark Helper

/**
 *  高度 = 每行的asent + 每行的descent + 行数*行间距
 *  行间距为指定的数值
 */
+ (CGFloat)textHeightWithText3:(NSString *)aText width:(CGFloat)aWidth font:(UIFont *)aFont
{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:aText];
    
    // 设置全局样式
    [self addGlobalAttributeWithContent:content font:aFont];
    
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    CGSize suggestSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, aText.length), NULL, CGSizeMake(aWidth, MAXFLOAT), NULL);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, aWidth, suggestSize.height*10)); // 10这个数值是随便给的，主要是为了确保高度足够
    
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, aText.length), path, NULL);
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    
    CGFloat ascent = 0;
    CGFloat descent = 0;
    CGFloat leading = 0;
    
    CGFloat totalHeight = 0;
    
    for (CFIndex i = 0; i < lineCount; i++)
    {
        
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        
        CTLineGetTypographicBounds(lineRef, &ascent, &descent, &leading);
        
        
        totalHeight += ascent + descent;
        
    }
    
    leading = kGlobalLineLeading; // 行间距，
    
    totalHeight += (lineCount ) * leading;
    
    
    
    
    return totalHeight;
}


#pragma mark - 识别特定字符串并改其颜色，返回识别到的字符串所在的range
- (void)recognizeSpecialStringWithAttributed:(NSMutableAttributedString *)attributed
{
    NSMutableArray *rangeArray = [NSMutableArray array];
    
    // @name
    NSRegularExpression *atRegular = [NSRegularExpression regularExpressionWithPattern:kAtRegularExpression options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *atResults = [atRegular matchesInString:self.text options:NSMatchingWithTransparentBounds range:NSMakeRange(0, self.text.length)];
    
    for (NSTextCheckingResult *checkResult in atResults)
    {
        if (attributed)
        {
            [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(checkResult.range.location, checkResult.range.length -1)];
        }
        
        [rangeArray addObject:@[@(checkResult.range.location), @(checkResult.range.length)]];
    }
    if (rangeArray.count > 0) {
        [self.atRegularTable updateRangeArray:rangeArray];
    }
    

    [rangeArray removeAllObjects];
    // numbers
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:kNumberRegularExpression options:NSRegularExpressionCaseInsensitive|NSRegularExpressionUseUnixLineSeparators error:nil];
    
    NSArray *numberResults = [numberRegular matchesInString:self.text options:NSMatchingWithTransparentBounds range:NSMakeRange(0, self.text.length)];
    
    for (NSTextCheckingResult *checkResult in numberResults)
    {
        if (attributed)
        {
            [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(checkResult.range.location, checkResult.range.length-1)];
        }
        [rangeArray addObject:@[@(checkResult.range.location), @(checkResult.range.length -1)]];
    }

    if (rangeArray.count > 0) {
        [self.numberRegularTable updateRangeArray:rangeArray];
    }
    
}

#pragma mark 生命周期
- (void)dealloc {
    
    CFRelease(self.ctFrame);
}
@end
