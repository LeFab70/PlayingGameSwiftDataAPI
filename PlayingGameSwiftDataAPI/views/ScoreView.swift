//
//  ScoreView.swift
//  PlayingGameSwiftDataAPI
//
//  Created by Fabrice Kouonang on 2025-08-05.
//

import SwiftUI
import SwiftData

struct ScoreView: View {
    //@Environment(\.dismiss) var dismiss
   // @Binding var selectedTab: Int
    @Query private var scores: [Score]
    @Environment(\.modelContext) private var modelContext
    var body: some View {
       NavigationView {
           List {
               ForEach(scores) { score in
                       VStack(alignment: .leading) {
                           Text(score.userName)
                               .font(.headline)
                           Text("\(score.score)")
                               .font(.subheadline)
                               .foregroundColor(.secondary)
                           .padding([.leading], 16)
                        }
               }
               .onDelete(perform: {IndexSet in
                   for index in IndexSet {
                       self.modelContext.delete(self.scores[index])
                   }
               })
           }
           .navigationBarTitle("Scores")
        }
        
    }
}

#Preview {
   //ScoreView(selectedTab: .constant(0))
    ScoreView()
}
