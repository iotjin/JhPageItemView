//
//  JhCustomHorizontalLayout.h
//  JhPageItemView
//
//  Created by Jh on 2018/11/16.
//  Copyright © 2018 Jh. All rights reserved.
//

#import <UIKit/UIKit.h>


UIKIT_EXTERN NSUInteger numberOfPages(NSUInteger itemsInPage, NSUInteger totalCount);

/**
 水平方向滑动与布局（暂时只考虑一个section的情形，后期再完善）
 */
@interface JhCustomHorizontalLayout : UICollectionViewFlowLayout
/**
 每页的缩进
 */
@property (nonatomic, assign) UIEdgeInsets pageInset;
/**
 每个页面所包含的数量
 */
@property (nonatomic, assign) NSUInteger numberOfItemsInPage;
/**
 每页分多少列
 */
@property (nonatomic, assign) NSUInteger columnsInPage;


@end
