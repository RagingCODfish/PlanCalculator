//
//  HomeView.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 10/11/2022.
//

import SwiftUI

struct HomeView: View {
    @SceneStorage("selectedView") var selectedView: String?
    
    var body: some View {
        TabView(selection: $selectedView) {
            ContentView()
                .tag(ContentView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("JB Plans")
                }
            
            TelstraPlansView()
                .tag(TelstraPlansView.tag)
                .tabItem {
                    Image(systemName: "heart")
                    Text("Telstra Plans")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
