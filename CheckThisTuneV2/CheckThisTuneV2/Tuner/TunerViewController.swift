//
//  TunerViewController.swift
//  CheckThisTuneV2
//
//  Created by Daniel Vergara on 8/1/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import UIKit
import AVFoundation

class TunerViewController: UIViewController, ObserverProtocol {

    var id: String = "TunerViewController";
    var tunerModel = TunerModel();
    var engine : AVAudioEngine? = nil;
    @IBOutlet weak var noteNameLabel: UILabel!
    
    
    func onChanged(value: Any?) {
        if let message = (value as? TunerMessage) {
            noteNameLabel.text = message.getCurrentFrequencyNote();
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tunerModel.addObserver(observer: self);
        noteNameLabel.text = "Hello world!";
        engine = AVAudioEngine();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        AVAudioSession.sharedInstance().requestRecordPermission { (granted : Bool) in
            if (granted) {
                do {
                    try self.setupAudio();
                }
                catch {
                    print("Didn't work :(");
                }
            }
            else {
                let alert = UIAlertController(title : "Microphone access is requirred for this application.",
                                              message: "Go to Settings and enable microphone access.",
                                              preferredStyle: .alert);
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alert, animated: true);
            }
        }

    }
    
    func setupAudio() throws {
        //TODO
        //  If the engine isnt running.  Start it up
        //  Add an onstop where we stop the engine.
        if let nonNilEngine = engine {
            if (!nonNilEngine.isRunning) {
                let audioSession = AVAudioSession.sharedInstance();
                try audioSession.setCategory(.record, mode: .measurement);
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation);
            
                let recordingFormat = nonNilEngine.inputNode.outputFormat(forBus: 0);
                nonNilEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
                    (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    
                }

                nonNilEngine.prepare();
                try nonNilEngine.start();

            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        engine?.stop();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
