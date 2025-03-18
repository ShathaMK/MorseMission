//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 24/08/1446 AH.
//

import SwiftUI

struct SelectButton: View{
    @Binding var isSelected: Bool
    @State var color: Color
    @State var text: String

    var body: some View {
        ZStack{
            Rectangle()
                .frame(width:150,height: 50)
                .foregroundColor(isSelected ? color : .gray)
                .cornerRadius(15)
                Text(text)
                .foregroundStyle(Color("FontColor"))
                

        }
    
        
    }
}

struct SelectButton_previews: PreviewProvider {
    static var previews: some View {
        SelectButton(isSelected: .constant(false), color: Color("PurpleColor"), text: "Option")
    }
}
