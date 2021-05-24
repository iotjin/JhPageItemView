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

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) JhCustomHorizontalLayout *customlayout;

@property (nonatomic, strong) UIView *slideBackView;

@property (nonatomic, strong) UIView *sliderView;

@end


@implementation JhPageItemView

static NSString * const reuseIdentifier = @"Cell";


- (instancetype)initWithFrame:(CGRect)frame withmaxColumn:(NSInteger )maxColumn maxRow:(NSInteger )maxRow {
    if (self = [super initWithFrame:frame]) {
        NSAssert(maxColumn != 0, @"列数不能为0");
        NSAssert(maxRow != 0, @"行数数不能为0");
        // 初始化
        [self initSetUp];
        _ViewFrame = frame;
        _Jh_maxRow = maxRow;
        _Jh_maxColumn = maxColumn;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)initSetUp {
    _Jh_maxRow = 2;
    _Jh_maxColumn = 5;
    _Jh_itemHorizontalMargin = 5.0f;
    _Jh_itemVerticalMargin = 5.0f;
    _Jh_leftRightMargin = 10;
    _Jh_topBottomMargin = 10;
    _Jh_layoutStyle = JhSystemHorizontalArrangement;
    
    _Jh_currentColor = [UIColor orangeColor];
    _Jh_otherColor = [UIColor lightGrayColor];
    _Jh_slideBackView_width = 40;
    _Jh_sliderView_width = 15;
    _Jh_pageControlMarginSpacing = 0;
    _Jh_pageControlSpacing = 3.0;
    _Jh_pageControlStyle = JhPageControlStyelDefault;
    _Jh_pageControlAlignmentStyle = JhControlAlignmentStyleCenter;
    _Jh_pageControlIsHidden = NO;
}

#pragma mark - 滚动条的一些设置
- (void)setScrollBar {
    NSInteger num  =  _Jh_dataArray.count / (_Jh_maxRow * _Jh_maxColumn) + 1;
    //    NSLog(@" num %ld ",(long)num);
    //添加滚动条
    if (_Jh_layoutStyle == JhSystemHorizontalArrangement) {
        [self slideBackView];
    } else if (_Jh_layoutStyle == JhCustomHorizontalArrangement) {
        [self pageControl];
    }
    if (num == 1) {
        self.slideBackView.hidden = YES;
        self.pageControl.hidden = YES;
    }
}

- (CGSize)getItemWH {
    CGFloat viewWidth = _ViewFrame.size.width - _Jh_leftRightMargin * 2;
    CGFloat viewHeight = _ViewFrame.size.height - _Jh_topBottomMargin * 2 - pageViewHeight;
    CGFloat itemW = (viewWidth - _Jh_itemHorizontalMargin * (_Jh_maxColumn - 1)) / _Jh_maxColumn - 1;
    CGFloat itemH = (viewHeight - _Jh_itemVerticalMargin * (_Jh_maxRow - 1)) / _Jh_maxRow - 1;
    //        CGFloat itemW = (viewWidth - _Jh_itemHorizontalMargin * (_Jh_maxColumn - 1) -1.0f) / _Jh_maxColumn;
    //        CGFloat itemH = (viewHeight - _Jh_itemVerticalMargin * (_Jh_maxRow - 1)- 0.5f) / _Jh_maxRow;
    return CGSizeMake(itemW, itemH);
}

- (void)setLayoutUI{
    if (self.Jh_layoutStyle == JhSystemHorizontalArrangement) {
        self.layout.itemSize = [self getItemWH];
        self.layout.minimumLineSpacing = _Jh_itemHorizontalMargin;
        self.layout.minimumInteritemSpacing = _Jh_itemVerticalMargin;
    } else {
        self.customlayout.itemSize = [self getItemWH];
        self.customlayout.minimumLineSpacing = _Jh_itemHorizontalMargin;
        self.customlayout.minimumInteritemSpacing = _Jh_itemVerticalMargin;
        self.customlayout.numberOfItemsInPage = _Jh_maxRow * _Jh_maxColumn;
        self.customlayout.columnsInPage = _Jh_maxColumn;
    }
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.Jh_dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JhPageItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.data = self.Jh_dataArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //     NSLog(@"点击cell --- indexPath --- %@",indexPath);
    //    //获取UICollectionViewCell 的 cell的text
    //    JhPageItemCell * cell2 = (JhPageItemCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *text = cell2.customTextLabel.text;
    //    NSLog(@" 点击 cell2 的text %@ ",text);
    
    if ([self.delegate respondsToSelector:@selector(JhPageItemViewDelegate:indexPath:)]){
        [self.delegate JhPageItemViewDelegate:self indexPath:indexPath];
    }
}

#pragma mark - 滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.Jh_dataArray.count) return;
    if (_Jh_layoutStyle == JhSystemHorizontalArrangement) {
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint offset = scrollView.contentOffset;
            // scrollView的当前位移/scrollView的总位移=滑块的当前位移/滑块的总位移
            //    offset/(scrollView.contentSize.width-scrollView.frame.size.width)=滑块的位移/(slideBackView.frame.size.width-sliderView.frame.size.width)
            //    滑块距离屏幕左边的距离加上滑块的当前位移，即为滑块当前的x
            CGRect frame = self.sliderView.frame;
            frame.origin.x = offset.x * (self.slideBackView.frame.size.width - self.sliderView.frame.size.width) / (scrollView.contentSize.width - scrollView.frame.size.width);
            
            if (frame.origin.x < 0) {
                frame.origin.x = 0;
            }
            if (frame.origin.x > (self.slideBackView.bounds.size.width-self.sliderView.bounds.size.width)) {
                frame.origin.x = self.slideBackView.bounds.size.width-self.sliderView.bounds.size.width;
            }
            self.sliderView.frame = frame;
        }];
    } else if (_Jh_layoutStyle == JhCustomHorizontalArrangement) {
        CGFloat x = scrollView.contentOffset.x;
        //        NSLog(@" x %f ",x);
        CGFloat width = _ViewFrame.size.width;
        int currentPage = (int)(x/width + 0.5) % self.Jh_dataArray.count;
        _pageControl.Jh_currentPage = currentPage;
    }
}

- (JhPageControl *)pageControl {
    if (!_pageControl) {
        CGFloat viewHeight = _ViewFrame.size.height;
        CGFloat pageControlHeight = pageViewHeight/2;
        JhPageControl *pageControl = [[JhPageControl alloc] init];
        CGFloat pageControl_X = 0;
        CGFloat pageControl_Y = viewHeight - pageViewHeight;
        pageControl.frame = CGRectMake(pageControl_X, pageControl_Y, Kwidth, pageControlHeight);
        
        pageControl.Jh_numberOfPages = _Jh_dataArray.count / (_Jh_maxRow*_Jh_maxColumn) + 1;
        pageControl.Jh_currentPage = 0;
        pageControl.Jh_otherColor = _Jh_otherColor;
        pageControl.Jh_currentColor = _Jh_currentColor;
        pageControl.Jh_alignmentStyle = _Jh_pageControlAlignmentStyle;
        pageControl.Jh_controlSpacing = _Jh_pageControlSpacing;
        pageControl.Jh_marginSpacing = _Jh_pageControlMarginSpacing;
        //        pageControl.Jh_currentBgImg = [UIImage imageNamed:@"lunbochangtu"];
        //        pageControl.Jh_controlSize = CGSizeMake(15, 2);//如果设置PageControlStyle,则失效
        pageControl.Jh_pageControlStyle = _Jh_pageControlStyle;
        pageControl.hidden = _Jh_pageControlIsHidden;
        
        //        pageControl.backgroundColor =[UIColor purpleColor];
        _pageControl =pageControl;
        [self addSubview:self.pageControl];
    }
    return _pageControl;
}

- (UIView *)slideBackView {
    if (!_slideBackView) {
        CGFloat slideBackView_Width = _Jh_slideBackView_width;
        CGFloat sliderView_Width = _Jh_sliderView_width;
        
        CGFloat viewWidth = _ViewFrame.size.width - _Jh_leftRightMargin * 2;
        CGFloat viewHeight = _ViewFrame.size.height - _Jh_topBottomMargin * 2;
        CGFloat slideBackView_Height = 3;
        CGFloat slideBackView_X = viewWidth/2 - slideBackView_Width/2;
        CGFloat slideBackView_Y = viewHeight - slideBackView_Height;
        
        UIView *slideBackView = [[UIView alloc] initWithFrame:CGRectMake(slideBackView_X, slideBackView_Y, slideBackView_Width, slideBackView_Height)];
        slideBackView.backgroundColor = _Jh_otherColor;
        slideBackView.layer.cornerRadius = slideBackView_Height / 2;
        _slideBackView = slideBackView;
        [self addSubview:self.slideBackView];
        
        UIView *sliderView = [[UIView alloc] init];
        sliderView.frame = CGRectMake(0, 0, sliderView_Width, slideBackView_Height);
        sliderView.backgroundColor = _Jh_currentColor;
        sliderView.layer.cornerRadius = slideBackView_Height / 2;
        _sliderView = sliderView;
        [_slideBackView addSubview:_sliderView];
        _slideBackView.hidden = _Jh_pageControlIsHidden;
    }
    return _slideBackView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置水平滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置每个cell的尺寸
        layout.itemSize = [self getItemWH];
        //cell之间的水平间距  行间距
        layout.minimumLineSpacing = _Jh_itemHorizontalMargin;
        //cell之间的垂直间距 cell间距
        layout.minimumInteritemSpacing = _Jh_itemVerticalMargin;
        //设置四周边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.layout = layout;
    }
    return _layout;
}

- (JhCustomHorizontalLayout *)customlayout {
    if (!_customlayout) {
        JhCustomHorizontalLayout *layout = [[JhCustomHorizontalLayout alloc] init];
        layout.itemSize =  [self getItemWH];
        layout.minimumLineSpacing = _Jh_itemHorizontalMargin;
        layout.minimumInteritemSpacing = _Jh_itemVerticalMargin;
        layout.numberOfItemsInPage = _Jh_maxRow * _Jh_maxColumn;
        layout.columnsInPage = _Jh_maxColumn;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.customlayout = layout;
    }
    return _customlayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat viewWidth = _ViewFrame.size.width - _Jh_leftRightMargin * 2;
        CGFloat viewHeight = _ViewFrame.size.height - _Jh_topBottomMargin * 2 - pageViewHeight;
        CGRect Collectionframe = CGRectMake(_Jh_leftRightMargin, _Jh_topBottomMargin, viewWidth, viewHeight);
        if (_Jh_layoutStyle == JhSystemHorizontalArrangement) {
            _collectionView = [[UICollectionView alloc] initWithFrame:Collectionframe collectionViewLayout:self.layout];
        } else if (_Jh_layoutStyle == JhCustomHorizontalArrangement) {
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

- (void)setJh_dataArray:(NSArray *)Jh_dataArray {
    _Jh_dataArray = Jh_dataArray;
    [self collectionView];
    [self setScrollBar];
}

- (void)setJh_maxColumn:(NSInteger)Jh_maxColumn {
    _Jh_maxColumn = Jh_maxColumn;
    [self setLayoutUI];
}

- (void)setJh_maxRow:(NSInteger)Jh_maxRow {
    _Jh_maxRow = Jh_maxRow;
    [self setLayoutUI];
}

- (void)setJh_itemHorizontalMargin:(CGFloat)Jh_itemHorizontalMargin {
    _Jh_itemHorizontalMargin = Jh_itemHorizontalMargin;
    [self setLayoutUI];
}

- (void)setJh_itemVerticalMargin:(CGFloat)Jh_itemVerticalMargin {
    _Jh_itemVerticalMargin = Jh_itemVerticalMargin;
    [self setLayoutUI];
}

- (void)setJh_topBottomMargin:(CGFloat)Jh_topBottomMargin {
    _Jh_topBottomMargin = Jh_topBottomMargin;
    [self setLayoutUI];
}

- (void)setJh_leftRightMargin:(CGFloat)Jh_leftRightMargin {
    _Jh_leftRightMargin = Jh_leftRightMargin;
    [self setLayoutUI];
}

- (void)setJh_layoutStyle:(JhLayoutStyle)Jh_layoutStyle {
    _Jh_layoutStyle = Jh_layoutStyle;
    [self setLayoutUI];
}

- (void)setJh_sliderView_width:(CGFloat)Jh_sliderView_width {
    _Jh_sliderView_width = Jh_sliderView_width;
    [self setLayoutUI];
}

- (void)setJh_slideBackView_width:(CGFloat)Jh_slideBackView_width {
    _Jh_slideBackView_width = Jh_slideBackView_width;
    [self setLayoutUI];
}

- (void)setJh_otherColor:(UIColor *)Jh_otherColor {
    _Jh_otherColor = Jh_otherColor;
    [self setLayoutUI];
}

- (void)setJh_currentColor:(UIColor *)Jh_currentColor {
    _Jh_currentColor = Jh_currentColor;
    [self setLayoutUI];
}

- (void)setJh_pageControlIsHidden:(BOOL)Jh_pageControlIsHidden {
    _Jh_pageControlIsHidden = Jh_pageControlIsHidden;
    [self setLayoutUI];
}

- (void)setJh_pageControlAlignmentStyle:(JhControlAlignmentStyle)Jh_pageControlAlignmentStyle {
    _Jh_pageControlAlignmentStyle = Jh_pageControlAlignmentStyle;
    [self setLayoutUI];
}

- (void)setJh_pageControlStyle:(JhPageControlStyle)Jh_pageControlStyle {
    _Jh_pageControlStyle = Jh_pageControlStyle;
    [self setLayoutUI];
}

- (void)setJh_pageControlSpacing:(CGFloat)Jh_pageControlSpacing {
    _Jh_pageControlSpacing = Jh_pageControlSpacing;
    [self setLayoutUI];
}

- (void)setJh_pageControlMarginSpacing:(CGFloat)Jh_pageControlMarginSpacing {
    _Jh_pageControlMarginSpacing = Jh_pageControlMarginSpacing;
    [self setLayoutUI];
}


@end
