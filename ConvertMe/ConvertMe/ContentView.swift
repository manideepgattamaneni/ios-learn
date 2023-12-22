//
//  ContentView.swift
//  ConvertMe
//
//  Created by Manideep Gattamaneni on 12/22/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputText = 0.0
    
    @State private var inputDimension = UnitTemperature.celsius
    @State private var outputDimension = UnitTemperature.celsius
    
    func convertTo(value: Double, from: Dimension, to: Dimension) -> Double {return Measurement(value: value, unit: from).converted(to: to).value}
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Select from"){
                    Picker("Input Dimension",selection: $inputDimension){
                        ForEach(UnitTemperature.cases, id: \.self){ temp in
                            Text(temp.symbol)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("convert to"){
                    Picker("Output Dimension",selection: $outputDimension){
                        ForEach(UnitTemperature.cases, id: \.self){ temp in
                            Text(temp.symbol)
                        }
                    }.pickerStyle(.segmented)
                }
                
                
                Section("Enter temperature"){
                    TextField("input temp", value: $inputText, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section("converted temperature"){
                    Text(convertTo(value: inputText, from: inputDimension, to: outputDimension), format:.number)
                }
            }
        }
    }
}

extension UnitTemperature {
    public static var cases: [UnitTemperature] {
        return [.celsius, .fahrenheit, .kelvin]
    }
}

#Preview {
    ContentView()
}
