//
//  LJCCollectionViewFlowLayout.m
//  UICollectionView基本使用
//
//  Created by 泛在吕俊衡 on 2017/6/5.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "LJCCollectionViewFlowLayout.h"

@implementation LJCCollectionViewFlowLayout

/*
 UICollectionViewLayoutAttributes:确定cell的尺寸
 一个UICollectionViewLayoutAttributes对象就对应一个cell
 拿到UICollectionViewLayoutAttributes相当于拿到cell
 */

// 什么时候调用:collectionView第一次布局,collectionView刷新的时候也会调用
// 作用:计算cell的布局,条件:cell的位置是固定不变
- (void)prepareLayout {
    [super prepareLayout];

    NSLog(@"%s",__func__);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array=[super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    for (UICollectionViewLayoutAttributes *attr in array) {
        
        // 2.计算中心点距离
        CGFloat delta = fabs((attr.center.y - self.collectionView.contentOffset.y) - self.collectionView.bounds.size.height * 0.5);
        
        // 3.计算比例
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.height * 0.5) * 0.25;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

// 什么时候调用:用户手指一松开就会调用
// 作用:确定最终偏移量
// 定位:距离中心点越近,这个cell最终展示到中心点
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    // 最终偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    // 0.获取最终显示的区域
    CGRect targetRect = CGRectMake(MAXFLOAT, 0, collectionW, targetP.y);
    
    // 1.获取最终显示的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    
    // 获取最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 获取距离中心点距离:注意:应该用最终的x
        CGFloat delta = (attr.center.y - targetP.y) - self.collectionView.bounds.size.height * 0.5;
        
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }
    
    // 移动间距
    targetP.y += minDelta;
    
    if (targetP.y < 0) {
        targetP.y = 0;
    }
    
    return targetP;
}

// Invalidate:刷新
// 在滚动的时候是否允许刷新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

// 计算collectionView滚动范围
//- (CGSize)collectionViewContentSize{
//    return [super collectionViewContentSize];
//}

@end
