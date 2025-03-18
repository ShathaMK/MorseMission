//
//  MainPage.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 21/08/1446 AH.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = GameViewModel()
    var body: some View {
        NavigationStack{
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                VStack {
                    HStack{
                        
                        Image("SparkProfile").resizable().frame(width: 180, height: 180)
                        Image("SparkWelcome").resizable().frame(width: 805, height: 177)
                        
                    }
                    //
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AlphabetView()){
                            Image("Level1").resizable().frame(width: 250,height: 450)
                        }
                        Spacer()
                        NavigationLink(destination: TranslatorView()){
                            Image("Level3").resizable().frame(width: 250,height: 450)
                        }
                        Spacer()
                        NavigationLink(destination: FindSpyView(viewModel:viewModel)){
                            Image("Level2").resizable().frame(width: 250,height: 450)
                        }
                        Spacer()
                        
                    }
                    Spacer()
                    
                }
                //                Image(systemName: "globe")
                //                    .imageScale(.large)
                //                    .foregroundColor(.accentColor)
                //                Text("Hello, world!")
            }//end of ZStack
        }
        .navigationBarHidden(true)        }
    }

