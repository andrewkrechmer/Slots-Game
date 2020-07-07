//
//  CardView.swift
//  SwiftUITutorial.SlotsApp
//
//  Created by Andrew Krechmer on 2020-04-06.
//  Copyright © 2020 Andrew Krechmer. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @Binding var symbols:String
    @Binding var backgrounds:Color
    
    var body: some View {
        
        Image(symbols)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .background(backgrounds.opacity(0.5)).cornerRadius(20)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbols: Binding.constant("cherry"), backgrounds: Binding.constant(Color.pink))
    }
}
