//
//  JhPageControl.h
//  PersonalWage
//
//  Created by Jh on 2018/11/7.
//  Copyright © 2018 Jh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JhPageControlContentMode){
    
    JhPageControlContentModeLeft=0,
    JhPageControlContentModeCenter,
    JhPageControlContentModeRight,
};

typedef NS_ENUM(NSInteger, JhPageControlStyle)
{
    /** 默认按照 controlSize 设置的值,如果controlSize未设置 则按照大小为5的小圆点 */
    JhPageControlStyelDefault = 0,
    /** 长条样式 */
    JhPageControlStyelRectangle,
    /** 圆点 + 长条 样式 */
    JhPageControlStyelDotAndRectangle,
    
};


@class JhPageControl;
@protocol JhPageControlDelegate <NSObject>

-(void)JhPageControlClick:(JhPageControl*_Nonnull)pageControl index:(NSInteger)clickIndex;

@end


@interface JhPageControl : UIControl


/** 位置 默认居中 */
@property(nonatomic) JhPageControlContentMode PageControlContentMode;

/** 滚动条样式 默认按照 controlSize 设置的值,如果controlSize未设置 则为大小为5的小圆点 */
@property(nonatomic) JhPageControlStyle PageControlStyle;

@property(nonatomic) NSInteger numberOfPages;          // default is 0
@property(nonatomic) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1

/** 距离初始位置 间距  默认10 */
@property (nonatomic) CGFloat marginSpacing;
/** 间距 默认3 */
@property (nonatomic) CGFloat controlSpacing;

/** 大小 默认(5,5) 如果设置PageControlStyle,则失效 */
@property (nonatomic) CGSize controlSize;

/** 其他page颜色 */
@property(nullable, nonatomic,strong) UIColor *otherColor;

/** 当前page颜色 */
@property(nullable, nonatomic,strong) UIColor *currentColor;

/** 设置图片 */
@property(nonatomic,strong) UIImage * _Nullable currentBkImg;

@property(nonatomic,weak)id<JhPageControlDelegate> _Nullable delegate;


@end


