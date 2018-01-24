//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ben Juhn on 8/18/17.
//  Copyright © 2017 Ben Juhn. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    var recordButton = UIButton()
    var recordingLabel = UILabel()
    var stopRecordingButton = UIButton()
    
    let bigButtonConstant: CGFloat = 155
    let smallButtonConstant: CGFloat = 64
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func recordAudio(_ sender: UIButton) {
        toggleUI(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopRecording(_ sender: UIButton) {
        toggleUI(false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func toggleUI(_ toggle: Bool) {
        if toggle == true {
            recordButton.isEnabled = false
            stopRecordingButton.isEnabled = true
            recordingLabel.text = "Recording in Progress"
        } else {
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Tap to Record"
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let playSoundsVC = PlaySoundsViewController()
            playSoundsVC.recordedAudioURL = audioRecorder.url
            navigationController?.pushViewController(playSoundsVC, animated: true)
        } else {
            print("recording failed")
        }
    }
    
    func configureUI() {
        title = "Record"
        
        recordButton.setImage(#imageLiteral(resourceName: "Record"), for: .normal)
        recordButton.addTarget(self, action: #selector(recordAudio), for: .touchUpInside)
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordButton)
        makeConstraint(recordButton, view, .centerX, 0)
        makeConstraint(recordButton, view, .centerY, 0)
        makeSizeConstraint(recordButton, .width, bigButtonConstant)
        makeSizeConstraint(recordButton, .height, bigButtonConstant)
        
        recordingLabel.text = "Tap to Record"
        recordingLabel.textAlignment = .center
        recordingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordingLabel)
        makeConstraint(recordingLabel, view, .centerX, 0)
        let recLabelTop = NSLayoutConstraint(item: recordingLabel, attribute: .top, relatedBy: .equal, toItem: recordButton, attribute: .bottom, multiplier: 1, constant: smallButtonConstant / 8)
        view.addConstraint(recLabelTop)
        makeSizeConstraint(recordingLabel, .width, bigButtonConstant * 2)
        makeSizeConstraint(recordingLabel, .height, smallButtonConstant / 2)
        
        stopRecordingButton.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
        stopRecordingButton.addTarget(self, action: #selector(stopRecording), for: .touchUpInside)
        stopRecordingButton.isEnabled = false
        stopRecordingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stopRecordingButton)
        makeConstraint(stopRecordingButton, view, .centerX, 0)
        let stopRecButtonTop = NSLayoutConstraint(item: stopRecordingButton, attribute: .top, relatedBy: .equal, toItem: recordingLabel, attribute: .bottom, multiplier: 1, constant: smallButtonConstant / 8)
        view.addConstraint(stopRecButtonTop)
        makeSizeConstraint(stopRecordingButton, .width, smallButtonConstant)
        makeSizeConstraint(stopRecordingButton, .height, smallButtonConstant)
    }
    
    func makeConstraint(_ subview: UIView, _ superview: UIView, _ attribute: NSLayoutAttribute, _ inset: CGFloat) {
        var constant = inset
        if attribute == .trailing || attribute == .bottom {
            constant *= -1
        }
        let constraint = NSLayoutConstraint(item: subview, attribute: attribute, relatedBy: .equal, toItem: superview, attribute: attribute, multiplier: 1, constant: constant)
        superview.addConstraint(constraint)
    }
    
    func makeSizeConstraint(_ subview: UIView, _ attribute: NSLayoutAttribute, _ size: CGFloat) {
        let constraint = NSLayoutConstraint(item: subview, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size)
        view.addConstraint(constraint)
    }
    
}
