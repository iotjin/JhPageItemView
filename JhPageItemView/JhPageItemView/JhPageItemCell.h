//
//  JhPageItemCell.h
//  JhPageItemView
//
//  Created by Jh on 2018/11/15.
//  Copyright © 2018 Jh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JhPageItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class  JhPageItemModel;
@interface JhPageItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *customTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) JhPageItemModel *data;


@end

NS_ASSUME_NONNULL_END
