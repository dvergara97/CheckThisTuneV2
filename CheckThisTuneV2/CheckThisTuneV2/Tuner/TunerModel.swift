//
//  TunerModel.swift
//  CheckThisTuneV2
//
//  Created by Daniel Vergara on 8/1/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import Foundation

class TunerModel : Observable {

    private var noteFrequencies: [Double];
    private var noteNames: [String];
    private var previousFrequency : Double;
    private var currentFrequency : Double;
    
    override init() {
        self.noteFrequencies = [220.0, 233.08, 246.94, 261.63, 277.18, 293.66, 311.13,
                           329.63, 349.23, 369.99, 392.00, 415.30, 440.0];
        self.noteNames = ["A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A"];
        self.previousFrequency = 440.0;
        self.currentFrequency = 440.0;
        //super.init();
    }
    
    func setNote(newFrequency: Double) {
        self.previousFrequency = self.currentFrequency;
        self.currentFrequency = self.putFrequencyInRange(frequency: newFrequency);

        let closestCurrent = getIndexClosest(noteFrequency: self.currentFrequency);
        let closestPrevious = getIndexClosest(noteFrequency: self.previousFrequency);
        
        let currentPercentageAway = getPercentageAway(frequency: self.currentFrequency,
            indexClosestTo: closestCurrent);
        let previousPercentageAway = getPercentageAway(frequency: self.currentFrequency,
            indexClosestTo: closestPrevious);
        
        print(closestCurrent);
        notifyObservers(
            value: TunerMessage(currentFrequencyNote: self.noteNames[closestCurrent],
                                         previousFrequencyNote: self.noteNames[closestPrevious],
                                         currentFrequencyPercentage: currentPercentageAway,
                                         previousFrequencyPercentage: previousPercentageAway)
                                );
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
    
    private func getIndexClosest(noteFrequency : Double) -> Int   {
        for i in 0..<noteFrequencies.count {
            
            if (isDoubleEqual(double1: noteFrequency, double2: noteFrequencies[i])) {
                return i;
            }
            if (noteFrequency < noteFrequencies[i]) {
                
                let previousDist = noteFrequency - noteFrequencies[i - 1];
                let nextDist = noteFrequencies[i] - noteFrequency;
                if (nextDist < previousDist) {
                    return i
                }
                else {
                    return i - 1;
                }
                
            }
            
        }
        return -1;
    }
    
    private func getPercentageAway(frequency : Double, indexClosestTo : Int) -> Double {
        let closest = noteFrequencies[indexClosestTo];
        
        if (isDoubleEqual(double1: closest, double2: frequency)) {
            return 0.0;
        }
        
        var other = 0.0;
        
        if (closest < frequency) {
            other = noteFrequencies[indexClosestTo + 1];
            
            let totalDistance = (other - closest) / 2;
            let distance = frequency - closest;
            return (distance / totalDistance)
        }
        else {
            other = noteFrequencies[indexClosestTo - 1];
            
            let totalDistance = (closest - other) / 2;
            let distance = closest - frequency;
            return -(distance / totalDistance);
        }
    }
    
}

class TunerMessage {
    
    private var currentFrequencyNote : String;
    private var previousFrequencyNote : String;
    private var currentFrequencyPercentage : Double;
    private var previousFrequencyPercentage : Double;
    
    init(currentFrequencyNote : String, previousFrequencyNote : String,
         currentFrequencyPercentage : Double, previousFrequencyPercentage : Double) {
        self.currentFrequencyNote = currentFrequencyNote;
        self.previousFrequencyNote = previousFrequencyNote;
        self.currentFrequencyPercentage = currentFrequencyPercentage;
        self.previousFrequencyPercentage = previousFrequencyPercentage;
    }
    
    func getCurrentFrequencyNote() -> String {
        return self.currentFrequencyNote;
    }
    
    func getPreviousFrequencyNote() -> String {
        return self.previousFrequencyNote;
    }
    
    func getCurrentFrequencyPercentage() -> Double {
        return self.currentFrequencyPercentage;
    }

    func getPreviousFrequencyPercentage() -> Double {
        return self.previousFrequencyPercentage;
    }
    
}
