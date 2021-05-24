//
//  JhPageItemCell.m
//  JhPageItemView
//
//  Created by Jh on 2018/11/15.
//  Copyright © 2018 Jh. All rights reserved.
//

#import "JhPageItemCell.h"

@implementation JhPageItemCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setData:(JhPageItemModel *)data {
    _data = data;
    
    self.customTextLabel.text = data.text;
    self.imgView.image = [UIImage imageNamed:data.img];
}

@end
