//
//  JhPageControl.m
//
//
//  Created by Jh on 2018/11/7.
//  Copyright © 2018 Jh. All rights reserved.
//

#import "JhPageControl.h"


@interface JhPageControl ()

@end


@implementation JhPageControl

- (instancetype)init {
    if (self = [super init]) {
        [self initSetUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSetUp];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self createPointView];
}

- (void)initSetUp {
    self.backgroundColor = [UIColor clearColor];
    _Jh_alignmentStyle = JhControlAlignmentStyleCenter;
    _Jh_marginSpacing = 12;
    _Jh_numberOfPages = 0;
    _Jh_currentPage = 0;
    _Jh_controlSize = CGSizeMake(5, 5);
    _Jh_controlSpacing = 3;
    _Jh_otherColor = [UIColor lightGrayColor];
    _Jh_currentColor = [UIColor orangeColor];
}

- (void)setJh_otherColor:(UIColor *)Jh_otherColor {
    if (![self isTheSameColor:Jh_otherColor andotherColor:_Jh_otherColor]) {
        _Jh_otherColor = Jh_otherColor;
        [self createPointView];
    }
}

- (void)setJh_currentColor:(UIColor *)Jh_currentColor {
    if (![self isTheSameColor:Jh_currentColor andotherColor:_Jh_currentColor]) {
        _Jh_currentColor = Jh_currentColor;
        [self createPointView];
    }
}

- (void)setJh_controlSize:(CGSize)Jh_controlSize {
    if (Jh_controlSize.width != _Jh_controlSize.width || Jh_controlSize.height != _Jh_controlSize.height) {
        _Jh_controlSize = Jh_controlSize;
        [self createPointView];
    }
}

- (void)setJh_controlSpacing:(CGFloat)Jh_controlSpacing {
    if(_Jh_controlSpacing != Jh_controlSpacing){
        _Jh_controlSpacing = Jh_controlSpacing;
        [self createPointView];
    }
}

- (void)setJh_currentBgImg:(UIImage *)Jh_currentBgImg {
    if (_Jh_currentBgImg != Jh_currentBgImg) {
        _Jh_currentBgImg = Jh_currentBgImg;
        [self createPointView];
    }
}

- (void)setJh_numberOfPages:(NSInteger)Jh_numberOfPages {
    if (_Jh_numberOfPages == Jh_numberOfPages) return;
    _Jh_numberOfPages = Jh_numberOfPages;
    [self createPointView];
}

- (void)setJh_alignmentStyle:(JhControlAlignmentStyle)Jh_alignmentStyle {
    if (_Jh_alignmentStyle == Jh_alignmentStyle) return;
    _Jh_alignmentStyle = Jh_alignmentStyle;
    [self createPointView];
}

- (void)setJh_marginSpacing:(CGFloat)Jh_marginSpacing {
    if (_Jh_marginSpacing == Jh_marginSpacing) return;
    _Jh_marginSpacing = Jh_marginSpacing;
    [self createPointView];
}

- (void)setJh_currentPage:(NSInteger)Jh_currentPage {
    if ([self.delegate respondsToSelector:@selector(JhPageControlClick:index:)]) {
        [self.delegate JhPageControlClick:self index:Jh_currentPage];
    }
    if (self.JhSelectBlock) {
        self.JhSelectBlock(self, Jh_currentPage);
    }
    if (_Jh_currentPage == Jh_currentPage) return;
    [self exchangeCurrentView:_Jh_currentPage new:Jh_currentPage];
    _Jh_currentPage = Jh_currentPage;
}

- (void)clearView {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)setJh_pageControlStyle:(JhPageControlStyle)Jh_pageControlStyle {
    if (_Jh_pageControlStyle == Jh_pageControlStyle) return;
    _Jh_pageControlStyle = Jh_pageControlStyle;
    [self createPointView];
}

#pragma mark - 根据样式创建点
- (void)createPointView {
    [self clearView];
    if (_Jh_numberOfPages <= 0) return;
    
    switch (_Jh_pageControlStyle) {
        case JhPageControlStyelDefault:
        {
            [self CreatDotWithSize:_Jh_controlSize];
        }
            break;
        case JhPageControlStyelRectangle:
        {
            [self CreatDotWithSize:CGSizeMake(15, 2)];
        }
            break;
        case JhPageControlStyelDotAndRectangle:
        {
            [self CreatDotWithSize:CGSizeMake(15, 4) withOtherDotSize:CGSizeMake(4, 4)];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 默认样式创建点
- (void)CreatDotWithSize:(CGSize)DotSize {
    //居中控件
    CGFloat startX = 0;
    CGFloat startY = 0;
    CGFloat controlSizeW = DotSize.width;
    CGFloat controlSizeH = DotSize.height;
    CGFloat mainWidth = _Jh_numberOfPages * (controlSizeW + _Jh_controlSpacing);
    
    if (self.frame.size.width < mainWidth) {
        startX = 0;
    } else {
        if (_Jh_alignmentStyle == JhControlAlignmentStyleLeft && self.frame.size.width - _Jh_marginSpacing * 2 > mainWidth) {
            startX = _Jh_marginSpacing;
        } else if (_Jh_alignmentStyle == JhControlAlignmentStyleRight && self.frame.size.width - _Jh_marginSpacing * 2 > mainWidth) {
            startX = (self.frame.size.width - mainWidth) - _Jh_marginSpacing;
        } else {
            startX = (self.frame.size.width - mainWidth) / 2;
        }
    }
    if (self.frame.size.height < controlSizeH) {
        startY = 0;
    } else {
        startY = (self.frame.size.height - controlSizeH) / 2;
    }
    //动态创建点
    for (int page = 0; page < _Jh_numberOfPages; page++) {
        if (page ==_Jh_currentPage) {
            UIView *currPointView = [[UIView alloc]initWithFrame:CGRectMake(startX, startY, controlSizeW, controlSizeH)];
            currPointView.layer.cornerRadius = controlSizeH/2;
            currPointView.tag = page + 1000;
            currPointView.backgroundColor = _Jh_currentColor;
            currPointView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [currPointView addGestureRecognizer:tapGesture];
            [self addSubview:currPointView];
            startX = CGRectGetMaxX(currPointView.frame) + _Jh_controlSpacing;
            if(_Jh_currentBgImg){
                currPointView.backgroundColor = [UIColor clearColor];
                UIImageView *currBgImg = [UIImageView new];
                currBgImg.tag = 1234;
                currBgImg.frame = CGRectMake(0, 0, currPointView.frame.size.width, currPointView.frame.size.height);
                currBgImg.image = _Jh_currentBgImg;
                [currPointView addSubview:currBgImg];
            }
        } else {
            UIView *otherPointView = [[UIView alloc]initWithFrame:CGRectMake(startX, startY, controlSizeW, controlSizeH)];
            otherPointView.backgroundColor = _Jh_otherColor;
            otherPointView.tag = page + 1000;
            otherPointView.layer.cornerRadius = controlSizeH / 2;
            otherPointView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [otherPointView addGestureRecognizer:tapGesture];
            [self addSubview:otherPointView];
            startX = CGRectGetMaxX(otherPointView.frame) + _Jh_controlSpacing;
        }
    }
}

#pragma mark - 创建  圆点 + 长条形 样式
- (void)CreatDotWithSize:(CGSize)currentDotSize withOtherDotSize:(CGSize)otherDotSize {
    //居中控件
    CGFloat startX = 0;
    CGFloat startY = 0;
    CGFloat currentDotSizeW = currentDotSize.width;
    CGFloat currentDotSizeH = currentDotSize.height;
    CGFloat otherDotSizeW = otherDotSize.width;
    CGFloat otherDotSizeH = otherDotSize.height;
    
    CGFloat mainWidth = currentDotSizeW + (_Jh_numberOfPages - 1) * (otherDotSizeW + _Jh_controlSpacing);
    
    if (self.frame.size.width < mainWidth) {
        startX = 0;
    } else {
        if (_Jh_alignmentStyle == JhControlAlignmentStyleLeft && self.frame.size.width - _Jh_marginSpacing * 2 > mainWidth) {
            startX = _Jh_marginSpacing;
        } else if (_Jh_alignmentStyle == JhControlAlignmentStyleRight && self.frame.size.width - _Jh_marginSpacing * 2 > mainWidth) {
            startX = (self.frame.size.width - mainWidth) - _Jh_marginSpacing;
        } else {
            startX = (self.frame.size.width - mainWidth) / 2;
        }
    }
    if (self.frame.size.height < otherDotSizeH) {
        startY = 0;
    }  else {
        startY = (self.frame.size.height - otherDotSizeH) / 2;
    }
    //动态创建点
    for (int page = 0; page < _Jh_numberOfPages; page++) {
        if (page == _Jh_currentPage) {
            UIView *currPointView = [[UIView alloc]initWithFrame:CGRectMake(startX, startY, currentDotSizeW, currentDotSizeH)];
            currPointView.layer.cornerRadius = currentDotSizeH / 2;
            currPointView.tag = page + 1000;
            currPointView.backgroundColor = _Jh_currentColor;
            currPointView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [currPointView addGestureRecognizer:tapGesture];
            [self addSubview:currPointView];
            startX = CGRectGetMaxX(currPointView.frame) + _Jh_controlSpacing;
            if (_Jh_currentBgImg) {
                currPointView.backgroundColor = [UIColor clearColor];
                UIImageView *currBgImg = [UIImageView new];
                currBgImg.tag = 1234;
                currBgImg.frame = CGRectMake(0, 0, currPointView.frame.size.width, currPointView.frame.size.height);
                currBgImg.image = _Jh_currentBgImg;
                [currPointView addSubview:currBgImg];
            }
        } else {
            UIView *otherPointView = [[UIView alloc]initWithFrame:CGRectMake(startX, startY, otherDotSizeW, otherDotSizeH)];
            otherPointView.backgroundColor = _Jh_otherColor;
            otherPointView.tag = page + 1000;
            otherPointView.layer.cornerRadius = otherDotSizeH/2;
            otherPointView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [otherPointView addGestureRecognizer:tapGesture];
            [self addSubview:otherPointView];
            startX = CGRectGetMaxX(otherPointView.frame) + _Jh_controlSpacing;
        }
    }
}

- (void)clickAction:(UITapGestureRecognizer*)recognizer {
    NSInteger index = recognizer.view.tag - 1000;
    [self setJh_currentPage:index];
}

- (BOOL)isTheSameColor:(UIColor*)color1 andotherColor:(UIColor*)color2 {
    return  CGColorEqualToColor(color1.CGColor, color2.CGColor);
}

//切换当前的点
- (void)exchangeCurrentView:(NSInteger)old new:(NSInteger)new {
    UIView *oldSelect = [self viewWithTag:1000+old];
    CGRect mpSelect = oldSelect.frame;
    
    UIView *newSeltect = [self viewWithTag:1000+new];
    CGRect newTemp = newSeltect.frame;
    
    if (_Jh_currentBgImg) {
        UIView *imgview = [oldSelect viewWithTag:1234];
        [imgview removeFromSuperview];
        
        newSeltect.backgroundColor = [UIColor clearColor];
        UIImageView *currBgImg = [UIImageView new];
        currBgImg.tag = 1234;
        currBgImg.frame = CGRectMake(0, 0, mpSelect.size.width, mpSelect.size.height);
        currBgImg.image = _Jh_currentBgImg;
        [newSeltect addSubview:currBgImg];
    }
    
    oldSelect.backgroundColor = _Jh_otherColor;
    newSeltect.backgroundColor = _Jh_currentColor;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat lx = mpSelect.origin.x;
        CGFloat pageW = self.Jh_controlSize.width;
        CGFloat pageH = self.Jh_controlSize.height;
        if(new < old)
            lx += pageW;
        oldSelect.frame = CGRectMake(lx, mpSelect.origin.y, pageW, pageH);
        
        CGFloat mx = newTemp.origin.x;
        if(new > old)
            mx -= pageW;
        newSeltect.frame = CGRectMake(mx, newTemp.origin.y, pageW*2, pageH);
        
        // 左边的时候到右边 越过点击
        if (new-old>1) {
            for (NSInteger t = old+1; t < new; t++) {
                UIView *ms = [self viewWithTag:1000+t];
                ms.frame = CGRectMake(ms.frame.origin.x-pageW, ms.frame.origin.y, pageW, pageH);
            }
        }
        // 右边选中到左边的时候 越过点击
        if (new-old<-1) {
            for (NSInteger t = new+1; t < old; t++) {
                UIView *ms = [self viewWithTag:1000+t];
                ms.frame = CGRectMake(ms.frame.origin.x+pageW, ms.frame.origin.y, pageW, pageH);
            }
        }
    }];
}


@end
