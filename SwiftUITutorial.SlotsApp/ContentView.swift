//
//  ContentView.swift
//  SwiftUITutorial.SlotsApp
//
//  Created by Andrew Krechmer on 2020-04-05.
//  Copyright © 2020 Andrew Krechmer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits = 1000
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    private var betAmount = 5
    
    var body: some View {
        
        ZStack {
               
                   // Background
                   Rectangle()
                       .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                       .edgesIgnoringSafeArea(.all)
                   
                   Rectangle()
                       .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                       .rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(.all)
                   
                   VStack {
                    
                    Spacer()
                       
                    // Title
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("SwiftUI Slots")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }.scaleEffect(2)
                    
                    Spacer()
                    
                    // Credits counter
                    Text("Credits: " + String(credits))
                        .foregroundColor(.black)
                        .padding(.all, 10)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Spacer()
                    
                    // Cards
                    VStack {
                    
                        HStack{
                            Spacer()
                           
                            CardView(symbols: $symbols[numbers[0]], backgrounds: $backgrounds[0])
                            
                            CardView(symbols: $symbols[numbers[1]], backgrounds: $backgrounds[1])
                            
                            CardView(symbols: $symbols[numbers[2]], backgrounds: $backgrounds[2])
                            
                            Spacer()
                        }
                        
                        HStack{
                            Spacer()
                           
                            CardView(symbols: $symbols[numbers[3]], backgrounds: $backgrounds[3])
                            
                            CardView(symbols: $symbols[numbers[4]], backgrounds: $backgrounds[4])
                            
                            CardView(symbols: $symbols[numbers[5]], backgrounds: $backgrounds[5])
                            
                            Spacer()
                        }
                        
                        HStack{
                            Spacer()
                           
                            CardView(symbols: $symbols[numbers[6]], backgrounds: $backgrounds[6])
                            
                            CardView(symbols: $symbols[numbers[7]], backgrounds: $backgrounds[7])
                            
                            CardView(symbols: $symbols[numbers[8]], backgrounds: $backgrounds[8])
                            
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    // Button
                    HStack (spacing: 20){
                        
                        VStack {
                            Button(action: {
                                
                                // Play sound
                                playSound(sound: "Pull", type: "mp3")
                                
                                // Process a single spin
                                self.processResults()
                                
                            }) {
                                Text("Spin")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.all, 10)
                                    .padding([.leading, .trailing], 30)
                                    .background(Color.pink)
                                    .cornerRadius(20)
                            }
                            Text("\(betAmount) credits").padding(.top, 10).font(.footnote)
                        }
                        
                        
                        VStack {
                            Button(action: {
                                
                                // Play sound
                                playSound(sound: "Pull", type: "mp3")
                                
                                // Process a single spin
                                self.processResults(true)
                                
                            }) {
                                Text("Max Spin")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.all, 10)
                                    .padding([.leading, .trailing], 30)
                                    .background(Color.pink)
                                    .cornerRadius(20)
                            }
                            Text("\(betAmount * 5) credits").padding(.top, 10).font(.footnote)
                        }
                        
                    }
                    
                    
                    Spacer()
                    
            }
        }
        
        
    }
    
    func processResults(_ isMax:Bool = false) {
        
        // Set backgrounds back to white
        self.backgrounds = self.backgrounds.map { _ in
            Color.white
        }
        
        if isMax {
            // Spin all the cards
            self.numbers = self.numbers.map({ _ in
                
                Int.random(in: 0...self.symbols.count - 1)
                
            })
        }
        else {
            
            // Spin the middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
            
        }
        
        // Check Winnings
        processWin(isMax)
    }
    
    func processWin(_ isMax:Bool = false) {
        
        var matches = 0
        
        if !isMax {
            
            // Processing for single spin
            if isMatch(3,4,5) {
                playSound(sound: "Win", type: "mp3")
                matches += 1
            }
            
        }
        else {
            // Processing for max spin
            
            // Top Row
           if isMatch(0,1,2) {
            playSound(sound: "Win", type: "mp3")
            matches += 1
            
            }
            
            // Middle row
           if isMatch(3,4,5) {
           playSound(sound: "Win", type: "mp3")
           matches += 1
           
           }
            
            // Bottom Row
           if isMatch(6,7,8) {
           playSound(sound: "Win", type: "mp3")
           matches += 1
           
           }
            
            // Diagonal top left to bottom right
           if isMatch(0,4,8) {
           playSound(sound: "Win", type: "mp3")
           matches += 1
           
           }
            
            // Diagonal top right to bottom left
           if isMatch(2,4,6) {
           playSound(sound: "Win", type: "mp3")
           matches += 1
           
           }
        }
        
        // Check matches and distribute credits
        if matches > 0 {
            // At least 1 win
            self.credits += matches * betAmount * 2
        }
        else if !isMax {
            // 0 wins single spin
            self.credits -= betAmount
        }
        else {
            // 0 wins, max spin
            self.credits -= betAmount * 5
        }
        
        // Print credit amount to concil
        print(self.credits)
    }
    
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int) -> Bool {
        
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3] {
            
            self.backgrounds[index1] = Color.green
                self.backgrounds[index2] = Color.green
                self.backgrounds[index3] = Color.green
            
            return true
        }
        
        return false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
