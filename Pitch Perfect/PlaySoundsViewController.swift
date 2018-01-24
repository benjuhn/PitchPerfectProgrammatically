//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ben Juhn on 8/18/17.
//  Copyright © 2017 Ben Juhn. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    let smallButtonConstant: CGFloat = 64
    
    var slowButton = UIButton()
    var fastButton = UIButton()
    var highPitchButton = UIButton()
    var lowPitchButton = UIButton()
    var echoButton = UIButton()
    var reverbButton = UIButton()
    var stopButton = UIButton()
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, highPitch, lowPitch, echo, reverb
    }
    
    func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highPitch:
            playSound(pitch: 1000)
        case .lowPitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
    }
    
    func stopButtonPressed(_ sender: UIButton) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureButtons()
        configureStacks()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    func configureButtons() {
        slowButton.setImage(#imageLiteral(resourceName: "Slow"), for: .normal)
        slowButton.addTarget(self, action: #selector(playSoundForButton), for: .touchUpInside)
        slowButton.tag = 0
        
        fastButton.setImage(#imageLiteral(resourceName: "Fast"), for: .normal)
        fastButton.addTarget(self, action: #selector(playSoundForButton), for: .touchUpInside)
        fastButton.tag = 1
        
        highPitchButton.setImage(#imageLiteral(resourceName: "HighPitch"), for: .normal)
        highPitchButton.addTarget(self, action: #selector(playSoundForButton), for: .touchUpInside)
        highPitchButton.tag = 2
        
        lowPitchButton.setImage(#imageLiteral(resourceName: "LowPitch"), for: .normal)
        lowPitchButton.addTarget(self, action: #selector(playSoundForButton), for: .touchUpInside)
        lowPitchButton.tag = 3
        
        echoButton.setImage(#imageLiteral(resourceName: "Echo"), for: .normal)
        echoButton.addTarget(self, action: #selector(playSoundForButton), for: .touchUpInside)
        echoButton.tag = 4
        
        reverbButton.setImage(#imageLiteral(resourceName: "Reverb"), for: .normal)
        reverbButton.addTarget(self, action: #selector(playSoundForButton), for: .touchUpInside)
        reverbButton.tag = 5
        
        stopButton.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
    }
    
    func configureStacks() {
        let topRow = UIStackView(arrangedSubviews: [slowButton, fastButton])
        topRow.distribution = .fillEqually
        
        let middleRow = UIStackView(arrangedSubviews: [highPitchButton, lowPitchButton])
        middleRow.distribution = .fillEqually
        
        let bottomRow = UIStackView(arrangedSubviews: [echoButton, reverbButton])
        bottomRow.distribution = .fillEqually
        
        let playbackButtonsStack = UIStackView(arrangedSubviews: [topRow, middleRow, bottomRow])
        playbackButtonsStack.axis = .vertical
        playbackButtonsStack.distribution = .fillEqually
        
        let stopButtonStack = UIStackView(arrangedSubviews: [stopButton])
        stopButtonStack.axis = .vertical
        stopButtonStack.alignment = .center
        
        let outerStack = UIStackView(arrangedSubviews: [playbackButtonsStack, stopButtonStack])
        outerStack.axis = .vertical
        outerStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(outerStack)
        
        let topConstraint = NSLayoutConstraint(item: outerStack, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: outerStack, attribute: .bottom, relatedBy: .equal, toItem: bottomLayoutGuide, attribute: .top, multiplier: 1, constant: -20)
        let leadingConstraint = NSLayoutConstraint(item: outerStack, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: outerStack, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 0)
        view.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        
        let stopButtonStackHeight = NSLayoutConstraint(item: stopButtonStack, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: smallButtonConstant)
        view.addConstraint(stopButtonStackHeight)
        
        let stopButtonWidth = NSLayoutConstraint(item: stopButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: smallButtonConstant)
        view.addConstraint(stopButtonWidth)
    }
    
}
