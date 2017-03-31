# XJYChart

## 漂亮的图表框架。支持动画，点击，滑动，区域高亮。 

## 一个高性能，优雅，使用简单的图表框架。
## A High-performance, Elegant And Easy-to-integrate Charting Framework.

![gif](https://github.com/JunyiXie/XJYChart/raw/master/photos/XJYChart.gif)


![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image1.PNG)
 ![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image3.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image4.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image5.PNG)


## Update 

### Update 1.1 
**CoreText绘制坐标 优化性能**
### 图表增加了滑动和动画效果
### Added slippery graph And Chart Animations

### SLide XXLineChart
```objectivec
        XXLineChart *lineChart = [[XXLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray dataDiscribeArray:[NSMutableArray arrayWithArray:@[@"January", @"February", @"March", @"April", @"May"]] topNumber:@200 bottomNumber:@0];
```

### SLide XXBarChart
```objectivec
        XXBarChart *barChart = [[XXBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@80 bottomNumber:@0];

```

## Use
（引入了 Masonry）

1. **Drag XJYChart into the project**
2. #import "XJYChart.h"

### PieChart

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

### BarChart

```objectivec
        self.barChart = [[XJYBarChart alloc] initWithFrame:CGRectZero dataItemArray:itemArray topNumber:@60 bottomNumber:@0];


```

### Example 
直接运行就可以看到示例
Directly Run To See XJYChart Example
