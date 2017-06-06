
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
### UITableView基本使用

#### 使用xib
<p>1.xib中的cell指定class为自定义的class</p>
<p>2.调用 tableView 的 registerNib:forCellReuseIdentifier:方法向数据源注册cell</p>
<p>3.在cellForRowAtIndexPath中使用dequeueReuseableCellWithIdentifier:forIndexPath:获取重用的cell，若无重用的cell，将自动使用所提供的nib文件创建cell并返回（若使用旧式dequeueReuseableCellWithIdentifier:方法需要判断返回是否为空而进行新建）</p>
<p>4.获取cell时若无可重用cell，将创建新的cell并调用其中的awakeFromNib方法，可通过重写这个方法添加更多页面内容</p>

#### 不使用xib
<p>1、重写自定义cell的initWithStyle:withReuseableCellIdentifier:方法进行布局</p>
<p>2、为tableView注册cell，使用registerClass:forCellReuseIdentifier:方法注册（注意是Class）</p>
<p>3、在cellForRowAtIndexPath中使用dequeueReuseableCellWithIdentifier:forIndexPath:获取重用的cell，若无重用的cell，将自动使用所提供的class类创建cell并返回</p>
<p>4、获取cell时若无可重用cell，将调用cell中的initWithStyle:withReuseableCellIdentifier:方法创建新的cell</p>

#### 另外要注意的：
<p> 1、dequeueReuseableCellWithIdentifier:与dequeueReuseableCellWithIdentifier:forIndexPath:的区别： 前者不必向tableView注册cell的Identifier，但需要判断获取的cell是否为nil； 后者则必须向table注册cell，可省略判断获取的cell是否为空，因为无可复用cell时runtime将使用注册时提供的资源去新建一个cell并返回 </p>
<p>2、自定义cell时，记得将其他内容加到self.contentView 上，而不是直接添加到 cell 本身上</p>

#### 总结： <p>1.自定义cell时，
若使用nib，使用 registerNib: 注册，dequeue时会调用 cell 的 -(void)awakeFromNib 不使用nib，使用registerClass注册, dequeue时会调用 cell 的 - (id)initWithStyle:withReuseableCellIdentifier:</p> <p>2.需不需要注册 使用dequeueReuseableCellWithIdentifier:可不注册，但是必须对获取回来的cell进行判断是否为空，若空则手动创建新的cell； 使用dequeueReuseableCellWithIdentifier:forIndexPath:必须注册，但返回的cell可省略空值判断的步骤</p>
