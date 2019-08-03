//
//  ObservableProtocol.swift
//  CheckThisTuneV2
//
//  Created by Daniel Vergara on 8/1/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import Foundation

protocol ObservableProtocol {
    
    // var observers : [ObserverProtocol] {get set}
    
    func addObserver(observer : ObserverProtocol);
    func removeObserver(observer : ObserverProtocol);
    func notifyObservers(value : Any?);
    
}
