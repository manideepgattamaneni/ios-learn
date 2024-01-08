//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Manideep Gattamaneni on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    
    enum moves: String, CaseIterable {
        case rock,paper,scissor
    }
    
    @State private var shouldWin = false
    @State private var appChoice = moves.allCases.randomElement()
    
    @State private var score = 0
    
    func getCorrectMove() -> moves? {
        switch appChoice {
        case .rock:
            shouldWin ? moves.paper: moves.scissor
        case .paper:
            shouldWin ? moves.scissor : moves.rock
        case .scissor:
            shouldWin ? moves.rock : moves.paper
        case .none:
            nil
        }
    }
    
    func moveTapped(_ move: moves){
        if(getCorrectMove() == move){
            score = score+1
        }
        appChoice = moves.allCases.randomElement()
        shouldWin.toggle()
    }
    
    
    var body: some View {
        VStack{
            VStack{
                Text(appChoice!.rawValue)
                Text(shouldWin ? "Win" : "Lose")
            }
            
            HStack {
                ForEach(moves.allCases, id:\.rawValue){ move in
                    Button(move.rawValue){
                        moveTapped(move)
                    }.buttonStyle(.borderedProminent)
                }
                
            }
            .padding()
            
            Text("score: \(score)")
        }
    }
    
}

#Preview {
    ContentView()
}
