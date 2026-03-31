//
//  File.swift
//  Morse Mission
//
//  Created by Shatha Almukhaild on 23/09/1447 AH.
//

import SwiftUI

struct GlassOrClipModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect(.regular, in: UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 35,
                    bottomTrailingRadius: 35,
                    topTrailingRadius: 0
                ))
        } else {
            content
                .foregroundStyle(Color("DarkGrayColor"))
                .opacity(0.75)
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 35,
                    bottomTrailingRadius: 35,
                    topTrailingRadius: 0
                ))
        }
    }
}

//extension
extension View {
    func dialogueGlassEffect() -> some View {
        self.modifier(GlassOrClipModifier())
    }
}
