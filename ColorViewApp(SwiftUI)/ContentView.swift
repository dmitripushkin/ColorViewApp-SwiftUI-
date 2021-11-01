//
//  ContentView.swift
//  ColorViewApp(SwiftUI)
//
//  Created by Повелитель on 30.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue: Double = 53
    @State private var greenSliderValue: Double = 152
    @State private var blueSliderValue: Double = 202
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            VStack(spacing: 60) {
                ColorView(
                    redValue: redSliderValue/255,
                    greenValue: greenSliderValue/255,
                    blueValue: blueSliderValue/255
                )
                    .cornerRadius(25)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 3))
                    .frame(height: 300)
                    .shadow(color: .yellow, radius: 7, x: 1, y: 1)
                
                VStack(spacing: 30) {
                    CustomSlider(
                        value: $redSliderValue,
                        sliderColor: .red,
                        textLabelColor: .red
                    )
                    CustomSlider(
                        value: $greenSliderValue,
                        sliderColor: .green,
                        textLabelColor: .green
                    )
                    CustomSlider(
                        value: $blueSliderValue,
                        sliderColor: .blue,
                        textLabelColor: .blue
                    )
                }
                
                Spacer()
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            })
            .padding()
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}

struct ColorView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    var body: some View {
        Color(red: redValue, green: greenValue, blue: blueValue)
    }
}

struct CustomSlider: View {
    @Binding var value: Double
    
    let sliderColor: Color
    let textLabelColor: Color
    
    var body: some View {
        
        HStack {
            Text("\(lround(value))").frame(width: 32)
                .foregroundColor(textLabelColor)
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(sliderColor)
            
            TextField("", value: $value, format:.number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 45)
                .keyboardType(.decimalPad)
        }
    }
}

// MARK: - Найдено в интернете)
//я даже не смогу объяснить, что здесь происходит кто, куда, кого и зачем, разве только, что через синглтон сбрасываются на nil все значения :)
#if canImport(UIKit)
extension ContentView {
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
