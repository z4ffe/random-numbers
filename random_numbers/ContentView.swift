//
//  ContentView.swift
//  Hello_World
//
//  Created by Paul Lightman on 03.12.2023.
//

import SwiftUI
import ConfettiSwiftUI


struct ContentView: View {
    @State private var greeting = "Hello!"
    @State private var randomNumber = 0
    @State private var minVal = "1"
    @State private var maxVal = "100"
    @State private var initApp = false
    @State private var firstLaunch = true
    @State private var winner = false
    @State private var userName = ""
    @State private var winValue = ""
    @State private var confettiTrigger = 0
    
    func resetState() -> Void {
        randomNumber = 0
        minVal = "1"
        maxVal = "100"
        initApp = false
        winner = false
        winValue = ""
    }
    
    func setUserName() -> Void {
        greeting = "Hello, \(userName)!"
    }
    
    func generateRandomNumber () -> Int {
        initApp = true
        let intMinVal = Int(minVal) ?? 1
        let intMaxVal = Int(maxVal) ?? 100
        let rndNum = Int.random(in: intMinVal...intMaxVal)
        if (rndNum == Int(winValue)) {
            print(rndNum)
            print(winValue)
            winner = true
            confettiTrigger = confettiTrigger + 1
        }
        return rndNum
    }
    
    func buttonGenText () -> String {
        if (initApp && winner) {
            return "Start again"
        }
        switch self.initApp {
        case false:
            return "Press for generate"
        case true:
            return "Try again"
        }
    }
    
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    var body: some View {
        VStack{
            if (winner) {
                Text("Congratulations!")
                    .bold()
                    .monospaced()
                    .font(.system(size: 30))
                    .padding(20)
                    .foregroundColor(.cyan)
                        
            }
        }
        VStack {
            Text(greeting)
                .monospaced()
                .bold()
            Divider()
                .frame(width: 270)
            Text("Random Numbers")
                .monospaced()
                .bold()
            Text("Generator")
                .monospaced()
                .bold()
        }
        VStack {
            Text(String(randomNumber))
                .padding(5)
                .font(.system(size: 175))
                .blur(radius: initApp ? 0 : 10)
                .animation(.interactiveSpring(duration: 1), value: randomNumber)
        }
        Divider()
            .frame(width: 270)
        HStack {
            Spacer()
            TextField("Minimum", text: $minVal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(3)
                .padding(20)
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
                .keyboardType(.numberPad)
            Text("-")
                .padding(0)
            TextField("Maximum", text: $maxVal)
                .frame(width: 100)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(3)
                .padding(20)
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
                .keyboardType(.numberPad)
            Spacer()
        }
        .monospaced()
        .bold()
        VStack {
            TextField("Enter win number...", text: $winValue)
                .bold()
                .monospaced()
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
        }
        Divider()
            .frame(width: 270)
        VStack {
            Button(buttonGenText()) {
                hideKeyboard()
                if (winner && initApp) {
                    resetState()
                }
                randomNumber = generateRandomNumber()
            }
            .padding()
            .foregroundColor(Color.white)
            .background(Color.black)
            .cornerRadius(10.0)
            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            .monospaced()
            .frame(width: 300, height: 100)
            .confettiCannon(counter: $confettiTrigger, num: 200, confettiSize: 15, rainHeight: 700, radius: 700)
        }
        .alert("Hello!", isPresented: $firstLaunch) {
            TextField("Enter your name", text: $userName)
                .textInputAutocapitalization(.never)
                .bold()
                .monospaced()
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
            Button("Join") {
                setUserName()
            }
            .bold()
            .monospaced()
            .font(.system(size: 15))
        }
    }
}

#Preview {
    ContentView()
}
