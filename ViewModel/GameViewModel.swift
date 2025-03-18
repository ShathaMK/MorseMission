//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 24/08/1446 AH.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var currentSceneIndex = 0
    @Published var currentDialogueIndex = 0
  //  @Published var quizSolved = false // Track quiz state
    @Published var isDialogueVisible = true // Track if dialogue is visible


    let scenes: [Scenes] = [
        Scenes(
            backgroundImage: "Office With Characters",

            dialogues: [
                Dialogues(speakerPfp: "SparkProfile",speaker: "Detective Spark", text: "Something’s off. We just got a call—Tim Cook might not be who he says he is.", bubbleColor: Color("PurpleColor"),isRight: false),
                Dialogues(speakerPfp: "FlashProfile" ,speaker: "Detective Flash", text: "What? From who?", bubbleColor: Color("DarkGrayColor"),isRight: true),
                Dialogues(speakerPfp: "SparkProfile",speaker: "Detective Spark", text: "Anonymous tip. They said Tim’s acting… different. Forgetting things he should know, avoiding questions, even slipping up on Apple history", bubbleColor: Color("PurpleColor"),isRight: false),
                Dialogues(speakerPfp: "FlashProfile" ,speaker: "Detective Flash", text: "That’s suspicious, but not enough to call him an impostor. Maybe he’s just tired?", bubbleColor: Color("DarkGrayColor"),isRight: true),
                Dialogues(speakerPfp: "SparkProfile",speaker: "Detective Spark", text: "Maybe. But then why did the tip say, 'He is NOT real'?", bubbleColor: Color("PurpleColor"),isRight: false),
                Dialogues(speakerPfp: "FlashProfile" ,speaker: "Detective Flash", text: "Alright… Let’s start digging", bubbleColor: Color("DarkGrayColor"),isRight: true)
            ]
        ),
        Scenes(
            backgroundImage:"Lounge With Characters",
            dialogues: [
                    Dialogues(speakerPfp: "FStaffProfile",speaker: "Staff 1", text: "Tim dodged my question about the new iPhone. That’s not like him.", bubbleColor: Color("LightBrownColor"),isRight: false),
                    Dialogues(speakerPfp: "MStaffProfile" ,speaker: "Staff 2", text: "He even forgot Apple’s mission statement. Something’s off.", bubbleColor: Color("BabyBlueColor"),isRight: true),
               
                ]//
        ),
        Scenes(
            backgroundImage:"Lounge With Characters 2",
            dialogues: [
                Dialogues(speakerPfp: "SparkProfile",speaker: "Detective Spark", text: "What do you mean, forgot?", bubbleColor: Color("PurpleColor"),isRight: false),
                    Dialogues(speakerPfp: "MStaffProfile" ,speaker: "Staff 2", text: "Someone asked, and he just mumbled nonsense. Like he was making it up on the spot.", bubbleColor: Color("BabyBlueColor"),isRight: true),
                Dialogues(speakerPfp: "FlashPfpRight" ,speaker: "Detective Flash", text: "Did he seem nervous?", bubbleColor: Color("DarkGrayColor"),isRight: false),
                    Dialogues(speakerPfp: "FStaffPfpRight",speaker: "Staff 1", text: "Now that you mention it… yeah. Almost like he was faking it. ", bubbleColor: Color("LightBrownColor"),isRight: true)
                  
                ]
        )
    ]
    


    func hideDialogues() {
        // Hide dialogues once user presses 'Next'
        isDialogueVisible = false
    }
    func moveToScene(index: Int) {
        guard index < scenes.count else { return }
        currentSceneIndex = index
        currentDialogueIndex = 0
        isDialogueVisible = true
    }

    func nextDialogue() {
          if currentDialogueIndex < scenes[currentSceneIndex].dialogues.count - 1 {
              // Show next dialogue in the current scene
              currentDialogueIndex += 1
          } else if currentSceneIndex < scenes.count - 1 {
              // Move to the next scene
              currentSceneIndex += 1
              currentDialogueIndex = 0
              isDialogueVisible = true // Make dialogues visible again for the next scene
          } else {
           
              print("Game Ended")
          }
      }
}


