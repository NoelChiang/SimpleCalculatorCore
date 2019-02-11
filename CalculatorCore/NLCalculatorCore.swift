//
//  NLCalculatorCore.swift
//  CalculatorCore
//
//  Created by Noel on 2019/2/11.
//  Copyright © 2019 Noel. All rights reserved.
//

import UIKit

enum NLCalculatorOperator: Int {
    case plus;
    case minus;
    case multiply;
    case divide
}

protocol NLCalculatorCoreDelegate {
    func CalculatorDidUpdateDisplayNumber(displayNumber: String)
}

class NLCalculatorCore: NSObject {
    public var delegate: NLCalculatorCoreDelegate?
    private var presentedNumber: String? {
        didSet {
            if let present = presentedNumber {
                self.delegate?.CalculatorDidUpdateDisplayNumber(displayNumber: present)
            }
        }
    }
    private var firstNumber:CGFloat = 0 {
        didSet {
            if firstNumber == floor(CGFloat(firstNumber)) {
                presentedNumber = "\(Int(firstNumber))"
            } else {
                presentedNumber = "\(firstNumber)"
            }
        }
    }
    private var secondNumber:CGFloat? {
        didSet {
            if let secondNum = secondNumber {
                if secondNum == floor(CGFloat(secondNum)) {
                    presentedNumber = "\(Int(secondNum))"
                } else {
                    presentedNumber = "\(secondNum)"
                }
            }
        }
    }
    private var integerPart:Int = 0
    private var decimalPart:Int = 1
    private var calculateOperator:String?
    private var decimalPoint:Bool = false
    
    public func numberInput(number: Int) {
        if decimalPoint {
            decimalPart = decimalPart * 10 + number
        } else {
            integerPart = integerPart * 10 + number
        }
        if calculateOperator == nil {
            firstNumber = self.combinedIntegerAndDecimal()
        } else {
            secondNumber = self.combinedIntegerAndDecimal()
        }
    }
    public func decimalPointInput() {
        decimalPoint = true
    }
    public func operatorInput(op: NLCalculatorOperator) {
        if let _ = calculateOperator {
            self.makeCalculation()
        }
        integerPart = 0
        decimalPart = 1
        decimalPoint = false
        switch op {
        case .plus:
            calculateOperator = "+"
        case .minus:
            calculateOperator = "-"
        case .multiply:
            calculateOperator = "*"
        case .divide:
            calculateOperator = "/"
        }
    }
    public func backOperation() {
        if (calculateOperator == nil && integerPart == 0) || (calculateOperator != nil && integerPart == 1) {
            return
        }
        if decimalPoint && decimalPart > 1 {
            decimalPart = Int(floor(Double(decimalPart) / 10.0))
        } else {
            decimalPoint = false
            integerPart = Int(floor(Double(integerPart) / 10.0))
        }
        if calculateOperator == nil {
            firstNumber = self.combinedIntegerAndDecimal()
        } else {
            secondNumber = self.combinedIntegerAndDecimal()
        }
    }
    public func makeCalculation() {
        guard let secondNum = secondNumber, let calculateOp = calculateOperator else { return }
        switch calculateOp  {
        case "+":
            firstNumber += secondNum
        case "-":
            firstNumber -= secondNum
        case "*":
            firstNumber *= secondNum
        case "/":
            firstNumber /= secondNum
        default:
            break
        }
        calculateOperator = nil
        secondNumber = nil
        decimalPoint = false
        integerPart = 0
        decimalPart = 1
    }
    public func clearAll() {
        firstNumber = 0
        secondNumber = nil
        calculateOperator = nil
        integerPart = 0
        decimalPart = 1
        decimalPoint = false
    }
    
    
    private func combinedIntegerAndDecimal() -> CGFloat{
        var number = CGFloat(integerPart)
        if decimalPart != 0 {
            var decimalValue:CGFloat = CGFloat(decimalPart)
            while decimalValue > 10 {
                decimalValue /= 10.0
            }
            number = number + decimalValue - 1
        }
        return number
    }
}
