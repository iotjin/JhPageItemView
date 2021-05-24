//
//  JhPageItemView.h
//
//
//  Created by Jh on 2018/11/15.
//  Copyright © 2018 Jh. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "JhPageControl.h"


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM (NSInteger ,JhLayoutStyle) {
    
    /** 系统排列方式
     135
     246
     */
    JhSystemHorizontalArrangement = 0,
    
    /** 自定义排列方式
     123
     456
     */
    JhCustomHorizontalArrangement,
};


@class JhPageItemView;
@protocol JhPageItemViewDelegate <NSObject>

- (void)JhPageItemViewDelegate:(JhPageItemView *)JhPageItemViewDeleagte indexPath:(NSIndexPath * )indexPath;

@end


@interface JhPageItemView : UIView

- (instancetype)initWithFrame:(CGRect)frame withmaxColumn:(NSInteger )maxColumn maxRow:(NSInteger )maxRow;


/** 列 默认5 */
@property (nonatomic, assign) NSInteger Jh_maxColumn;
/** 行 默认2 */
@property (nonatomic, assign) NSInteger Jh_maxRow;
/** item 水平间距 默认5 */
@property (nonatomic, assign) CGFloat Jh_itemHorizontalMargin;
/** item 垂直间距 默认5 */
@property (nonatomic, assign) CGFloat Jh_itemVerticalMargin;
/** 左右item离屏幕的间距 默认10 */
@property (nonatomic, assign) CGFloat Jh_leftRightMargin;
/** 上下item离屏幕的间距 默认10 */
@property (nonatomic, assign) CGFloat Jh_topBottomMargin;

/********************************* 滚动条相关 ********************************/

/** 系统样式slideBackView宽度 */
@property (nonatomic, assign) CGFloat Jh_slideBackView_width;
/** 系统样式sliderView宽度 */
@property (nonatomic, assign) CGFloat Jh_sliderView_width;
/** 滚动条 其他 颜色 */
@property (nonatomic, strong) UIColor *Jh_otherColor;
/** 滚动条 当前 颜色 */
@property (nonatomic, strong) UIColor *Jh_currentColor;
/** 滚动条 是否隐藏  默认NO */
@property (nonatomic, assign) BOOL Jh_pageControlIsHidden;

/** 滚动条 位置 默认居中 */
@property (nonatomic, assign) JhControlAlignmentStyle Jh_pageControlAlignmentStyle;
/** 滚动条样式 默认按照 controlSize 设置的值,如果controlSize未设置 则为大小为5的小圆点 */
@property (nonatomic, assign) JhPageControlStyle Jh_pageControlStyle;
/** 滚动条 距离初始位置 间距  默认0 */
@property (nonatomic, assign) CGFloat Jh_pageControlMarginSpacing;
/** 滚动条 间距 默认3 */
@property (nonatomic, assign) CGFloat Jh_pageControlSpacing;

/********************************* 滚动条相关 ********************************/


// 数据源
@property (nonatomic, strong) NSArray * Jh_dataArray;

@property (nonatomic, assign) JhLayoutStyle Jh_layoutStyle;

@property (nonatomic,   weak) id<JhPageItemViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
