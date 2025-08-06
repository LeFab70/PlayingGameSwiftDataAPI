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
                   HStack(alignment: .center, spacing: 12) {
                              if let urlString = score.picture, let url = URL(string: urlString){
                                  AsyncImage(url: url) { image in
                                      image
                                          .resizable()
                                          .aspectRatio(contentMode: .fit)
                                  } placeholder: {
                                      ProgressView()
                                  }
                                  .frame(width: 60, height: 60)
                                  .clipShape(Circle())
                              }
                                else {
                               // Image par défaut (fallback)
                               Image(systemName: "person.crop.circle.fill")
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                   .frame(width: 60, height: 60)
                                   .foregroundColor(.gray)
                                   .clipShape(Circle())
                                }

                       VStack(alignment: .leading, spacing: 4) {
                                 Text(score.userName)
                                     .font(.headline)
                                  Text("Score:\(score.score)")
                                      .font(.subheadline)
                                      .foregroundColor(.secondary)
                                  Text("At \(score.date.formatted(date: .abbreviated, time: .shortened))")
                                      .font(.subheadline)
                                      .foregroundColor(.secondary)
                             
                           }
                        }
               }
               .onDelete(perform: {IndexSet in
                   for index in IndexSet {
                       self.modelContext.delete(self.scores[index])
                   }
               })
               
               Button("Clear All data") {
                   for score in scores {
                       modelContext.delete(score)
                   }
                   try? modelContext.save()
               }
           }
           .navigationBarTitle("Scores")
          
           
        }
        
    }
}

#Preview {
   //ScoreView(selectedTab: .constant(0))
    ScoreView()
}
