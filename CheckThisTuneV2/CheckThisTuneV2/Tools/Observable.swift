//
//  Observer.swift
//  CheckThisTuneV2
//
//  Created by Daniel Vergara on 8/2/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import Foundation

class Observable<T> : ObservableProtocol {
    
    private var value : T;
    var observers: [ObserverProtocol];
    
    init(observableValue : T) {
        value = observableValue;
        observers = [];
    }
    
    func addObserver(observer: ObserverProtocol) {
        var found = false;
        
        for current in observers {
            if (observer.id == current.id) {
                found = true;
            }
        }
        
        if (!found) {
            observers.append(observer);
        }
    }
    
    func removeObserver(observer: ObserverProtocol) {
        var i = 0;
        var found = false;
        while (i < observers.count && !found) {
            if (observer.id == observers[i].id) {
                found = true;
                observers.remove(at: i);
            }
            else {
                i += 1;
            }
        }
    }
    
    func notifyObservers() {
        for observer in observers {
            observer.onChanged(value: nil);
        }
    }
    
    deinit {
        observers.removeAll();
    }
    
}
