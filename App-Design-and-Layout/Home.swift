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
    var body: some View {
        TabView {
            NavigationView {
                List {
                    FeaturedLandmarks(landmarks: featured)
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .listRowInsets(EdgeInsets())

                    ForEach(categories.keys.sorted(), id: \.self) { key in
                        CategoryRow(categoryName: key, items: self.categories[key]!)
                    }
                    .listRowInsets(EdgeInsets())

                    NavigationLink(destination: LandmarkList()) {
                        Text("See All")
                    }
                }
                .navigationBarTitle(Text("Featured"))
                .navigationBarItems(trailing: profileButton)
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
