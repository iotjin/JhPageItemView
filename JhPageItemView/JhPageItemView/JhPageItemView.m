//
//  JhPageItemView.m
//  
//
//  Created by Jh on 2018/11/15.
//  Copyright © 2018 Jh. All rights reserved.
//

#import "JhPageItemView.h"


#import "JhPageItemCell.h"
#import "JhCustomHorizontalLayout.h"

#define Kwidth  [UIScreen mainScreen].bounds.size.width
#define Kheight  [UIScreen mainScreen].bounds.size.height

/** pageControl高度 15 */
#define pageViewHeight 15

@interface JhPageItemView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) JhPageControl *pageControl;

@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, assign) CGRect ViewFrame;

@property (nonatomic, strong) UICollectionViewLayout *layout;

@property (nonatomic, strong) JhCustomHorizontalLayout *customlayout;

@property (nonatomic, strong) UIView *slideBackView;
@property (nonatomic, strong) UIView *sliderView;

@end


@implementation JhPageItemView

static NSString * const reuseIdentifier = @"Cell";


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _ViewFrame = frame;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame withmaxColumn:(NSInteger )maxColumn maxRow:(NSInteger )maxRow{
  
    if (self = [super initWithFrame:frame]) {
        
        NSAssert(maxColumn != 0, @"列数不能为0");
        NSAssert(maxRow != 0, @"行数数不能为0");

        // 初始化
        [self initDataAndSubviews];
        
        _ViewFrame = frame;
        _maxRow = maxRow;
        _maxColumn = maxColumn;
        
    }
    return self;

}

-(void)initDataAndSubviews{
    
    _maxRow = 2;
    _maxColumn =5;
    _itemHorizontalMargin = 5.0f;
    _itemVerticalMargin = 5.0f;
    _kLeftRightMargin =10;
    _kTopBottomMargin =10;
    _layoutStyle = JhSystemHorizontalArrangement;
    
    _current_BGColor = [UIColor orangeColor];
    _other_BGColor  =[UIColor lightGrayColor];
    _slideBackView_width = 40;
    _sliderView_width = 15;
    _PageControlMarginSpacing = 0;
    _PageControlSpacing = 3.0;
    _PageControlStyle = JhPageControlStyelDefault;
    _PageControlContentMode = JhPageControlContentModeCenter;
    _pageControlIsHidden = NO;
    
   
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self collectionView];
    [self setScrollBar];
    
}




#pragma mark - 滚动条的一些设置
-(void)setScrollBar{
    
    NSInteger num  =  _dataArray.count /(_maxRow*_maxColumn)+1;
    NSLog(@" num %ld ",(long)num);
   
    //添加滚动条
    if (_layoutStyle == JhSystemHorizontalArrangement) {
        [self slideBackView];
    }else if (_layoutStyle == JhCustomHorizontalArrangement){
        [self pageControl];
    }
    
    if (num ==1) {
        self.slideBackView.hidden = YES;
        self.pageControl.hidden = YES;
    }
    
}


- (void)setMaxColumn:(NSInteger)maxColumn{
    _maxColumn = maxColumn;
}

- (void)setMaxRow:(NSInteger)maxRow{
    _maxRow = maxRow;
}

- (void)setItemHorizontalMargin:(CGFloat)itemHorizontalMargin{
    _itemHorizontalMargin =itemHorizontalMargin;
    
}
- (void)setItemVerticalMargin:(CGFloat)itemVerticalMargin{
    _itemVerticalMargin = itemVerticalMargin;
}
- (void)setKLeftRightMargin:(CGFloat)kLeftRightMargin{
    _kLeftRightMargin =kLeftRightMargin;
}
-(void)setKTopBottomMargin:(CGFloat)kTopBottomMargin{
    _kTopBottomMargin = kTopBottomMargin;
}

- (void)setLayoutStyle:(JhLayoutStyle)layoutStyle{
    _layoutStyle =layoutStyle;
}

-(void)setSlideBackView_width:(CGFloat)slideBackView_width{
    _slideBackView_width =slideBackView_width;
}
-(void)setSliderView_width:(CGFloat)sliderView_width{
    _sliderView_width =sliderView_width;
}

- (void)setOther_BGColor:(UIColor *)other_BGColor{
    _other_BGColor=other_BGColor;
}
-(void)setCurrent_BGColor:(UIColor *)current_BGColor{
    _current_BGColor =current_BGColor;
}
- (void)setPageControlIsHidden:(BOOL)pageControlIsHidden{
    _pageControlIsHidden = pageControlIsHidden;
}

-(void)setPageControlContentMode:(JhPageControlContentMode)PageControlContentMode{
    _PageControlContentMode = PageControlContentMode;
}
-(void)setPageControlStyle:(JhPageControlStyle)PageControlStyle{
    _PageControlStyle = PageControlStyle;
}

-(void)setPageControlSpacing:(CGFloat)PageControlSpacing{
    _PageControlSpacing = PageControlSpacing;
}
-(void)setPageControlMarginSpacing:(CGFloat)PageControlMarginSpacing{
    _PageControlMarginSpacing = PageControlMarginSpacing;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}


-(JhPageControl *)pageControl{
    if (!_pageControl) {
        
        CGFloat viewHeight = _ViewFrame.size.height;
        CGFloat pageControlHeight = pageViewHeight/2;
        JhPageControl *pageControl = [[JhPageControl alloc] init];
        CGFloat pageControl_X = 0;
        CGFloat pageControl_Y = viewHeight - pageViewHeight;
        pageControl.frame = CGRectMake(pageControl_X, pageControl_Y, Kwidth, pageControlHeight);
        
        pageControl.numberOfPages = _dataArray.count /(_maxRow*_maxColumn)+1;
        pageControl.currentPage = 0;
        pageControl.otherColor = _other_BGColor;
        pageControl.currentColor = _current_BGColor;
        pageControl.PageControlContentMode = _PageControlContentMode;
        pageControl.controlSpacing = _PageControlSpacing;
        pageControl.marginSpacing = _PageControlMarginSpacing;
//        pageControl.currentBkImg = [UIImage imageNamed:@"lunbochangtu"];
//        pageControl.controlSize = CGSizeMake(15, 2);//如果设置PageControlStyle,则失效
        pageControl.PageControlStyle = _PageControlStyle;
        pageControl.hidden = _pageControlIsHidden;

//        pageControl.backgroundColor =[UIColor purpleColor];
        _pageControl =pageControl;

        [self addSubview:self.pageControl];

    }
    return _pageControl;
}


-(UIView *)slideBackView{
    if (!_slideBackView) {
        
        CGFloat slideBackView_Width = _slideBackView_width;
        CGFloat sliderView_Width = _sliderView_width;
        
        CGFloat viewWidth = _ViewFrame.size.width-_kLeftRightMargin*2;
        CGFloat viewHeight = _ViewFrame.size.height-_kTopBottomMargin*2;
        CGFloat slideBackView_Height = 3;
        CGFloat slideBackView_X = viewWidth/2 -slideBackView_Width/2;
        CGFloat slideBackView_Y = viewHeight - slideBackView_Height;

        UIView *slideBackView=[[UIView alloc] initWithFrame:CGRectMake(slideBackView_X, slideBackView_Y, slideBackView_Width, slideBackView_Height)];
        slideBackView.backgroundColor = _other_BGColor;
        slideBackView.layer.cornerRadius = slideBackView_Height/2;
        _slideBackView = slideBackView;
        [self addSubview:self.slideBackView];
        
        UIView *sliderView = [[UIView alloc] init];
        sliderView.frame=CGRectMake(0,0, sliderView_Width, slideBackView_Height);
        sliderView.backgroundColor = _current_BGColor;
        sliderView.layer.cornerRadius = slideBackView_Height/2;
        _sliderView =sliderView;
        
        [_slideBackView addSubview:_sliderView];

        _slideBackView.hidden = _pageControlIsHidden;
        
        
    }
    return _slideBackView;
}


-(UICollectionViewLayout *)layout{
    if (!_layout) {
        
        CGFloat viewWidth = _ViewFrame.size.width-_kLeftRightMargin*2 ;
        CGFloat viewHeight = _ViewFrame.size.height-_kTopBottomMargin*2 -pageViewHeight;
        CGFloat itemW = (viewWidth - _itemHorizontalMargin * (_maxColumn - 1)) / _maxColumn -1;
        CGFloat itemH = (viewHeight - _itemVerticalMargin * (_maxRow - 1)) / _maxRow -1;
        
        //        CGFloat itemW = (viewWidth - _itemHorizontalMargin * (_maxColumn - 1) -1.0f) / _maxColumn;
        //        CGFloat itemH = (viewHeight - _itemVerticalMargin * (_maxRow - 1)- 0.5f) / _maxRow;
        
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
        //设置水平滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置每个cell的尺寸
        layout.itemSize = CGSizeMake(itemW, itemH);
        //cell之间的水平间距  行间距
        layout.minimumLineSpacing = _itemHorizontalMargin;
        //cell之间的垂直间距 cell间距
        layout.minimumInteritemSpacing = _itemVerticalMargin;
        //设置四周边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.layout =layout;
        
    }
    return _layout;
}



-(JhCustomHorizontalLayout *)customlayout{
    if (!_customlayout) {
        
        
        // UIEdgeInsets edgeInset = UIEdgeInsetsMake(10.0f, 12.0f, 10.0f, 12.0f);
        //        CGFloat columns = 5;
        //        CGFloat itemHeight = 90.0f;
        //        CGFloat HorizontalMargin = _itemHorizontalMargin;
        //        //
        //        CGFloat itemWidth = (viewWidth - edgeInset.left - edgeInset.right - columns * HorizontalMargin + HorizontalMargin) / columns;
        //
        //        HPHorizontalScrollFlowLayout * layout = [[HPHorizontalScrollFlowLayout alloc] init];
        //        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        //        layout.minimumLineSpacing = HorizontalMargin;
        //        layout.minimumInteritemSpacing = _itemVerticalMargin;
        //        layout.numberOfItemsInPage = 10;
        //        layout.columnsInPage = columns;
        //        layout.pageInset = edgeInset;
        
        
        
        CGFloat viewWidth = _ViewFrame.size.width-_kLeftRightMargin*2 ;
        CGFloat viewHeight = _ViewFrame.size.height-_kTopBottomMargin*2 -pageViewHeight;
        CGFloat itemW = (viewWidth - _itemHorizontalMargin * (_maxColumn - 1)) / _maxColumn -1;
        CGFloat itemH = (viewHeight - _itemVerticalMargin * (_maxRow - 1)) / _maxRow -1;
        
        //        CGFloat itemW = (viewWidth - _itemHorizontalMargin * (_maxColumn - 1) -1.0f) / _maxColumn;
        //        CGFloat itemH = (viewHeight - _itemVerticalMargin * (_maxRow - 1)- 0.5f) / _maxRow;
        
        JhCustomHorizontalLayout * layout = [[JhCustomHorizontalLayout alloc] init];
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.minimumLineSpacing = _itemHorizontalMargin;
        layout.minimumInteritemSpacing = _itemVerticalMargin;
        layout.numberOfItemsInPage = _maxRow*_maxColumn;
        layout.columnsInPage = _maxColumn;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.customlayout =layout;
    }
    return _customlayout;
}



- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        CGFloat viewWidth = _ViewFrame.size.width-_kLeftRightMargin*2 ;
        CGFloat viewHeight = _ViewFrame.size.height-_kTopBottomMargin*2 -pageViewHeight;
        CGRect Collectionframe =CGRectMake(_kLeftRightMargin,_kTopBottomMargin, viewWidth, viewHeight);
        
        if (_layoutStyle == JhSystemHorizontalArrangement) {
            
            _collectionView = [[UICollectionView alloc] initWithFrame:Collectionframe collectionViewLayout:self.layout];
            
        }else if (_layoutStyle == JhCustomHorizontalArrangement){
            
            _collectionView = [[UICollectionView alloc] initWithFrame:Collectionframe collectionViewLayout:self.customlayout];
            
        }
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JhPageItemCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 这句话的意思是为了 不管集合视图里面的值 多不多  都可以滚动 解决了值少了 集合视图不能滚动的问题
        //    _collectionView.alwaysBounceVertical = YES;
        //隐藏滚动条
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = NO;
        
        _collectionView.backgroundColor = [UIColor yellowColor];
        
        
        [self addSubview:self.collectionView];
        
    }
    return _collectionView;
}


#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JhPageItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.data =self.dataArray[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

#pragma mark - 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //     NSLog(@"点击cell --- indexPath --- %@",indexPath);
    //    //获取UICollectionViewCell 的 cell的text
    //    JhPageItemCell * cell2 = (JhPageItemCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *text = cell2.customTextLabel.text;
    //    NSLog(@" 点击 cell2 的text %@ ",text);
    
    
    
    if([self.delegate respondsToSelector:@selector(JhPageItemViewDelegate:indexPath:)])
    {
        [self.delegate JhPageItemViewDelegate:self indexPath:indexPath];
    }
    
    
}

#pragma mark - 滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.dataArray.count) return;
    
    if (_layoutStyle == JhSystemHorizontalArrangement) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGPoint offset = scrollView.contentOffset;
            // scrollView的当前位移/scrollView的总位移=滑块的当前位移/滑块的总位移
            //    offset/(scrollView.contentSize.width-scrollView.frame.size.width)=滑块的位移/(slideBackView.frame.size.width-sliderView.frame.size.width)
            //    滑块距离屏幕左边的距离加上滑块的当前位移，即为滑块当前的x
            CGRect frame=self.sliderView.frame;
            frame.origin.x = offset.x * (self.slideBackView.frame.size.width-self.sliderView.frame.size.width)/(scrollView.contentSize.width-scrollView.frame.size.width);
            
            if (frame.origin.x<0) {
                frame.origin.x =0;
            }
            if (frame.origin.x>(self.slideBackView.bounds.size.width-self.sliderView.bounds.size.width)) {
                frame.origin.x = self.slideBackView.bounds.size.width-self.sliderView.bounds.size.width;
            }
            self.sliderView.frame = frame;
            
        }];
        
        
    }else if (_layoutStyle == JhCustomHorizontalArrangement){
        
        CGFloat x = scrollView.contentOffset.x;
        //        NSLog(@" x %f ",x);
        CGFloat width = _ViewFrame.size.width;
        int currentPage = (int)(x/width + 0.5)%self.dataArray.count;
        _pageControl.currentPage = currentPage;
        
    }
    
}



@end
