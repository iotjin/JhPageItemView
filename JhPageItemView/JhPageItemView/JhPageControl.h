//
//  JhPageControl.h
//
//
//  Created by Jh on 2018/11/7.
//  Copyright © 2018 Jh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JhControlAlignmentStyle) {
    JhControlAlignmentStyleCenter = 0,
    JhControlAlignmentStyleLeft,
    JhControlAlignmentStyleRight,
};

typedef NS_ENUM(NSInteger, JhPageControlStyle) {
    /** 默认按照 controlSize 设置的值,如果controlSize未设置 则按照大小为5的小圆点 */
    JhPageControlStyelDefault = 0,
    /** 长条样式 */
    JhPageControlStyelRectangle,
    /** 圆点 + 长条 样式 */
    JhPageControlStyelDotAndRectangle,
};


@class JhPageControl;

@protocol JhPageControlDelegate <NSObject>

- (void)JhPageControlClick:(JhPageControl*)pageControl index:(NSInteger)clickIndex;

@end


@interface JhPageControl : UIControl

/** 位置 默认居中 */
@property (nonatomic, assign) JhControlAlignmentStyle Jh_alignmentStyle;

/** 滚动条样式 默认按照 controlSize 设置的值,如果controlSize未设置 则为大小为5的小圆点 */
@property (nonatomic, assign) JhPageControlStyle Jh_pageControlStyle;

@property (nonatomic, assign) NSInteger Jh_numberOfPages;          // default is 0

@property (nonatomic, assign) NSInteger Jh_currentPage;            // default is 0. value pinned to 0..numberOfPages-1

/** 距离初始位置 间距  默认10 */
@property (nonatomic, assign) CGFloat Jh_marginSpacing;

/** 间距 默认3 */
@property (nonatomic, assign) CGFloat Jh_controlSpacing;

/** 大小 默认(5,5) 如果设置Jh_pageControlStyle，则失效 */
@property (nonatomic, assign) CGSize Jh_controlSize;

/** 其他page颜色 */
@property (nonatomic, strong) UIColor *Jh_otherColor;

/** 当前page颜色 */
@property (nonatomic, strong) UIColor *Jh_currentColor;

/** 设置图片 */
@property (nonatomic, strong) UIImage *Jh_currentBgImg;

@property (nonatomic,   weak) id<JhPageControlDelegate> delegate;

/** block 要写在 Jh_currentPage之前，否则第一次的不会触发   */
@property (nonatomic,   copy) void(^JhSelectBlock)(JhPageControl *pageControl,NSInteger clickIndex);


@end




NS_ASSUME_NONNULL_END
