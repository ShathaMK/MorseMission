//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 25/08/1446 AH.
//

import Foundation
import SwiftUI

struct LoungeView: View {
    @ObservedObject var viewModel: GameViewModel
    @StateObject private var TranslatorViewModel = MorseTranslatorViewModel()
    @State private var isHintVisible = false // State to control text visibility
    @State private  var isClueFound = false
    @State private var isSelected = false
    @State private var isSelected2 = false
    @State private var isSelected3 = false
    @State private var showAlert = false
    @State private var alertText = ""
    @State private var moveOn = false
   // @State private var isCorrect = false
    @State private var showDialouge = false
   // @Binding var TrackScene: Scenes

    
    let morseCode = "-...  .-..  ..-  ."
    

    var body: some View {
        let currentScene = viewModel.scenes[viewModel.currentSceneIndex]
        let dialogues = currentScene.dialogues// Get all dialogues for the current scene
        
        // Calculate the range for the next pair of dialogues to show
        let startIndex = viewModel.currentDialogueIndex
        let endIndex = min(startIndex + 1, dialogues.count - 1) // Two dialogues at a time
        //
        
        ZStack {
            // Background
            Image(currentScene.backgroundImage)
                .resizable()
                .frame(width: getScreenBounds().width, height: getScreenBounds().height)
            // Show dialogues if enabled
            if viewModel.isDialogueVisible{
                VStack{
                    Rectangle()
                        .frame(width: getScreenBounds().width,height: 280)
                        .foregroundStyle(Color("DarkGrayColor"))
                        .opacity(0.75)
                        .cornerRadius(35)
                        .overlay(){
                            
                            VStack(spacing:-20) {
                                Spacer()
                                //
                                // "Next" Button
                                
                                
                                // Loop through the dialogues within the range of startIndex and endIndex
                                
                                ForEach(startIndex...endIndex, id: \.self) { index in
                                    let dialogue = dialogues[index]
                                    
                                    HStack {
                                        if dialogue.isRight {
                                            Spacer()
                                        }
                                        
                                        // Character + Dialogue
                                        HStack {
                                            if !dialogue.isRight {
                                                Image(dialogue.speakerPfp)
                                                    .resizable()
                                                    .frame(width: 140, height: 140)
                                                    .padding(.trailing, 20)
                                            }
                                            
                                            VStack(alignment: .leading) {
                                                Text(dialogue.speaker)
                                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                                    .foregroundColor(Color("FontColor"))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                ZStack(alignment: .leading) {
                                                    Text(dialogue.text)
                                                        .opacity(0) // Reserves space
                                                    TypeWriterEffect(text: dialogue.text)
                                                        .id(dialogue.text)
                                                }
                                            }
                                            .padding()
                                            .frame(width: 530, height: 100)
                                            .background(dialogue.bubbleColor)
                                            .cornerRadius(15)
                                            .overlay(alignment: dialogue.isRight ? .bottomTrailing : .bottomLeading) {
                                                Image(systemName: "arrowtriangle.down.fill")
                                                    .font(.title)
                                                    .rotationEffect(.degrees(dialogue.isRight ? -90 : 90))
                                                    .offset(x: dialogue.isRight ? 15 : -15, y: -10)
                                                    .foregroundStyle(dialogue.bubbleColor)
                                            }
                                            
                                            if dialogue.isRight {
                                                Image(dialogue.speakerPfp)
                                                    .resizable()
                                                    .frame(width: 140, height: 140)
                                                    .padding(.leading, 20)
                                            }
                                        }
                                        
                                        if !dialogue.isRight {
                                            Spacer()
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                
                                //
                                
                                Spacer()
                            }
                            
                        }
                    Spacer()
                    Button(action: {
                        
                        let groupSize = (endIndex - startIndex) + 1
                         // If there are still more dialogues in the current scene
                         if viewModel.currentDialogueIndex + groupSize < dialogues.count {
                             viewModel.currentDialogueIndex += groupSize
                         } else {
                             // Finished the dialogues for the current scene
                             if viewModel.currentSceneIndex == 1 {
                                 // Move to scene index 2 and reset dialogue index
                                 viewModel.moveToScene(index: 2)
                             } else if viewModel.currentSceneIndex == 2 {
                                 //if  no more dialogues in scene 2 hide the dialogue overlay
                                 viewModel.hideDialogues()
                             }
                         }
                     
                    
                                              
                                           
                       
                    }) {
                        Spacer()
                        Image("Next")//
                            .resizable()
                            .frame(width: 100, height: 40)
                    }
                    .padding()
                    //  .padding(.bottom,200)
                    //  Spacer()//
                }// end of VStack
            }
            else{
                ZStack{
                    
                    VStack{
                        HStack{
                            Spacer()
                            if isHintVisible {
                                VStack(spacing:-10){
                                    HStack{
                                        
                                        Text("Hint")
                                            .font(.title2)
                                            .bold()
                                            .padding()
                                            .foregroundStyle(Color(.black))
                                        Spacer()
                                    }
                                    Text("Click on objects to find clues").padding(.trailing,12)
                                    
                                }.frame(width:260,height: 80)
                                    .padding()
                                    .background(Color("YellowColor"))
                                    .cornerRadius(15)
                                Image(systemName: "arrowtriangle.down.fill")
                                    .font(.title)
                                    .rotationEffect(.degrees(-90))
                                    .offset(x:-15,y:10)
                                    .foregroundStyle(Color("YellowColor"))
                            }
                            // Spacer()
                            Button(action:{
                                isHintVisible.toggle()
                            }){
                                Image(systemName: "lightbulb.max.fill")
                                    .resizable()
                                    .frame(width:60,height: 60)
                                    .foregroundStyle(Color("YellowColor"))
                                
                            }
                        }
                        Spacer()
                    }.padding()
                    Spacer()
                    Spacer()
                
                    Button(action:{
                        isClueFound.toggle()
                    }){
                        Image("SmallBill").resizable().frame(width: 29,height: 69)
                    }.padding(.top,331)
                        .padding(.trailing,58)
                    if isClueFound{
                        Rectangle()
                            .frame(width:350,height: 623)
                            .foregroundStyle(Color("WhiteGrayColor"))
                            .overlay(){
                                VStack{
                                    Text("FIND ME")
                                        .font(.system(size: 50, weight: .bold, design: .rounded))
                                    VStack(spacing:-40){
                                        Text("-------------")   .font(.system(size: 40, weight: .thin, design: .rounded))
                                        Text("-------------")   .font(.system(size: 40, weight: .thin, design: .rounded))
                                    }
                                    Button(action: {
                                        TranslatorViewModel.morseText = morseCode // Set the Morse code to be decoded
                                        TranslatorViewModel.decodeMorseCode() // Call decoding function
                                        TranslatorViewModel.playTranslation() // Play the decoded message
                                        //                                    viewModel.playSound(for: letter.soundFile.wrappedValue)
                                        //                                    print("Speaker button //tapped for \(letter)")
                                    }) {
                                        Image(systemName: "speaker.wave.3.fill")
                                            .resizable()
                                            .frame(width: 55, height: 35)
                                            .foregroundColor(Color("PurpleColor"))
                                            .padding(11) // Increase padding for easier tap area
                                        // .background(Color("WhiteGrayColor").opacity(0.1)) // Subtle background for button
                                            .cornerRadius(15) // Rounded corners for the button
                                            .shadow(radius: 5) // Optional: subtle shadow to make the button pop
                                    }
                                    Text("-...  .-..  ..-  .")
                                        .font(.system(size:40, weight: .bold ,design: .rounded))
                                    //.foregroundStyle(Color("FontColor"))
                                    //    .frame(width: 120, height: 45, alignment: .bottom)
                                    //                                    if isSelected{
                                    //                                        alertText = "Correct answer ,you unlocked the first clue."
                                    //                                    }
                                    //                                    else{
                                    //                                        alertText = "Incorrect answer , try again."
                                    //                                    }
                                    SelectButton(isSelected: $isSelected, color:Color("PurpleColor") , text: "Blue")
                                        .onTapGesture {
                                            isSelected.toggle()
                                            if isSelected{
                                                // So one button selected at a time
                                                isSelected2 = false
                                                isSelected3 = false
                                            }
                                            checkAnswer()
                                        }
                                    SelectButton(isSelected: $isSelected2, color:.red , text: "Red")
                                        .onTapGesture {
                                            isSelected2.toggle()
                                            if isSelected2{
                                                // So one button selected at a time
                                                isSelected = false
                                                isSelected3 = false
                                            }
                                            checkAnswer()
                                        }
                                    SelectButton(isSelected: $isSelected3, color: .red , text: "White")
                                        .onTapGesture {
                                            isSelected3.toggle()
                                            if isSelected3{
                                                // So one button selected at a time
                                                isSelected = false
                                                isSelected2 = false
                                            }
                                            checkAnswer()
                                        }
                                    
                                    VStack(spacing:-40){
                                        Text("-------------")   .font(.system(size: 40, weight: .thin, design: .rounded))
                                        Text("-------------")   .font(.system(size: 40, weight: .thin, design: .rounded))
                                    }
                                }
                                .alert(isPresented: $showAlert) {
                                            // Alert displayed with result
                                            Alert(title: Text("Result"), message: Text(alertText), dismissButton: .default(Text("OK")) {
                                                // When alert is dismissed, check if the answer was correct and show the result text
                                                if isSelected {
                                                    showDialouge = true
                                                }
                                            })
                                        }
                            }
                            }
                        
                    }
                    
                    
               //
                }
                if moveOn {
                    if showDialouge{
                        VStack{
                            Rectangle()
                                .frame(width:getScreenBounds().width,height: 238)
                                .foregroundStyle(Color("DarkGrayColor"))
                                .opacity(0.75)
                                .cornerRadius(35)
                                .overlay(){
                                    ZStack() {
                                        
//                                        Button(action: viewModel.nextDialogue){
//                                            Spacer()
//                                            Image("Next").resizable()
//                                                .frame(width: 100, height: 40)
//
//                                        }.padding()
//                                            .padding(.bottom,120)
                                        Spacer()
                                        HStack {
                                            
                                            HStack{
                                                
                                                Image("SparkProfile")
                                                    .resizable()
                                                    .frame(width: 140, height: 140)
                                                    .padding(.trailing,20)
                                                
                                                HStack{
                                                    
                                                    VStack{
                                                        
                                                        Text("Detective Spark")
                                                            .font(.system(size: 20, weight:
                                                                    .bold, design: .rounded))
                                                            .foregroundColor(Color("FontColor"))
                                                            .padding(.trailing, 7)
                                                        
                                                        
                                                        ZStack(alignment: .leading) {
                                                            Text("We need to hurry up.")
                                                                .opacity(0) // Keeps space reserved to prevent movement
                                                            TypeWriterEffect(text: "We need to hurry up.")
                                                        }
                                                        
                                                    }
                                                    //
                                                    //   .padding()
                                                    // .padding(.trailing,60)
                                                    .frame(width:230,height:100)
                                                    
                                                    
                                                }
                                                .background(Color("PurpleColor"))
                                                .cornerRadius(15)
                                                .overlay(alignment: .bottomLeading){
                                                    Image(systemName:"arrowtriangle.down.fill")
                                                        .font(.title)
                                                        .rotationEffect(.degrees(90))
                                                        .offset(x: -15, y: -10)
                                                        .foregroundStyle(Color("PurpleColor"))
                                                }
                                                
                                                
                                            }
                                            Spacer()
                                        }.padding()
                                        
                                        HStack{
                                            
                                            Spacer()
                                            
                                            HStack{
                                                
                                                
                                                VStack{
                                                    
                                                    Text("Detective Flash")
                                                        .font(.system(size: 20, weight:
                                                                .bold, design: .rounded))
                                                        .foregroundColor(Color("FontColor"))
                                                        .padding(.trailing,360)
                                                    
                                                    ZStack(alignment: .leading) {
                                                        Text("The event is about to start. Lets check the stage.")
                                                            .opacity(0) // Keeps space reserved to prevent movement
                                                        TypeWriterEffect(text:" The event is about to start. Lets check the stage.")
                                                    }
                                                    //  Spacer()
                                                    
                                                    
                                                    
                                                }
                                                .padding()
                                                //  .padding(.trailing,0)
                                                .frame(width:550,height:100)
                                                
                                            }//
                                            .background(Color("DarkGrayColor"))
                                            .cornerRadius(15)
                                            .overlay(alignment: .bottomLeading){
                                                Image(systemName:"arrowtriangle.down.fill")
                                                    .font(.title)
                                                    .rotationEffect(.degrees(-90))
                                                    .offset(x: 240, y: -10)
                                                    .foregroundStyle(Color("DarkGrayColor"))
                                                
                                                //
                                            }
                                            Image("FlashProfile")
                                                .resizable()
                                                .frame(width: 140, height: 140)
                                                .padding(.leading,20)
                                        }.padding(.top,90)
                                            .padding()
                                        
                                    }
                                }
                            Spacer()
                        }// end of VStack
                   
                 
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                               //
                                NavigationLink(destination: StageView()
                                  ){
                                   
                                     //   currentScene = 2 // Move to Scene 2
                                    //TrackScene = .stage
                                    
                                        ZStack{
                                            Rectangle().foregroundStyle(Color("PurpleColor"))
                                                .frame(width:150,height: 50)
                                                .cornerRadius(15)

                                        Text("Go to Lounge") .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("FontColor"))
                                       
                                         ////
                                           
                                    }
                                                        
                                }
                                    .padding()
                                
                            }
                        }
                      
                    }//
                }
           //
            }.navigationBarHidden(true)
            
        }
    
    private func checkAnswer() {
        if isSelected { // Spy is the correct answer
            alertText = "Correct answer! \nYou unlocked the Second clue."
            moveOn = true
           
        } else {
            alertText = "Incorrect answer \n Please try again."
        }
        showAlert = true // Show the alert
    }
        }
           // }
            //
          
          //
        //




//




