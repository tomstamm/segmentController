//
//  SecondViewController.swift
//  segmentController2
//
//  Created by Tom Stamm on 12/23/19.
//  Copyright © 2019 Tom Stamm. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let titles = ["One","Two","Three"]

    @IBOutlet var segControl: UBSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        segControl.setButtonTitles( buttonTitles:titles )
        
        segControl.backgroundColor = .clear
    }


    @IBAction func segmentAction(_ sender: UBSegmentedControl) {
        print( "segmentAction: \(sender.titleForSegment(at:sender.selectedSegmentIndex))" )
    }
}

