//
//  ContentView.swift
//  Practice1
//
//  Created by Sajib Ghosh on 25/11/23.
//

import SwiftUI
import Foundation

enum Units: String, Hashable {
    case meters = "meters"
    case kilometers = "kilometers"
    case feet = "feet"
    case yards = "yards"
    case miles = "miles"
}

let unitMeasureDict = [Units.meters:UnitLength.meters,Units.kilometers:UnitLength.kilometers,Units.feet:UnitLength.feet,Units.yards:UnitLength.yards,Units.miles:UnitLength.miles]

struct ContentView: View {
    @State private var enteredTemp = 0.0
    @State private var inputUnit = Units.meters
    @State private var outputUnit = Units.meters
    @FocusState private var isTempFocused: Bool
    
    private var units = [Units.meters,Units.kilometers,Units.feet,Units.yards,Units.miles]

    var convertedTemp: Double {
        let inputTemp = Measurement(value: enteredTemp, unit: unitMeasureDict[inputUnit]!)
        let outputTemp = inputTemp.converted(to: unitMeasureDict[outputUnit]!)
        return outputTemp.value
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Enter value", value: $enteredTemp, formatter: NumberFormatter()).keyboardType(.decimalPad).focused($isTempFocused)
                    Picker("Select Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self){
                            Text("\($0.rawValue)")
                        }
                    }
                    Picker("Select Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self){
                            Text("\($0.rawValue)")
                        }
                    }
                    Section{
                        //Text(convertedTemp, format: NumberFormatter().)
                        Text(convertedTemp, format: .number)
                    }header: {
                        Text("Converted value:")
                    }
                }
            }
            .navigationTitle("Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
