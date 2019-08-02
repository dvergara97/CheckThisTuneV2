//
//  TunerModel.swift
//  CheckThisTuneV2
//
//  Created by Daniel Vergara on 8/1/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import Foundation

class TunerModel {
    
    private var noteFrequencies: [Double];
    
    private var previousFrequency : Double;
    private var currentFrequency : Double;
    
    init() {
        self.noteFrequencies = [220.0, 233.08, 246.94, 261.63, 277.18, 293.66, 311.13,
                           329.63, 349.23, 369.99, 392.00, 415.30, 440.0];
        self.previousFrequency = 0.0;
        self.currentFrequency = 0.0;
    }
    
    func setNote(newFrequency: Double) {
        self.previousFrequency = self.currentFrequency;
        self.currentFrequency = self.putFrequencyInRange(frequency: newFrequency);
    }
    
    private func putFrequencyInRange(frequency : Double) -> Double {
        var outFrequency = frequency;
        
        if  let first = self.noteFrequencies.first, let last = self.noteFrequencies.last {
            while ( !self.inRange(first: first, last: last, frequency: outFrequency) ) {
                if (outFrequency < first) {
                    outFrequency = outFrequency * 2.0;
                }
                else if (outFrequency > last) {
                    outFrequency = outFrequency / 2.0;
                }
            }
        }
        
        return outFrequency;
    }
    
    private func inRange(first : Double, last : Double, frequency : Double) -> Bool {
        return (first < frequency && last > frequency)
            || self.isDoubleEqual(double1 : first, double2 : frequency)
            || self.isDoubleEqual(double1 : last, double2 : frequency);
    }
    
    private func isDoubleEqual(double1 : Double, double2 : Double) -> Bool {
        return fabs(double1 - double2) < 0.000000001;
    }
    
    func getCurrentFrequency() -> Double {
        return self.currentFrequency;
    }
    
}           
