//
//  Home.swift
//  App-Design-and-Layout
//
//  Created by Willie on 2019/6/9.
//

import SwiftUI

struct CategoryHome: View {
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }
    
    var featured: [Landmark] {
        landmarkData.filter { $0.isFeatured }
    }
    
    @State var showingProfile = false
    @EnvironmentObject var userData: UserData

    //https://juejin.cn/post/6844904058130530317 为什么 SwiftUI 用 “some View” 作为视图类型?
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    private var content: String = "若逢新雪初霁，满月当空，下面平铺着皓影，上面流转着亮银，而你带笑的向我走来，月色与雪色之间，你是第三种绝色。"

    private func shareBtn(_ content: String) -> some View {
        if #available(iOS 16.0, *) {
            return ShareLink(item: content) {
                Image(systemName: "square.and.arrow.up")
            }
        } else {
            return Button(action: {  }) {
                Image(systemName: "square.and.arrow.up")
                    .imageScale(.large)
            }
        }
    }
//    https://juejin.cn/post/7297565621915287578
    private func shareBtn(_ content: String, img: Image) -> some View {
        if #available(iOS 16.0, *) {
            return ShareLink(item: content) {
                Image(systemName: "square.and.arrow.up")
            }
        } else {
            return Button(action: {  }) {
                Image(systemName: "square.and.arrow.up")
                    .imageScale(.large)
            }
        }
    }
    var body: some View {
        TabView {
            NavigationView {
                List {
                    FeaturedLandmarks(landmarks: featured)
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))

                    ForEach(categories.keys.sorted(), id: \.self) { key in
                        CategoryRow(categoryName: key, items: self.categories[key]!)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))

                    NavigationLink(destination: LandmarkList()) {
                        Text("See All")
                    }
                }
                .navigationBarTitle(Text("Featured"), displayMode: .automatic)
                .navigationBarItems(leading:shareBtn(content), trailing: profileButton)
                .sheet(isPresented: $showingProfile) {
                    ProfileHost()
                        .environmentObject(self.userData)
                }
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Featured")
            }

            // 在这里可以添加更多的 Tab 视图
            /*
             NavigationView {
             LandmarkList()
             }.tabItem {
             Image(systemName: "list.bullet")
             Text("All Landmarks")
             }
             */
            LandmarkList()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("All Landmarks")
                }

            Setting()
                .tabItem {
                    Image(systemName: "calendar.and.person")
                    Text("设置")
                }
        }

    }
}

struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    var body: some View {
        landmarks[0].image.resizable()
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(UserData())
    }
}
