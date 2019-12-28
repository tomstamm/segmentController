//
//  FirstViewController.swift
//  segmentController2
//
//  Created by Tom Stamm on 12/23/19.
//  Copyright © 2019 Tom Stamm. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var segmentStack: UIStackView!
    @IBOutlet var oneBtn: UIButton!
    @IBOutlet var twoBtn: UIButton!
    @IBOutlet var threeBtn: UIButton!

    let buttonBar = UIView()
    var barHeight:CGFloat = 4
    var bottomBorder = UIView()

    var segmentCount = 3
    var numberOfSegments = 3
    var selectedSegment = -1
    var selectedSegmentIndex = -1 {
        didSet {
            segmentedControlValueChanged( self )
        }
    }
    var segments:[UIButton] = []
    

    let selectedColor = UIColor.blue
    let unselectColor = UIColor.gray

    override func viewDidLoad() {
        super.viewDidLoad()

        segments = [ oneBtn, twoBtn, threeBtn ]
        
        for i in 0..<segments.count {
            let button = segments[i]
            button.tag = i
            button.setTitleColor( selectedColor, for:.selected )
            button.setTitleColor( unselectColor, for:.normal )
            button.backgroundColor = UIColor.clear
            button.addTarget( self, action:#selector(segmentPressed), for:.touchUpInside )
        }
        
        
        // Use auto layout, make this false
        self.segmentStack.translatesAutoresizingMaskIntoConstraints = true
        
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = selectedColor
        
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = unselectColor

        // add buttonBar & bottomBorder subview
        self.segmentStack.addSubview( buttonBar )
        self.segmentStack.addSubview( bottomBorder )
        
        // add buttonBar Constraints
        buttonBar.topAnchor.constraint( equalTo:segmentStack.bottomAnchor ).isActive = true
        buttonBar.heightAnchor.constraint( equalToConstant:barHeight ).isActive = true
        buttonBar.leftAnchor.constraint( equalTo:segmentStack.leftAnchor ).isActive = true
        buttonBar.widthAnchor.constraint( equalTo:segmentStack.widthAnchor,
                                          multiplier:1/CGFloat(numberOfSegments)).isActive = true
                                          
        // add buttbottomBorderonBar Constraints
        bottomBorder.topAnchor.constraint( equalTo:buttonBar.bottomAnchor ).isActive = true
        bottomBorder.heightAnchor.constraint( equalToConstant:1 ).isActive = true
        bottomBorder.leftAnchor.constraint( equalTo:segmentStack.leftAnchor ).isActive = true
        bottomBorder.widthAnchor.constraint( equalTo:segmentStack.widthAnchor,
                                                                            multiplier:1).isActive = true
    }

    @objc func segmentPressed( sender:UIButton ) {
        selectedSegment = sender.tag
        selectedSegmentIndex = sender.tag
        
        for button in segments {
            if button.tag == selectedSegment {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
    
    
    func segmentedControlValueChanged(_ sender:Any?) {
        UIView.animate( withDuration:0.3 ) {
            self.buttonBar.frame.origin.x = ( self.segmentStack.frame.width / CGFloat( self.numberOfSegments )) * CGFloat( self.selectedSegmentIndex )
        }
    }
}

