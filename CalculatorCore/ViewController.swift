//
//  ViewController.swift
//  CalculatorCore
//
//  Created by Noel on 2019/2/11.
//  Copyright © 2019 Noel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputTextfield: UITextField!
    @IBAction func operatorTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            calculateCore.operatorInput(op: .plus)
        case 1:
            calculateCore.operatorInput(op: .minus)
        case 2:
            calculateCore.operatorInput(op: .multiply)
        case 3:
            calculateCore.operatorInput(op: .divide)
        default:
            break
        }
    }
    @IBAction func numberTapped(_ sender: UIButton) {
        calculateCore.numberInput(number: sender.tag)
    }
    @IBAction func decimalPointTapped(_ sender: UIButton) {
        calculateCore.decimalPointInput()
    }
    @IBAction func resultTapped(_ sender: UIButton) {
        calculateCore.makeCalculation()
    }
    @IBAction func backTapped(_ sender: UIButton) {
        calculateCore.backOperation()
    }
    @IBAction func clearTapped(_ sender: UIButton) {
        calculateCore.clearAll()
    }
    var calculateCore = NLCalculatorCore()
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateCore.delegate = self
    }
}

extension ViewController: NLCalculatorCoreDelegate {
    func CalculatorDidUpdateDisplayNumber(displayNumber: String) {
        outputTextfield.text = displayNumber
    }
}
