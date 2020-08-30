# KaleidoscopicGrid
##  A type of water fall grid with a few templates

### 这是一个基于swiftui2.0的可以垂直调整大小的网格轮子

### 一、五个模版

1. 光色块默认展示模版（啥也干不了）

   `GridView()`

   ![](https://github.com/Ian-Dx/KaleidoscopicGrid/blob/master/KaleidoscopicGrid/KaleidoscopicGrid/ExamplePics/1.png!/scale/50)

2. 光图片的模版，可以添加单机事件

   `GridView(gridType: .Image, images: getImages())`

   ![](https://github.com/Ian-Dx/KaleidoscopicGrid/blob/master/KaleidoscopicGrid/KaleidoscopicGrid/ExamplePics/2.png)
3. 图片和标题的模版，可选单机事件

   `GridView(gridType: .ImageTitle, images: getImages(), titles: getTitles())`

   ![](https://github.com/Ian-Dx/KaleidoscopicGrid/blob/master/KaleidoscopicGrid/KaleidoscopicGrid/ExamplePics/3.png)

4. 图片、标题和详情的模版，可选单机事件

   `GridView(gridType: .ImageTitleDiscription, images: getImages(), titles: getTitles(), discriptions: getDiscriptions())`

   ![](https://github.com/Ian-Dx/KaleidoscopicGrid/blob/master/KaleidoscopicGrid/KaleidoscopicGrid/ExamplePics/4.png)

5. 自定义视图

   `GridView(gridType: .Customized, custmizedViews: [MyView])`

### 二、参数说明

| 参数名称        | 参数类型    | 参数功能                  | 默认值    |
| --------------- | ----------- | ------------------------- | --------- |
| .padding        | CGFloat     | 调整间距                  | 4         |
| .custmizedViews | [AnyView]   | 自定义视图                | []        |
| .images         | [Image]     | 模版中图片                | []        |
| .titles         | [String]    | 模版中标题                | []        |
| .discriptions   | [String]    | 模版中详情                | []        |
| .columns        | Int         | 列数                      | 2/3 / 4/6 |
| .displayType    | DisplayType | 选择列数iphone2/3 ipad4/6 | .Bigger   |
| .gridType       | GridType    | 选择模版类型              | .Default  |
| .onTap          | ()->Void    | 单机事件                  | {return}  |
