//
//  ViewController.swift
//  Calculator
//
//  Created by John Lee on 4/30/16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var userIsInTheMiddleOfTyping = false
    fileprivate var displayValue:Double {
        get{
            return Double(display.text!)!
        }
        
        set{
            display.text = String(newValue)
        }
    }
    
    fileprivate var brain = CalculatorBrain()
    
    @IBOutlet fileprivate weak var display: UILabel!
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDeslpay = display.text!
            display.text = textCurrentlyInDeslpay + digit
        }else{
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
        }
        
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.reslut
        
    }
}

