# SCCellPanGestureRecognizer

---
###Description
Pan a cell and do sth when end or cancel to pan.  
There are two types of panning a cell in this project.  
And you can inherite from the class `SCCellPanBaseGesture` to make your own type.  

---
###Display
![preivew_gif](https://raw.githubusercontent.com/Aevit/SCCellPanGestureRecognizer/master/SCCellPanGestureDemo.gif)

---
###How to use
1. copy the folder `SCCellPanGestureRecognizer` to your project.

2. write the code like this:  
```
SCCellPanHorizonGesture *panGes = [[SCCellPanHorizonGesture alloc] initWithTableView:tableView block:^(UITableViewCell *cell, BOOL isLeft) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tips" message:(isLeft ? @"do sth to \"done\"" : @"do sth to \"delete\"") delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}];
[panGes buildLeftImgStr:@"icon_list_ok.png" rightImgStr:@"icon_list_del.png"];
[self.view addGestureRecognizer:panGes];
```
3. see more details in my demo project.

---
###Thanks
The second type imitate the app called [VVebo](https://itunes.apple.com/cn/app/vvebo-wei-bo-ke-hu-duan/id670910957?mt=8).  
If the author of `VVebo` do not allow me to imitate, please contact me: `Aevitx@gmail.com`, and I will delete the code.

---
###License

This code is distributed under the terms and conditions of the [MIT license](https://raw.githubusercontent.com/Aevit/SCCellPanGestureRecognizer/master/LICENSE). 