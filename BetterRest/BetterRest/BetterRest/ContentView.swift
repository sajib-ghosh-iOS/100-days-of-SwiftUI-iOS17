//
//  ContentView.swift
//  BetterRest
//
//  Created by Sajib Ghosh on 02/12/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var title = ""
    @State private var message = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date{
        var component = DateComponents()
        component.hour = 7
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date()
    }
    var body: some View {
        
        NavigationView{
            Form{
                Section("When do you want to wake up?") {
                    DatePicker("Please eneter a time", selection: $wakeUp,displayedComponents: .hourAndMinute).labelsHidden()
                }
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount,in: 4...12, step: 0.25)
                }
                Section("Daily coffee intake") {
                    Picker("^[\(coffeeAmount) cup](inflect:true)", selection: $coffeeAmount) {
                        ForEach(0..<20){
                            Text("\($0)")
                        }
                    }
                    //Stepper(, value: $coffeeAmount,in: 1...20)
                }
            }.navigationTitle("BetterRest")
                .toolbar {
                    Button("Calculate", action: calculateBedTime)
                        .alert(title, isPresented: $showingAlert) {
                            Button("OK"){}
                        }message: {
                            Text(message)
                        }
                }
        }
            
        
    }
    
    func calculateBedTime() {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            title = "Your ideal bedtime is..."
            message = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            title = "Error"
            message = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true

    }
    
    func exampleDates() -> Date{
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)
        // create a range from those two
        let range = Date.now...tomorrow
        var components = DateComponents()
        components.month = 4
        components.day = 5
        let date = Calendar.current.date(from: components) ?? Date()
        print(date)
        return date
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
