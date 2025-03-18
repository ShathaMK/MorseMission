//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 25/08/1446 AH.
//

import Foundation
import SwiftUI

struct StageView: View {
    @State private var ShowQuestions = false
    @State private var currentAnswerTim1: String = ""
    @State private var currentAnswerTim2: String = ""
//
    var body: some View {
        ZStack{
            //Spacer()
            if !ShowQuestions{
                VStack{
                    Rectangle()
                        .frame(width:getScreenBounds().width,height: 238)
                        .foregroundStyle(Color("DarkGrayColor"))
                        .opacity(0.75)
                        .cornerRadius(35)
                        .overlay(){
                            ZStack() {
                                
                                Button(action:{
                                    ShowQuestions = true
                                }){
                                    Spacer()
                                    Image("Next").resizable()
                                        .frame(width: 100, height: 40)
                                    
                                }.padding()
                                    .padding(.bottom,120)
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
                                                    .padding(.trailing, 120)
                                                
                                                
                                                ZStack(alignment: .leading) {
                                                    Text("Two Tims? That can't be—something's off.")
                                                        .opacity(0) // Keeps space reserved to prevent movement
                                                    TypeWriterEffect(text: "Two Tims? That can't be—something's off.")
                                                }.padding(.leading,9)
                                                
                                            }
                                            //
                                            .padding()
                                            // .padding(.trailing,60)
                                            .frame(width:330,height:100)
                                            
                                            
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
                                                .padding(.trailing,100)
                                            
                                            ZStack(alignment: .leading) {
                                                Text("Agreed. Let's get some answers.")
                                                    .opacity(0) // Keeps space reserved to prevent movement
                                                TypeWriterEffect(text:" Agreed. Let's get some answers.")
                                            }
                                            //  Spacer()
                                            
                                            
                                            
                                        }
                                        .padding()
                                        //  .padding(.trailing,0)
                                        .frame(width:330,height:100)
                                        
                                    }//
                                    .background(Color("DarkGrayColor"))
                                    .cornerRadius(15)
                                    .overlay(alignment: .bottomLeading){
                                        Image(systemName:"arrowtriangle.down.fill")
                                            .font(.title)
                                            .rotationEffect(.degrees(-90))
                                            .offset(x:320, y: -10)
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
                        }.padding(.bottom,600)
                    
                    Spacer()
                }// end of VStack
            }
            else{
                Spacer()
                VStack{
                    Spacer()
                    Rectangle()
                        .frame(width:getScreenBounds().width,height: 238)
                        .foregroundStyle(Color("DarkGrayColor"))
                        .opacity(0.75)
                        .cornerRadius(35)
                        .overlay(){
                          
                                Spacer()
                                VStack(spacing: -50){
                                   
                                    HStack(alignment: .center,spacing: 50){//
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Text("Who is the real Tim Cook ?")  .font(.system(size: 40, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("FontColor"))
                                        Spacer()
                                        Spacer()
                                        Button(action:{})
                                        {
                                         //   Spacer()
                                            NavigationLink(destination: VotingView()){
                                                ZStack{
                                                    Rectangle().foregroundStyle(Color("YellowColor")).opacity(0.9)
                                                        .frame(width:120,height: 50)
                                                        .cornerRadius(15)
                                                    
                                                    Text("Vote")
                                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                                        .foregroundColor(.black)
                                                    
                                                }
                                                
                                            }
                                            
                                            
                                        }.padding()
                                        Spacer()
                                    }
                                       
                                    Spacer()
                                    
                                  Spacer()
                                    HStack(spacing:20){
                                        Spacer()
                                        Button(action:{
                                            // Clear previous answers
                                               currentAnswerTim1 = ""
                                               currentAnswerTim2 = ""
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                                currentAnswerTim1 = "I was backstage, preparing my keynote presentation."
                                                currentAnswerTim2 = "I was rehearsing in the main hall."
                                            }
                                        })
                                        {
                                       
                                                ZStack{
                                                    Rectangle().foregroundStyle(Color("PurpleColor"))
                                                        .frame(width:420,height: 50)
                                                        .cornerRadius(15)
                                                    
                                                    Text("Where were you before coming on stage?") .font(.system(size: 20, weight: .bold, design: .rounded))
                                                        .foregroundColor(Color("FontColor"))
                                                }
                                                
                                            
                                       
                                        }
                                        Button(action:{
                                            // Clear previous answers
                                               currentAnswerTim1 = ""
                                               currentAnswerTim2 = ""
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                                currentAnswerTim1 = "Actually, it all began with the Apple I."
                                                currentAnswerTim2 = "Uh... the first Apple product was the Macintosh, right?"
                                            }
                                            
                                        })
                                        {
                                       
                                                ZStack{
                                                    Rectangle().foregroundStyle(Color("PurpleColor"))
                                                        .frame(width:300,height: 50)
                                                        .cornerRadius(15)
                                                    
                                                    Text("What’s Apple first product ?") .font(.system(size: 20, weight: .bold, design: .rounded))
                                                        .foregroundColor(Color("FontColor"))
                                                }
                                                
                                            
                                       
                                        }
                                        Button(action:{
                                            // Clear previous answers
                                               currentAnswerTim1 = ""
                                               currentAnswerTim2 = ""
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                                currentAnswerTim1 = "Our latest product is the Iphone 16e."
                                                currentAnswerTim2 = "I can't say much, but I've heard it's not like any other phone."
                                            }
                                        })
                                        {
                                       
                                                ZStack{
                                                    Rectangle().foregroundStyle(Color("PurpleColor"))
                                                        .frame(width:300,height: 50)
                                                        .cornerRadius(15)
                                                    
                                                    Text("What’s Apple latest product ?") .font(.system(size: 20, weight: .bold, design: .rounded))
                                                        .foregroundColor(Color("FontColor"))
                                                }
                                                
                                            
                                       
                                        }
                                        
                                        Spacer()
                                    }
                                    Spacer()
                                }
                               
                            
                        }
                }
                Spacer()
                if !currentAnswerTim1.isEmpty || !currentAnswerTim2.isEmpty {
                    ZStack {
                        Spacer()
                    Spacer()
                        HStack(spacing: -10) {
                            Spacer()
                            HStack {
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                VStack {
                                    Text("Tim Cook 1")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("FontColor"))
                                        .padding(.trailing, 160)
                                    ZStack(alignment: .leading) {
                                        Text(currentAnswerTim1)
                                            .opacity(0) // Reserve space
                                        TypeWriterEffect(text: currentAnswerTim1)
                                    }
                                }
                                .padding()
                                .frame(width: 300, height: 100)
                                .background(Color("DarkGrayColor"))
                                .cornerRadius(15)
                                .overlay(alignment: .bottomLeading) {
                                    Image(systemName:"arrowtriangle.down.fill")
                                        .font(.title)
                                        .rotationEffect(.degrees(360))
                                        .offset(x: 270, y: 17)
                                        .foregroundStyle(Color("DarkGrayColor"))
                                }
                                .padding(.bottom,400)
                            }
                            HStack {
                                VStack {
                                    Text("Tim Cook 2")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("FontColor"))
                                        .padding(.trailing, 160)
                                    ZStack(alignment: .leading) {
                                        Text(currentAnswerTim2)
                                            .opacity(0)
                                        TypeWriterEffect(text: currentAnswerTim2)
                                    }
                                }
                                .padding()
                                .frame(width: 300, height: 100)
                                .background(Color("DarkGrayColor"))
                                .cornerRadius(15)
                                .overlay(alignment: .bottomLeading) {
                                    Image(systemName:"arrowtriangle.down.fill")
                                        .font(.title)
                                        .rotationEffect(.degrees(360))
                                        .offset(x: 10, y: 17)
                                        .foregroundStyle(Color("DarkGrayColor"))
                                }
                                .padding(.bottom,400)
                                .padding(.leading,50)
                            }
                            .padding(.trailing,90)
                            Spacer()
                        }
                    }
                }

                Spacer()
            }
        }.navigationBarHidden(true)
            .background( Image("StageAllCharacters")
                .resizable()
                .frame(width: getScreenBounds().width, height: getScreenBounds().height).ignoresSafeArea())
            .padding(.top,10)
    }
}
struct StageView_previews: PreviewProvider {
    static var previews: some View {
        StageView()    }
}
