//
//  DecodePage.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 21/08/1446 AH.
//

import SwiftUI

struct TranslatorView: View {

    @ObservedObject var viewModel = MorseLettersViewModel()
    @StateObject private var TranslatorViewModel = MorseTranslatorViewModel()
    @State private var selectedMode: Mode = .encode // initall mode

      enum Mode {
          case encode, decode
      }

   var body: some View {
       ZStack{
           Color("BackgroundColor").edgesIgnoringSafeArea(.all)
           
                    
                     
           HStack{
               
               VStack{
                   
                   Spacer()
                   
                   HStack {
                       Picker("Mode", selection: $selectedMode) {
                           Text("Encode")
                               .tag(Mode.encode)
                           Text("Decode")
                               .tag(Mode.decode)
                       }
                       .pickerStyle(SegmentedPickerStyle())
                       .padding(8)
                       .background(Color("DarkGrayColor").opacity(0.6))
                       .clipShape(RoundedRectangle(cornerRadius: 15))
                       .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("PurpleColor"), lineWidth: 2)
                       )
                       .frame(width: 400)
                   
                   }
                   // UI changes based on selected mode (Languages text fields switch)
                                 if selectedMode == .encode {
                                     encodeView
                                 } else {
                                     decodeView
                                 }
         

                       }
              
           }
           

       }
    }
    
    //
    
    private var encodeView:some View{
        
        VStack{
            
            Spacer()

            Text("English")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color("FontColor"))
                .frame(maxWidth:771,alignment: .topLeading)
            TextField("", text:$TranslatorViewModel.englishText ,prompt: Text(" Apple ")
                .foregroundColor(Color("FontColor"))
                .font(.system(size: 35)))
                .padding()
                .frame(width: 770, height: 220, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 40, design: .rounded))
                .foregroundColor(Color("FontColor"))
       
         
            
            
           
            Spacer()
            Spacer()
            Text("Morse")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color("FontColor"))
                .frame(maxWidth:771,alignment: .topLeading)
            
            TextField("", text:$TranslatorViewModel.morseText ,prompt: Text(" .- .--. .--. .-.. . ").foregroundColor(Color("FontColor")).font(.system(size: 40)))
                .padding()
                .frame(width: 770, height: 220, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 40, design: .rounded))
                .foregroundColor(Color("FontColor"))
                .overlay(content: {
                    Button(action:{
                        TranslatorViewModel.playTranslation()}){
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 50, height: 40,alignment: .topTrailing)
                            .foregroundColor(Color("PurpleColor"))
                            .padding(.leading,650)
                            .padding(.bottom,130)
                    }
                })
             
            Spacer()
            
                       Button(action: {
                           TranslatorViewModel.encodeEnglishText()
                       }) {
                           Text("Enccode").font(.system(.title,design: .rounded)).fontWeight(.bold).foregroundStyle(Color("FontColor"))
                               .frame(width: 770, height: 50)
                               .background(Color("PurpleColor"))
                               .cornerRadius(10)
                       }
            Spacer()
            Spacer()
            Spacer()
            
        }
        
    }
    
    
    
    private var decodeView:some View{
        
        VStack{
            
            Spacer()

     
            Text("Morse").font(.system(.largeTitle, design: .rounded)).fontWeight(.medium).foregroundStyle(Color("FontColor"))
                .frame(maxWidth:771,alignment: .topLeading)
            
            TextField("", text:$TranslatorViewModel.morseText ,prompt: Text(" .- .--. .--. .-.. . ").foregroundColor(Color("FontColor")).font(.system(size: 40)))
                .padding()
                .frame(width: 770, height: 220, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 40, design: .rounded))
                .foregroundColor(Color("FontColor"))
                .overlay(content: {
                    Button(action:{    TranslatorViewModel.playTranslation()}){
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 50, height: 40,alignment: .topTrailing)
                            .foregroundColor(Color("PurpleColor"))
                            .padding(.leading,650)
                            .padding(.bottom,130)
                    }
                })
         
            
            
           
            Spacer()
            Spacer()
            Text("English")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color("FontColor"))
                .frame(maxWidth:771,alignment: .topLeading)
            TextField("", text:$TranslatorViewModel.englishText ,prompt: Text(" Apple ")
                .foregroundColor(Color("FontColor")).font(.system(size: 35)))
                .padding()
                .frame(width: 770, height: 220, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 40, design: .rounded))
                .foregroundColor(Color("FontColor"))
             
            Spacer()
            
                       Button(action: {
                           TranslatorViewModel.decodeMorseCode()
                       }) {
                           Text("Decode")
                               .font(.system(.title,design: .rounded))
                               .fontWeight(.bold)
                               .foregroundStyle(Color("FontColor"))
                               .frame(width: 770, height: 50)
                               .background(Color("PurpleColor"))
                               .cornerRadius(10)
                       }
            Spacer()
            Spacer()
            Spacer()
            
        }
        
    }


}

