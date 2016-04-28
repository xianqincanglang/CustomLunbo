# CustomLunbo
iOS当中的轮播
### 一行代码实现无线轮播
在ViewController中调用如下：

```
 NSArray *imageArray = [[NSArray alloc] initWithObjects:
                                   [UIImage imageNamed:@"0.jpg"],
                                   [UIImage imageNamed:@"1.jpg"],
                                   [UIImage imageNamed:@"2.jpg"],
                                   [UIImage imageNamed:@"3.jpg"], nil];
    CustomScrollView *customScrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) withImageArray:imageArray];
   
    [self.view addSubview:customScrollView];
```

### 效果图如下:
![](./CustomScrollView/result.gif)
