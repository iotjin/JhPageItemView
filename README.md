# JhPageItemView
JhPageItemView - UIcollectionView横向滚动分页,<br> 
UICollectionViewLayout两种样式(系统样式,自定义的横排样式),<br> 
系统样式类似于淘宝我的频道,自定义横排样式类似美团,美团外卖横排菜单。<br> 
pageControl三种样式(小圆点,长条,小圆点+长条 ),也可设置位置(左中右)。

![](https://raw.githubusercontent.com/iotjin/JhPageItemView/master/JhPageItemView/screenshots/1.png)  <br> 
![](https://raw.githubusercontent.com/iotjin/JhPageItemView/master/JhPageItemView/screenshots/gif0.gif)  

## Examples



* Demo1

```
@property (nonatomic, strong) JhPageItemView *pageItemView;

-(JhPageItemView *)pageItemView{
    if (!_pageItemView) {
        
        CGRect femwe =  CGRectMake(0, 100, Kwidth, 90*2+3*2+5*2);
        JhPageItemView *view =  [[JhPageItemView alloc]initWithFrame:femwe withmaxColumn:5 maxRow:2];
        view.backgroundColor = [UIColor redColor];
        view.kTopBottomMargin = 3;//上下距离初始位置间距
        view.kLeftRightMargin = 10;//左右距离初始位置间距
        view.itemHorizontalMargin = 5.f;
        view.itemVerticalMargin = 5.f;
        view.current_BGColor=[UIColor greenColor];
        view.layoutStyle = JhSystemHorizontalArrangement;
        view.delegate =self;
        self.pageItemView = view;
        [self.view addSubview: self.pageItemView];
        
    }
    return _pageItemView;
}


     
    //UIcollectionview 默认样式
    [self pageItemView];
    self.pageItemView.dataArray = self.dataArray;


```
* Demo2

```
@property (nonatomic, strong) JhPageItemView *pageItemView2;

-(JhPageItemView *)pageItemView2{
    if (!_pageItemView2) {
        
        CGRect femwe =  CGRectMake(0, 350, Kwidth, 90*2+5*2+5*2);
        JhPageItemView *view =  [[JhPageItemView alloc]initWithFrame:femwe withmaxColumn:5 maxRow:2];
        view.backgroundColor = [UIColor redColor];
        view.kTopBottomMargin = 5;//上下距离初始位置间距
        view.kLeftRightMargin = 10;
        view.itemHorizontalMargin = 5.f;
        view.itemVerticalMargin = 5.f;
        view.current_BGColor=[UIColor yellowColor];
        view.layoutStyle = JhCustomHorizontalArrangement;
        
        view.PageControlStyle = JhPageControlStyelDotAndRectangle;//圆点 + 长条 样式
        view.PageControlContentMode = JhPageControlContentModeRight;
        view.PageControlMarginSpacing = 10;
        view.PageControlSpacing = 5;

        view.delegate =self;
        self.pageItemView2 = view;
        [self.view addSubview: self.pageItemView2];
        
    }
    return _pageItemView2;
}


    // 自定义样式
    [self pageItemView2];
    self.pageItemView2.dataArray = self.dataArray;


```
* Demo3

```
@property (nonatomic, strong) JhPageItemView *pageItemView3;

-(JhPageItemView *)pageItemView3{
    if (!_pageItemView3) {
        
        CGRect femwe =  CGRectMake(0, 600, Kwidth, 90*1+5*2+5*2);
        JhPageItemView *view =  [[JhPageItemView alloc]initWithFrame:femwe withmaxColumn:5 maxRow:1];
        view.backgroundColor = [UIColor redColor];
        view.kTopBottomMargin = 5; //上下距离初始位置间距
        view.kLeftRightMargin = 10;//左右距离初始位置间距
        view.itemHorizontalMargin = 5.f;
        view.itemVerticalMargin = 5.f;
        view.current_BGColor = [UIColor greenColor];
        
        view.layoutStyle = JhCustomHorizontalArrangement;
        view.PageControlContentMode = JhPageControlContentModeLeft;
        view.PageControlStyle = JhPageControlStyelRectangle;//长条样式
        view.PageControlMarginSpacing =10;
        view.PageControlSpacing = 5;
        
        view.delegate =self;
        self.pageItemView3 = view;
        [self.view addSubview: self.pageItemView3];
        
//        view.pageControlIsHidden = YES;//是否隐藏
        
    }
    return _pageItemView3;
}


    // 自定义样式
    [self pageItemView3];
    self.pageItemView3.dataArray = self.dataArray;


```

* 点击事件

```

- (void)JhPageItemViewDelegate:(JhPageItemView *)JhPageItemViewDeleagte indexPath:(NSIndexPath * )indexPath{
    
    NSLog(@"点击cell --- indexPath --- %@",indexPath);
    
}

```


