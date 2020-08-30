//
//  Example.swift
//  KaleidoscopicGrid
//
//  Created by 段奕含 on 2020/8/29.
//

import SwiftUI

struct Example: View {
    let choice = 3
    var body: some View {
        if choice == 0 {
            /// 色块展示
            GridView()
        }else if choice == 1 {
            /// 光图片
            GridView(gridType: .Image, images: getImages())
        }else if choice == 2 {
            /// 图片和标题
            GridView(gridType: .ImageTitle, images: getImages(), titles: getTitles())
        }else if choice == 3 {
            /// 图片、标题和详情
            GridView(gridType: .ImageTitleDiscription, images: getImages(), titles: getTitles(), discriptions: getDiscriptions())
//        }else if choice == 4 {
            /// 自定义的view
//            GridView(gridType: .Customized, custmizedViews: [MyView])
        }
    }
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
    }
}

func getImages() -> [Image] {
    var images: [Image] = []
    for i in 0...70 {
        images.append(
            Image("\(i % 7)")
        )
    }
    return images
}

func getTitles() -> [String] {
    var titles: [String] = []
    for i in 0...70 {
        var str: String = "agf"
        for _ in 0...i % 7 {
            str += " dbot"
        }
        titles.append(str)
    }
    return titles
}

func getDiscriptions() -> [String] {
    var titles: [String] = []
    for i in 0...70 {
        var str: String = "mnpq"
        for _ in 0...i % 7 {
            str += " reklj"
        }
        titles.append(str)
    }
    return titles
}
