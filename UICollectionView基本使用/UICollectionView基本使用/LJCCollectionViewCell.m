//
//  LJCCollectionViewCell.m
//  UICollectionView基本使用
//
//  Created by 泛在吕俊衡 on 2017/6/5.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "LJCCollectionViewCell.h"

@implementation LJCCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}
@end
