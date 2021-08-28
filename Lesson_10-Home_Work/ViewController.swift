//
//  ViewController.swift
//  Lesson_10-Home_Work
//
//  Created by Evgeniy Nosko on 27.08.21.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var roundButton: Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    enum Operation:String {
        case plus = "+"
        case minus = "-"
        case multiply = "*"
        case divide = "/"
        case null = "null"
    }
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "0"
    }
    
    @IBAction func numberPressed(_ sender: RoundButton) {
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.tag)"
            resultLabel.text = runningNumber
        }
    }
    
    @IBAction func allClearPressed(_ sender: RoundButton) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .null
        resultLabel.text = "0"
    }
    
    @IBAction func dotPressed(_ sender: RoundButton) {
        if runningNumber.count <= 7 {
            runningNumber += "."
            resultLabel.text = runningNumber
        }
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
        operation(operation: .plus)
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        operation(operation: .minus)
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        operation(operation: .multiply)
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        operation(operation: .divide)
    }
    
    @IBAction func minusPlus(_ sender: RoundButton) {
        runningNumber = "-" + runningNumber
        resultLabel.text = runningNumber
    }
    
    @IBAction func percent(_ sender: RoundButton) {
        var leftValue = Double(resultLabel.text!)
        leftValue = leftValue! / 100
        resultLabel.text = String(leftValue!)
    }
    
    
    func operation(operation: Operation) {
        if currentOperation != .null {
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .plus {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                } else if currentOperation == .minus {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentOperation == .multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOperation == .divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                
                leftValue = result
                if(Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                resultLabel.text = result
            }
            currentOperation = operation
            
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}

