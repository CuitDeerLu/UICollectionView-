#### UICollectionView
* UICollectionView基于UIScrollView，系统默认内容自动偏移64各单位 ，所以可以通过设置以下设置取消偏移 
```self.automaticallyAdjustsScrollViewInsets = NO;```

* UICollectionView必须设置瀑布流UICollectionViewFlowLayout，如：

```
UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 5.0;
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
```

* UICollectionView必须设置数据源和代理,如

```
_mineCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64.0, DEVICE_WIDTH, DEVICE_HEIGHT - 64.0) collectionViewLayout:layout];
    _mineCollection.backgroundColor = [UIColor lightGrayColor];
    _mineCollection.dataSource = self;
    _mineCollection.delegate = self;
```
* cell必须通过注册,如
 
```
    [_mineCollection registerClass:[MineCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
    [_mineCollection registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeader];
```
 
* cell必须自定义,系统cell没有任何子控件
* UICollectionView必须设置数据源和代理

```
//分区，组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

//每一分区的单元个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

//集合视图单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

//头部大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section

//集合视图头部或者尾部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

//单元格复用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

//被选中的单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

```
#### UICollectionViewFlowLayout
* 初始化layout后自动调动，可以在该方法中初始化一些自定义的变量参数

```-(void)prepareLayout```

* Invalidate:刷新,在滚动的时候是否允许刷新布局

```
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
```
* 设置UICollectionView的内容大小,道理与UIScrollView的contentSize类似,@return 返回设置的UICollectionView的内容大小

```
-(CGSize)collectionViewContentSize
```

*  初始Layout外观 @param rect 所有元素的布局属性 @return 所有元素的布局

```
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
```

*  根据不同的indexPath,给出布局 @param indexPath @return 布局

```
 -(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
```