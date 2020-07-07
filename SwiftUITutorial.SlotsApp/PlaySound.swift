//
//  PlaySound.swift
//  SwiftUITutorial.SlotsApp
//
//  Created by Andrew Krechmer on 2020-04-15.
//  Copyright © 2020 Andrew Krechmer. All rights reserved.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    
    print("Attempting to play sound effect")
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file")
        }
    }
}
