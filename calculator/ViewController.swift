//
//  ViewController.swift
//  calculator
//
//  Created by 조승환 on 2021/11/04.
//

import UIKit

enum Operation {
  case Add
  case Subtract
  case Divide
  case Multiply
  case unknown
}

class ViewController: UIViewController {

  @IBOutlet weak var numberOutputLabel: UILabel!

    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

// 숫자 키패드
  @IBAction func tapNumberButton(_ sender: UIButton) {
    guard let numberValue = sender.title(for: .normal) else { return }
    if displayNumber.count < 11 {
      displayNumber += numberValue
      numberOutputLabel.text = displayNumber
    }
  }
// AC버튼
  @IBAction func tapClearButton(_ sender: UIButton) {
    displayNumber = ""
    firstOperand = ""
    secondOperand = ""
    result = ""
    currentOperation = .unknown
    numberOutputLabel.text = "0"
  }

// . 소숫점
  @IBAction func tapDotButton(_ sender: UIButton) {
    if displayNumber.count < 8, !displayNumber.contains(".") {
      displayNumber += displayNumber.isEmpty ? "0." : "."
      numberOutputLabel.text = displayNumber
    }
  }
// ÷ 나누기
  @IBAction func tapDivideButton(_ sender: UIButton) {
    operation(.Divide)
  }
// x 곱하기
@IBAction func tapMultiplyButton(_ sender: UIButton) {
    operation(.Multiply)
  }

// - 빼기
  @IBAction func tapSubtractButton(_ sender: UIButton) {
    operation(.Subtract)
  }
// + 더하기
  @IBAction func tapAddButton(_ sender: UIButton) {
    operation(.Add)
  }
// = 결과
  @IBAction func tapEqualButton(_ sender: UIButton) {
    operation(currentOperation)
  }
// % 백분율
    @IBAction func tapPercentButton(_ sender: UIButton) {
        if let num = numberOutputLabel.text {
            let stringifiedNum:Double = Double(num)! * 0.01
            numberOutputLabel.text = String(stringifiedNum)
        }
   
    }
// +/- 음양수
    @IBAction func taplusMinusButton(_ sender: UIButton) {
        if let num = numberOutputLabel.text {
            numberOutputLabel.text = String(Double(num)! * -1)
            
        }
    }
    
  func operation(_ operation: Operation) {
    if currentOperation != .unknown {
      if !displayNumber.isEmpty {
        secondOperand = displayNumber
        displayNumber = ""

        guard let firstOperand = Double(firstOperand) else { return }
        guard let secondOperand = Double(secondOperand) else { return }

        switch currentOperation {
        case .Add:
          result = "\(firstOperand + secondOperand)"

        case .Subtract:
          result = "\(firstOperand - secondOperand)"

        case .Divide:
          result = "\(firstOperand / secondOperand)"

        case .Multiply:
          result = "\(firstOperand * secondOperand)"

        default:
          break
        }

        if let result = Double(result), result.truncatingRemainder(dividingBy: 1) == 0 {
            self.result = "\(Int(result))"
        }

          self.firstOperand = result
        numberOutputLabel.text = result
      }

      currentOperation = operation
    } else {
      firstOperand = displayNumber
      currentOperation = operation
      displayNumber = ""
    }
  }
  
}


