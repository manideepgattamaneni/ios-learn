//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Manideep Gattamaneni on 1/28/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedNumber=2
    @State private var numberOfQuestions=5
    @State private var startGame = false
    @State private var multiplicand: Int = 1
    @State private var product = 0
    @State private var score = 0
    @State private var question = 1
    @State private var showScore = false
    
    func getrandomMultiplicand() -> Int {
        return Int.random(in: 1...10)
    }
    
    func reset(){
        score = 0
        question = 1
        multiplicand = getrandomMultiplicand()
        startGame.toggle()
    }
    
    let questions=[5,10,20]
    
    var body: some View {
        NavigationStack{
            List{
                if(startGame){
                    VStack{
                        Text("\(question) / \(numberOfQuestions)")
                        Text("\(selectedNumber) X \(multiplicand)").font(.largeTitle)
                        TextField("Enter Answer",value: $product, format: .number).keyboardType(.numberPad)
                        Button("submit"){
                            if(selectedNumber * multiplicand == product){
                                score+=1
                            }
                            if(question == numberOfQuestions){
                                showScore = true
                            }else{
                                multiplicand = getrandomMultiplicand()
                                question+=1
                            }
                        }
                        
                    }.onAppear{
                        multiplicand = getrandomMultiplicand()
                    }.alert("End Game",isPresented: $showScore){
                        Button("Reset", action:reset)
                    } message: {
                        Text("Your final score is \(score)")
                    }
                }
                else{
                    Section{
                        Picker("Select a Number", selection: $selectedNumber){
                            ForEach(2...12, id:\.self){num in
                                Text("\(num)")
                            }
                        }.pickerStyle(.navigationLink)
                    }
                    Section("Number of questions"){
                        Picker("Select number of questions", selection: $numberOfQuestions){
                            ForEach(questions, id:\.self){ question in
                                Text("\(question)")
                            }
                        }.pickerStyle(.segmented)
                    }
                    Button("Start Game") {
                        startGame.toggle()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .buttonBorderShape(.capsule)
                }
                
            }.navigationTitle("Multiplication Table")
        }
    }
}

#Preview {
    ContentView()
}
