//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 24/08/1446 AH.
//
import SwiftUI

struct TypeWriterEffect: View {
    
    let text: String
   @State private var displayCharacters = ""
    let timer = Timer.publish(every: 0.065, on: .main, in: .common).autoconnect()
    
    

    var body: some View {
        Text(displayCharacters)
            .font(.system(size: 14, weight: .regular,design: .rounded))
            .foregroundStyle(Color("FontColor"))
            .onReceive(timer) { _ in
                if displayCharacters.count < text.count {
                    let index = text.index(text.startIndex, offsetBy: displayCharacters.count)
                    displayCharacters.append(text[index])
                }
            }
    }
}
