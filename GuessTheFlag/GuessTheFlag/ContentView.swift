//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Manideep Gattamaneni on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var endGame = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfQuestionsAsked = 1
    
    @State private var selectedFlag = -1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .titleStyle()
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                            
                        } label: {
                            FlagImage(imageName: countries[number])
                                .rotation3DEffect(.degrees(selectedFlag == number ? 360: 0), axis: (x: 0, y: 1, z: 0))
                                .animation(.default, value: selectedFlag)
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Button("Next Question"){
                    askQuestion()
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                Spacer()
                
                Text("\(numberOfQuestionsAsked) / 8")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        //        .alert(scoreTitle, isPresented: $showingScore) {
        //            Button("Continue", action: askQuestion)
        //        } message: {
        //            Text("Your score is \(score)")
        //        }
        .alert("End Game",isPresented: $endGame){
            Button("Reset", action:reset)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            
            scoreTitle = "Correct"
            score = score+1
            selectedFlag = number
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        
        if (numberOfQuestionsAsked == 8){
            endGame = true
        }else {showingScore = true}
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numberOfQuestionsAsked = numberOfQuestionsAsked+1
        selectedFlag = -1
    }
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        numberOfQuestionsAsked = 1
    }
    
    struct FlagImage: View {
        var imageName: String
        
        var body: some View {
            Image(imageName)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
    
    
}
struct Title: ViewModifier{
    func body(content: Content) -> some View{
        content.font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

#Preview {
    ContentView()
}
