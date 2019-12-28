//
//  UBSegmentedControl.swift
//  segmentController2
//
//  Created by Tom Stamm on 12/24/19.
//  Copyright © 2019 Tom Stamm. All rights reserved.
//

import UIKit

@IBDesignable
class UBSegmentedControl: UIControl {

    
    private var maxArrayLimit:Int = 0
    private var buttonTitles:[String] = ["Aye","Bee","Sea","Dee","Eee"] {
        didSet{
            maxArrayLimit = buttonTitles.count-1
        }
    }
    @IBInspectable var buttonTitlesString:String = "Aye\nBee\nSee" {
        didSet {
            buttonTitles = buttonTitlesString.components(separatedBy: "\n")
            updateView()
        }
    }
    
    private var buttons:[UIButton] = []
    private var selectorView: UIView = UIView()
    private var bottomBorderView: UIView = UIView()

    private var _selectedSegmentIndex:Int = 0
    
    @IBInspectable var selectedSegmentIndex:Int {
        get { return _selectedSegmentIndex }
        set {
            setSelectedSegmentIndex( index:newValue )
        }
    }
    
    public var numberOfSegments:Int {
        get { return buttons.count }
    }
    
    
    @IBInspectable var selectColor:UIColor = .blue
    @IBInspectable var unSelectColor:UIColor = .gray
    
    @IBInspectable var barHeight:CGFloat = 4.0 {
        didSet {
            updateView()
        }
    }
    
    var font = UIFont( name:"Helvetica Neue", size:18 )
    
    @IBInspectable var fontName:String = "Helvetica Neue" {
        didSet {
            font = UIFont( name:fontName, size:fontSize )
            updateView()
        }
    }
    
    @IBInspectable var fontSize:CGFloat = 18.0 {
        didSet {
            font = UIFont( name:fontName, size:fontSize )
            updateView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        updateView()
    }

    
    convenience init( frame:CGRect, buttonTitles:[String] ) {
        self.init( frame:frame )
        self.buttonTitles = buttonTitles
    }
    
    override func draw( _ rect:CGRect ) {
        super.draw( rect )
        updateView()
    }
    
    func setButtonTitles( buttonTitles:[String] ) {
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    private func updateView() {
        createButtons()
        configureSelectorView()
        drawBottomBorder()
        configureStackView()
    }

    private func configureStackView() {
        let stack = UIStackView( arrangedSubviews:buttons )
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        addSubview( stack )
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint( equalTo:self.topAnchor ).isActive = true
        stack.bottomAnchor.constraint( equalTo:self.bottomAnchor ).isActive = true
        stack.leftAnchor.constraint( equalTo:self.leftAnchor ).isActive = true
        stack.rightAnchor.constraint( equalTo:self.rightAnchor ).isActive = true
    }
    
    private func configureSelectorView() {
        let selectorWidth = frame.width / CGFloat( self.buttonTitles.count )
        let selectorPosition = frame.width/CGFloat( buttonTitles.count ) * CGFloat( _selectedSegmentIndex )
        
        selectorView = UIView( frame:CGRect( x:selectorPosition, y:self.frame.height, width:selectorWidth, height:barHeight ))
        
        selectorView.backgroundColor = selectColor
        addSubview( selectorView )
    }
    
    
    private func drawBottomBorder() {
        bottomBorderView = UIView( frame:CGRect( x:0, y:self.frame.height+barHeight, width:frame.width, height:1 ))
        
        bottomBorderView.backgroundColor = unSelectColor
        addSubview( bottomBorderView )
    }
    
    private func createButtons() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach( { $0.removeFromSuperview() } )
        
        for buttonTitle in buttonTitles {
            let button = UIButton( type:.system )
            button.setTitle( buttonTitle, for:.normal )
            button.addTarget( self, action:#selector(UBSegmentedControl.buttonAction(sender:)), for:.touchUpInside )
            
            button.titleLabel?.font = font
            button.setTitleColor( unSelectColor, for:.normal )
            buttons.append( button )
        }
        buttons[_selectedSegmentIndex].setTitleColor( selectColor, for:.normal )
    }
    
    @objc func buttonAction( sender:UIButton ) {
        for ( buttonIndex, button ) in buttons.enumerated() {
             if button == sender {
                if buttonIndex != _selectedSegmentIndex {
                    let selectorPosition = frame.width/CGFloat( buttonTitles.count ) * CGFloat( buttonIndex )
                    
                    UIView.animate( withDuration: 0.3 ) {
                        self.selectorView.frame.origin.x = selectorPosition
                    }
                    button.setTitleColor( selectColor, for:.normal )

                    _selectedSegmentIndex = buttonIndex
                    self.sendActions( for:.valueChanged )
                }
            } else {
                button.setTitleColor( unSelectColor, for:.normal )
            }
        }
    }
    // Getters  and Setters
    func titleForSegment(at: Int) -> String? {
        if(( at >= 0 ) && ( at < buttons.count )) {
            return buttons[at].title(for:.normal)
        }
        
        return nil
    }
    
    func setSelectedSegmentIndex( index:Int ) {
        if(( index >= 0 ) && ( index < buttons.count )) {
            buttons.forEach( {$0.setTitleColor( unSelectColor, for:.normal ) } )

            if index != _selectedSegmentIndex {
                let button = buttons[index]
                _selectedSegmentIndex = index
                self.sendActions( for:.valueChanged )
                button.setTitleColor( selectColor, for:.normal )
                let selectorPosition = frame.width/CGFloat( buttonTitles.count ) * CGFloat( index )

                UIView.animate( withDuration: 0.3 ) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
            }
        }
    }
}
