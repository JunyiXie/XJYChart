# XJYChart


## A High-performance, Elegant And Easy-to-integrate Charting Framework.

![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image1.PNG) ![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image2.PNG)




## Update 
**📊The chart has changed.Currently fixed color.**
**Is currently iterating to upgrade so temporarily delete XYChart If you want to try, you can pull from Example.**

### Update 1.1 Added slippery  graph

### SLide XXLineChart
```objectivec
        for (int j = 0; j<5; j++) {
            NSMutableArray *numberArray = [NSMutableArray new];
            for (int i = 0; i<100; i++) {
                int num = [[RandomNumerHelper shareRandomNumberHelper] randomNumberSmallThan:14] * [[RandomNumerHelper shareRandomNumberHelper] randomNumberSmallThan:14];
                NSNumber *number = [NSNumber numberWithInt:num];
                [numberArray addObject:number];
            }
            [numbersArray addObject:numberArray];
        }
        for (int i = 0; i<5; i++) {
            XXLineChartItem *item = [[XXLineChartItem alloc] initWithDataNumberArray:numbersArray[i] color:[UIColor redColor] dataDescribe:@"111"];
            [itemArray addObject:item];
        }
        XXLineChart *lineChart = [[XXLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray dataDiscribeArray:@[@"312312",@"123123"] topNumber:@200 bottomNumber:@0];
```

### SLide XXBarChart
```objectivec
NSMutableArray *itemArray = [[NSMutableArray alloc] init];
XJYBarItem *item1 = [[XJYBarItem alloc] initWithDataNumber:@(0.93) color:[UIColor greenColor] dataDescribe:@"MAC Os"];
[itemArray addObject:item1];
XJYBarItem *item2 = [[XJYBarItem alloc] initWithDataNumber:@(7.04) color:[UIColor greenColor] dataDescribe:@"Win10"];
[itemArray addObject:item2];
XJYBarItem *item3 = [[XJYBarItem alloc] initWithDataNumber:@(4.99) color:[UIColor redColor] dataDescribe:@"Win8"];
[itemArray addObject:item3];
XJYBarItem *item4 = [[XJYBarItem alloc] initWithDataNumber:@(28.48) color:[UIColor greenColor] dataDescribe:@"WinXP"];
[itemArray addObject:item4];
XJYBarItem *item5 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:[UIColor greenColor] dataDescribe:@"Win7"];
[itemArray addObject:item5];

XJYBarItem *item6 = [[XJYBarItem alloc] initWithDataNumber:@(0.93) color:[UIColor greenColor] dataDescribe:@"MAC Os"];
[itemArray addObject:item6];
XJYBarItem *item7 = [[XJYBarItem alloc] initWithDataNumber:@(7.04) color:[UIColor greenColor] dataDescribe:@"Win10"];
[itemArray addObject:item7];
XJYBarItem *item8 = [[XJYBarItem alloc] initWithDataNumber:@(4.99) color:[UIColor redColor] dataDescribe:@"Win8"];
[itemArray addObject:item8];
XJYBarItem *item9 = [[XJYBarItem alloc] initWithDataNumber:@(28.48) color:[UIColor greenColor] dataDescribe:@"WinXP"];
[itemArray addObject:item9];
XJYBarItem *item10 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:[UIColor greenColor] dataDescribe:@"Win7"];
[itemArray addObject:item10];

XXBarChart *barChart = [[XXBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@100 bottomNumber:@0];

[self.contentView addSubview:barChart];

```

## Use
（引入了 Masonry）

1. **Drag XJYChart into the project**
2. #import "XJYChart.h"

### Linechart
```objectivec

XJYLineChartView *lineChartView = [[XJYLineChartView alloc] init];
[lineChartView setTop:@40];
[lineChartView setBottom:@0];
[lineChartView setVerticalNumberDataArray:[[NSMutableArray alloc] initWithObjects:@[@30,@28,@26,@24,@23.5,@23.2],@[@3,@4,@5,@5.5,@6,@6.7],@[@25,@24,@23,@21,@20,@19.7], nil]];
[lineChartView setLevelDataArray:[[NSMutableArray alloc] initWithObjects:@"5月",@"6月",@"7月",@"8月",@"9月",@"10月", nil]];
[lineChartView setLineColorArray:[[NSMutableArray alloc] initWithObjects:XJYGreen,[UIColor purpleColor], [UIColor orangeColor], nil]];
[lineChartView setPointColorArray:[[NSMutableArray alloc] initWithObjects:XJYBlue,XJYRed, XJYBrown, nil]];
[lineChartView setDataNameArray:[[NSMutableArray alloc] initWithObjects:@"Win7",@"Win10",@"WinXP", nil]];
[lineChartView setChartBackgroundColor:[UIColor whiteColor]];


```

### PieChart

```objectivec

self.pieChartView = [[XJYPieChart alloc] init];
NSMutableArray *pieItems = [[NSMutableArray alloc] init];
NSArray *colorArray = @[XJYRed,XJYGreen,XJYBrown,XJYBlue];
NSArray *dataArray = @[@"iPhone6",@"iPhone6 Plus",@"iPhone6s",@"其他"];
XJYPieItem *item1 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:20.9] color:colorArray[0] dataDescribe:dataArray[0]];
[pieItems addObject:item1];
XJYPieItem *item2 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:14.82] color:colorArray[1] dataDescribe:dataArray[1]];
[pieItems addObject:item2];
XJYPieItem *item3 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:13.43] color:colorArray[2] dataDescribe:dataArray[2]];
[pieItems addObject:item3];
XJYPieItem *item4 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:52] color:colorArray[3] dataDescribe:dataArray[3]];
[pieItems addObject:item4];

self.pieChartView.dataItemArray = pieItems;

```

### BarChart

```objectivec

NSMutableArray *itemArray = [[NSMutableArray alloc] init];
XJYBarItem *item1 = [[XJYBarItem alloc] initWithDataNumber:@(0.93) color:[UIColor greenColor] dataDescribe:@"MAC Os"];
[itemArray addObject:item1];
XJYBarItem *item2 = [[XJYBarItem alloc] initWithDataNumber:@(7.04) color:[UIColor greenColor] dataDescribe:@"Win10"];
[itemArray addObject:item2];
XJYBarItem *item3 = [[XJYBarItem alloc] initWithDataNumber:@(4.99) color:[UIColor redColor] dataDescribe:@"Win8"];
[itemArray addObject:item3];
XJYBarItem *item4 = [[XJYBarItem alloc] initWithDataNumber:@(28.48) color:[UIColor greenColor] dataDescribe:@"WinXP"];
[itemArray addObject:item4];
XJYBarItem *item5 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:[UIColor greenColor] dataDescribe:@"Win7"];
[itemArray addObject:item5];

XJYBarItem *item6 = [[XJYBarItem alloc] initWithDataNumber:@(0.93) color:[UIColor greenColor] dataDescribe:@"MAC Os"];
[itemArray addObject:item6];
XJYBarItem *item7 = [[XJYBarItem alloc] initWithDataNumber:@(7.04) color:[UIColor greenColor] dataDescribe:@"Win10"];
[itemArray addObject:item7];
XJYBarItem *item8 = [[XJYBarItem alloc] initWithDataNumber:@(4.99) color:[UIColor redColor] dataDescribe:@"Win8"];
[itemArray addObject:item8];
XJYBarItem *item9 = [[XJYBarItem alloc] initWithDataNumber:@(28.48) color:[UIColor greenColor] dataDescribe:@"WinXP"];
[itemArray addObject:item9];
XJYBarItem *item10 = [[XJYBarItem alloc] initWithDataNumber:@(52.91) color:[UIColor greenColor] dataDescribe:@"Win7"];
[itemArray addObject:item10];

self.barChart = [[XJYBarChart alloc] initWithFrame:CGRectZero dataItemArray:itemArray topNumber:@60 bottomNumber:@0];

```

### Example 
Directly Run To See XJYChart Example
