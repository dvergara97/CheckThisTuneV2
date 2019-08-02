//
//  TunerViewController.swift
//  CheckThisTuneV2
//
//  Created by Daniel Vergara on 8/1/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import UIKit

class TunerViewController: UIViewController, ObserverProtocol {

    var id: String = "TunerViewController";
    var tunerModel: Observable<TunerModel>?;
    
    func onChanged(value: Any?) {
        // Update View
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tunerModel = Observable(observableValue: TunerModel());
        tunerModel?.addObserver(observer: self);
        // Do any additional setup after loading the view.
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
