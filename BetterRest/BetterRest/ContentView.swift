//
//  ContentView.swift
//  BetterRest
//
//  Created by Manideep Gattamaneni on 1/17/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount + 1))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    Spacer()
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUp){
                            calculateBedtime()
                        }
                }
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25).onChange(of: sleepAmount){ calculateBedtime()}
                }.font(.headline)
                Section {
                    Picker("Daily coffee intake", selection: $coffeeAmount){
                        ForEach(1..<20){
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }.onChange(of: coffeeAmount){ calculateBedtime()}
                        .pickerStyle(.navigationLink)
                }.font(.headline)
                Section{
                    HStack{
                        Text("Ideal bed time").font(.headline)
                        Spacer()
                        Text("\(alertMessage)")
                    }
                }
            }.navigationTitle("BetterRest")
        }.onAppear(perform: {
            calculateBedtime()
        })
    }
}

#Preview {
    ContentView()
}
