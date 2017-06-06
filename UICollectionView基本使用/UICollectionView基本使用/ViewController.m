//
//  ViewController.m
//  UICollectionView基本使用
//
//  Created by 泛在吕俊衡 on 2017/6/5.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "ViewController.h"
#import "LJCCollectionViewCell.h"
#import "LJCCollectionViewFlowLayout.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController
static NSString *ID=@"CELL";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UICollectionView使用注意点
    // 1.创建UICollectionView必须要有布局参数
    // 2.cell必须通过注册
    // 3.cell必须自定义,系统cell没有任何子控件
    
    LJCCollectionViewFlowLayout *layout = [[LJCCollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 60);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat margin = 40;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    layout.headerReferenceSize=CGSizeMake(30, 40);
    // 设置最小行间距
    layout.minimumLineSpacing = 30;
    layout.minimumInteritemSpacing = 30;
    
    UICollectionView *collectView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectView.bounds=self.view.bounds;
    collectView.backgroundColor=[UIColor grayColor];
    collectView.center = self.view.center;
    collectView.dataSource=self;
    collectView.contentOffset=CGPointMake(240, 1000);
    
    [self.view addSubview:collectView];
    
    [collectView registerNib:[UINib nibWithNibName:NSStringFromClass([LJCCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ID];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LJCCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image=[UIImage imageNamed:@"AppIcon20x20@2x"];
    return cell;
}
@end
