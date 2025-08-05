//
//  GameView.swift
//  PlayingGameSwiftDataAPI
//
//  Created by Fabrice Kouonang on 2025-08-05.
//

import SwiftUI

struct GameView: View {
    @State private var gameStarted: Bool = false
    @State private var gameEnded: Bool = false
    @State private var question: String = ""
    @State private var answer:[Int] = []
    @State private var correctAnswer: Int = 0
    @State private var selectedAnswer: Int?
    @State private var score: Int = 0
    @State private var currentQuestion: Int = 1
    @State private var timeRemaining: Int = 10
    @State private var timer=Timer.publish(every: 1, on: .main, in:.common).autoconnect()
    private let totalQuestions: Int = 5
    @State private var userName: String = ""
    @State var messageAlert:String=""
    var body: some View {
        ZStack{
              Image("backgroundImage")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.15)
          
              if !gameStarted {
                  VStack(spacing: 20){
                      
                      Text("Bienvenue au jeu de calcul")
                          .font(.largeTitle)
                          .padding(.vertical)
                      
                      InputsView(inputUser: $userName, placeholder: "Entrez votre compte github", imageName: "person.circle")
                          .padding()
                      
                      if !messageAlert.isEmpty{
                          Text(messageAlert)
                              .foregroundColor(.red)
                              //.multilineTextAlignment(.center)
                      }
                      
                      Button(action:{
                         // if userName.isEmpty{
                            //  messageAlert="Please fill all fields"
                             // return
                         // }
                          withAnimation(.easeInOut(duration: 0.5)){
                              self.gameStarted.toggle()
                              randomizeQuestions()
                          }
                         
                      }){
                          HStack(spacing: 10){
                              Text("Commencer")
                                  .font(.title)
                              Image(systemName: "chevron.right.circle")
                                  .font(.title)
                          }
                       }.padding()
                       .disabled(userName.isEmpty)
                      .foregroundColor(.white)
                      .bold(true)
                      .background(Color.indigo)
                          .cornerRadius(10)
                         
                  
                  }.padding(.horizontal,1)
              }
            
           else if gameStarted && !gameEnded {
               VStack{
                  
                   Text("Question \(currentQuestion) sur \(totalQuestions)").font(.title).padding()
                   Text(question).font(.largeTitle).padding()
                   VStack(spacing:20){
                       ForEach(0..<answer.count, id: \.self) { index in
                           Button(action:{
                               withAnimation(.linear(duration: 0.5))
                               {
                                   checkAnswer(answer[index])
                                   nextQuestion()
                               }
                           }){
                               //Text("\(answer.randomElement() ?? 0)")
                               Text("\(self.answer[index])")
                                   .font(.title)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                                   .foregroundColor(.white)
                                   .bold(true)
                                   .background(Color.indigo)
                                   .cornerRadius(10)
                           }
                       }
                          
                       VStack{
                           Text("Temps restant: \(timeRemaining)")
                               .font(.title2)
                               .foregroundColor(timeRemaining <= 3 ? .red : .primary)
                               .bold(true)
                               .padding(.top)
                               .onReceive(timer) { _ in
                                   guard gameStarted else { return }
                                   
                                   if timeRemaining > 0 {
                                       timeRemaining -= 1
                                   }
                                   else {
                                       nextQuestion()
                                   }
                               }
                           ProgressView(value: Double(timeRemaining), total: 10)
                               .padding(.top)
                               .progressViewStyle(LinearProgressViewStyle(tint: timeRemaining <= 3 ? .red : .green))
                               
                               
                       }
                          
                   } .padding()
                      
                                       
                }
               .padding()
            }
            else if gameEnded {
                VStack(spacing:20){
                Text("Jeu terminé!").font(.title).padding()
                Text("Score final: \(score)/\(totalQuestions)")
                    .font(.title)
                    .padding(.vertical)
                    .foregroundColor(score>2 ? .green :.red)
                    .bold(true)
                Button(action:{
                    resetGame()
                }){
                    HStack(spacing: 10){
                        Text("Recommencer")
                            .font(.title)
                        Image(systemName: "chevron.left.circle")
                            .font(.title)
                    }
                 }.padding()
                .foregroundColor(.white)
                .bold(true)
                .background(Color.indigo)
                    .cornerRadius(10)

            }.padding()
                           
            }
          }
    }
    
    func randomizeQuestions() {
        let number1:Int = Int.random(in: 0...100)
        let number2:Int = Int.random(in: 0...100)
        let operatorType:Int = Int.random(in: 0...3)
        switch operatorType {
        case 0:
            question = "\(number1) + \(number2)"
            correctAnswer = number1 + number2
        case 1:
            question = "\(number1) - \(number2)"
            correctAnswer = number1 - number2
        case 2:
            question = "\(number1) x \(number2)"
            correctAnswer = number1 * number2
        case 3:
            question = "\(number1) / \(number2)"
            correctAnswer = number1==0 ? 0 : number1 / number2
        default:
            break
        }
        //remplir les reponses aleatoires
        fillAnswerArray()
    }
    
    func fillAnswerArray() {
        answer.removeAll()
        var incorrectAnswers: [Int] = []
        while incorrectAnswers.count < 3 {
            let rand = Int.random(in: 1...400)
            // Vérifie que la réponse incorrecte est unique ET differente de la bonne réponse
           
            if rand != correctAnswer && !incorrectAnswers.contains(rand) {
                incorrectAnswers.append(rand)
            }
        }

        // Ajouter les réponses mauvaises dans answer
        answer = incorrectAnswers
        answer.append(correctAnswer) //ajouter la bonne reponse
        answer.shuffle() //Melanger tout
    }
    
    
   func checkAnswer(_ selectedAnswer: Int) {
        if selectedAnswer == correctAnswer {
            score += 1
        }
       
    }
    
    func  resetGame() {
        score = 0
        gameEnded = false
        gameStarted = false
        timeRemaining = 10
        currentQuestion=1
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    }
    
    func nextQuestion() {
        if currentQuestion < totalQuestions {
            currentQuestion += 1
            timeRemaining = 10
            randomizeQuestions()
        } else {
            gameEnded = true
            timer.upstream.connect().cancel() // arrêter le timer
        }
    }
}

#Preview {
    GameView()
}
