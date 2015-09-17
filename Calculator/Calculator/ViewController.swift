//
//  ViewController.swift
//  Calculator
//
//  Created by 小东 on 15/9/10.
//  Copyright (c) 2015年 XD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBOutlet weak var display: UILabel!
    
    
    @IBOutlet weak var history: UILabel!
    
   
    @IBAction func pibtn() {
        let pi = M_PI
        displayValue = pi
        enter()
    }
    
    @IBAction func appendDigit(sender: UIButton){
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber
        {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let Pai = M_PI
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation{
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "+": performOperation {$0 + $1}
            case "−": performOperation {$1 - $0}
            case "√": performOperation {sqrt($0)}
            case "sin": performOperation {sin(Pai / 180 * $0)}
            case "cos": performOperation {cos(Pai / 180 * $0)}
            case "tan": performOperation {tan(Pai / 180 * $0)}
            
        default: break
        }
        
                
    }
    func performOperation(operation: (Double,Double) ->Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double->Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }

    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
 
    @IBAction func clearall(sender: UIButton) {
        let clear = sender.currentTitle!
        display.text!.removeAll(keepCapacity: true)
        operandStack.removeAll(keepCapacity: true)
        return display.text = "0"
    }
    
    
}

