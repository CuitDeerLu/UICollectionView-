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
