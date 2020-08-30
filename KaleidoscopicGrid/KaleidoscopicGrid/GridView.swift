//
//  Grid.swift
//  KaleidoscopicGrid
//
//  Created by 段奕含 on 2020/8/28.
//

import SwiftUI


struct GridView: View {
    /// 边界大小
    let padding: CGFloat = 4
    /// 自己搭建的view
    var custmizedViews : [AnyView] = []
    /// 默认模版的属性
    var images: [Image] = []
    var titles: [String] = []
    var discriptions: [String] = []
    /// 列数
    var columns: Int
    /// 更多还是更大
    var displayType: DisplayType
    /// 有5种模式
    var gridType: GridType
    /// 点击手势
    var onTap: () -> Void = { return }
    
    /// 根据列数获得宽，并监听设备旋转
    @State private var width: CGFloat = 0
    /// 因为有奇奇怪怪的问题，所以经过测试要一个first，问题在于第一次进入通知中心就会发通知
    @State private var first: Bool = true
    
    /// 初始化
    init(gridType: GridType = .Default, custmizedViews: [AnyView] = [], images: [Image] = [], titles: [String] = [], discriptions: [String] = [], displayType: DisplayType = .Bigger, columns: Int = 0, onTap: @escaping () -> Void = { return }) {
        
        self.onTap = onTap
        self.gridType = gridType
        self.displayType = displayType
        switch displayType {
        case .Bigger:
            self.columns = UIScreen.main.bounds.size.width < 600 ? 2 : 4
        case .More:
            self.columns = UIScreen.main.bounds.size.width < 600 ? 3 : 6
        }
        switch gridType {
        case .Default:
            break
        case .Customized:
            self.custmizedViews = custmizedViews
        case .Image:
            self.images = images
        case .ImageTitle:
            self.images = images
            self.titles = titles
        case .ImageTitleDiscription:
            self.images = images
            self.titles = titles
            self.discriptions = discriptions
        }
    }
    
    /// 更多还是更多
    enum DisplayType {
        case More, Bigger
    }
    
    /// 5种形式
    enum GridType {
        case Default, Customized, Image, ImageTitle, ImageTitleDiscription
    }
    
    var body: some View {
        ZStack {
            if gridType == .Default {
                /// 默认的颜色块
                SubView(
                    views: getColorBlock(
                        width: width,
                        padding: padding
                    ),
                    columns: columns,
                    onTap: onTap
                )
            }else if gridType == .Customized {
                /// 自定义的view
                SubView(
                    views: custmizedViews,
                    columns: columns,
                    onTap: onTap
                )
            }else if gridType == .Image {
                /// 只显示图片的模版
                SubView(
                    views: getImageView(
                        images: images,
                        width: width,
                        padding: padding
                    ),
                    columns: columns,
                    onTap: onTap
                )
            }else if gridType == .ImageTitle {
                /// 显示图片和标题的模版
                SubView(
                    views: getImageTitleView(
                        images: images,
                        titles: titles,
                        width: width,
                        padding: padding
                    ),
                    columns: columns,
                    onTap: onTap
                )
            }else if gridType == .ImageTitleDiscription {
                /// 显示图片、标题和详情的模版
                SubView(
                    views: getImageTitleDiscriptionView(
                        images: images,
                        titles: titles,
                        discriptions: discriptions,
                        width: width,
                        padding: padding
                    ),
                    columns: columns,
                    onTap: onTap
                )
            }
        }
        .onAppear {
            let Width = UIScreen.main.bounds.size.width
            width = (Width - 2 * padding) / CGFloat(columns) - 2 * padding
        }
        /// 通知中心，监听旋转
        .onReceive(
            NotificationCenter.Publisher(
                center: .default,
                name: UIDevice.orientationDidChangeNotification
            )
        ) { _ in
            /// 奇奇怪怪的操作，应该是一开始没转就会进这里，所以要判断一下
            if !first {
                let Width = UIScreen.main.bounds.size.height
                width = (Width - 2 * padding) / CGFloat(columns) - 2 * padding
            }else {
                first = false
            }
          }
        .animation(.easeInOut)
    }
}

/// 含stack的包装view
struct SubView: View {
    var views: [AnyView]
    var columns: Int
    var onTap: () -> Void
    var body: some View {
        ScrollView(.vertical) {
            LazyHStack(alignment: .top, spacing: 0) {
                ForEach(0..<columns) { column in
                    LazyVStack(spacing: 0) {
                        ForEach(0..<Int(views.count / columns)) { item in
                            if Int(item * columns + column) < views.count {
                                views[Int(item * columns + column)]
                                    .onTapGesture{
                                        onTap()
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
}

/// 得到不同颜色的块，默认展示用
func getColorBlock(width: CGFloat, padding: CGFloat) -> [AnyView] {
    let colors: [Color] = [.blue, .gray, .green, .orange, .pink, .purple, .red, .yellow]
    var views: [AnyView] = []
    for i in 0..<1000 {
        views.append(
            AnyView(ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width, height: 100 + CGFloat(arc4random_uniform(20) * 10))
                    .foregroundColor(colors[Int(arc4random_uniform(8))])
                Text("\(i)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding(.all, padding)
            )
        )
    }
    return views
}

/// 得到不同的光图片的View
func getImageView(images: [Image], width: CGFloat, padding: CGFloat) -> [AnyView] {
    var views: [AnyView] = []
    for image in images {
        views.append(
            AnyView(ImageView(image: image, width: width, padding: padding))
        )
    }
    
    return views
}

/// 得到不同的图片和大标题的view
func getImageTitleView(images: [Image], titles: [String], width: CGFloat, padding: CGFloat) -> [AnyView] {
    var views: [AnyView] = []
    for (image, title) in zip(images, titles) {
        views.append(
            AnyView(ImageTitleView(image: image, title: title, width: width, padding: padding))
        )
    }
    
    return views
}

/// 得到不同的图片、标题和详情的view
func getImageTitleDiscriptionView(images: [Image], titles: [String], discriptions: [String], width: CGFloat, padding: CGFloat) -> [AnyView] {
    var views: [AnyView] = []
    for ((image, title), discription) in zip(zip(images, titles), discriptions) {
        views.append(
            AnyView(ImageTitleDiscriptionView(image: image, title: title, discription: discription, width: width, padding: padding))
        )
    }
    return views
}


/// 仅图片的view
struct ImageView: View {
    var image: Image
    var width: CGFloat
    var padding: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: width)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.secondary))
        .padding(.all, padding)
        .frame(maxHeight: .infinity)
    }
}

/// 图片和标题的view
struct ImageTitleView: View {
    var image: Image
    var title: String
    var width: CGFloat
    var padding: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: width)
            Rectangle()
                .frame(width: width, height: 2)
                .foregroundColor(.secondary)
            Text(title)
                .font(.title)
                .background(Color.white)
                .padding(.all, 6)
                .frame(width: width, alignment: .leading)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.secondary))
        .padding(.all, padding)
        .frame(maxHeight: .infinity)
    }
}

/// 图片、标题和详情的view
struct ImageTitleDiscriptionView: View {
    var image: Image
    var title: String
    var discription: String
    var width: CGFloat
    var padding: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: width)
            Rectangle()
                .frame(width: width, height: 2)
                .foregroundColor(.secondary)
            Text(title)
                .font(.title)
                .background(Color.white)
                .padding(.all, 6)
                .frame(width: width, alignment: .leading)
                .foregroundColor(.primary)
            Text(discription)
                .font(.body)
                .background(Color.white)
                .padding(.all, 6)
                .frame(width: width, alignment: .leading)
                .foregroundColor(.secondary)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.secondary))
        .padding(.all, padding)
        .frame(maxHeight: .infinity)
    }
}



struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        GridView(gridType: .Image, images: getImages())
    }
}
