//
//  ObserverProtocol.swift
//  CheckThisTuneV2
//
//  Created by Daniel Vergara on 8/1/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import Foundation

protocol ObserverProtocol {
    
    var id : String { get set }
    func onChanged(value : Any?);
    
}
