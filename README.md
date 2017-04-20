###### XJYChart

漂亮的图表框架。支持动画，点击，滑动，区域高亮。 
一个高性能，优雅，使用简单。

 A High-performance, Elegant And Easy-to-integrate Charting Framework.

![gif](https://github.com/JunyiXie/XJYChart/raw/master/photos/XJYChart.gif)



 Update 0.0.2

Clear abandoned API

 Update :
Add The positive and negative Bar Chart**

增加了正负条形图
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image6.PNG)




###### Installation With Cocoapods
```
pod 'XJYChart'
```

How to Use


###### XXPositiveNegativeBarChart

```objectivec
XXPositiveNegativeBarChart *barChart = [[XXPositiveNegativeBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@100 bottomNumber:@(-170)];
```

###### XXLineChart

- XXColorModel:颜色是 随机显示／指定
- frame:图表的frame
- dataItemArray:每条线的item
- dateDescribeArray:每条线的描述
- topNumber:纵坐标最大值
- bottomNumber:纵坐标最小值

```objectivec
/**
XXLineChart初始化方法
*/
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray dataDiscribeArray:(NSMutableArray<NSString *> *)dataDiscribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber;
```

**XXLineChartItem**

- numberArray:一条线上的所有数值
- color:该线的颜色
- dataDescribe:数值在横坐标上的描述

```objectivec
- (instancetype)initWithDataNumberArray:(NSMutableArray *)numberArray color:(UIColor *)color dataDescribe:(NSString *)dataDescribe;
```


```objectivec
XXLineChart *lineChart = [[XXLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray dataDiscribeArray:[NSMutableArray arrayWithArray:@[@"January", @"February", @"March", @"April", @"May"]] topNumber:@200 bottomNumber:@0];
```



###### PieChart

```objectivec

self.pieChartView = [[XJYPieChart alloc] init];
NSMutableArray *pieItems = [[NSMutableArray alloc] init];

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
        

```

###### ChartColor 
Provide many colors In XJYColor.h
XJYSkyBlue
XJYGrey
XJYLightBlue
...


###### Update 

###### Update 1.1 
CoreText绘制坐标 优化性能
图表增加了滑动和动画效果
Added slippery graph And Chart Animations
Example 

直接运行就可以看到示例
Directly Run To See XJYChart Example

![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image1.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image3.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image4.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image5.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image6.PNG)

