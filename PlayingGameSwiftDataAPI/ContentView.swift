//
//  ContentView.swift
//  PlayingGameSwiftDataAPI
//
//  Created by Fabrice Kouonang on 2025-08-05.
//

import SwiftUI

struct ContentView: View {
   // @State private var selectedTab: Int = 0
    var body: some View {
        //TabView(selection:$selectedTab)
        TabView() {
            GameView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
                .tag(0)
            
            //ScoreView(selectedTab: $selectedTab)
            ScoreView()
                .tabItem {
                    Label("Scores", systemImage: "list.bullet")
                }
                .tag(1)
        }
      
    }
  
}

#Preview {
    ContentView()
}
