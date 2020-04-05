//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var player : AVAudioPlayer!
    
    let eggTimes : [String: Int] = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 10,
    ]
    
    var timer = Timer()
    
    var totalTime = 0
    var currentTime = 0
    var progress : Float = 0
    
    
    @IBAction func eggButton(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        self.totalTime = eggTimes[hardness]! // in seconds
        self.currentTime = totalTime
        self.progressView.setProgress(0.0, animated: false)
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: {Timer in
                
                self.progress = Float(self.totalTime - self.currentTime) / Float(self.totalTime)
                self.progressView.setProgress(self.progress, animated: true)
                
                if (self.currentTime == 0) {
                    
                    self.titleLabel.text = "Done!"
                    Timer.invalidate()
                    self.playAlarm()
                    
                } else {
                    
                    let timeRemaining = "\(self.currentTime / 60) minutes \(self.currentTime % 60) seconds"
                    

                    print(timeRemaining)
                    self.titleLabel.text = "Boiling \(hardness) eggs."
                    self.titleLabel.text! += "\n in: \(timeRemaining)"
                    
                    self.currentTime -= 1
                    
                }
                
                                
            })
    }
    
    func playAlarm() {
        let soundUrl = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: soundUrl!)
        player.play()
    }
    

}
