//
//  HomeViewController.swift
//  CalculatorEdax
//
//  Created by Miguel Ledezma on 01/06/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    
    //MARK: - Outlets
    
    //Result
    @IBOutlet weak var resultLabel: UILabel!
    
    //number
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    //Operatos
    
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorPlus: UIButton!
    @IBOutlet weak var operatorMinus: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    
    // MARK: - Variables
    
    private var total: Double = 0
    private var temp: Double = 0
    private var operating = false
    private var decimal = false
    private var operation: operationType = .none
    
    //MARK: . Constants
    
    
    private let kDecimalSeparator = Locale.current.decimalSeparator
    private let kMaxLength = 9
    private let kMacValue: Double = 999999999
    private let kMinValue: Double = 0.00000001
    
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private let  printCientificFormatter printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits =  8
        return formatter
    }()
    
    private enum operationType {
        case none, adiction, substraction, multiplication, division, percent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIButton
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        
        operatorAC.round()
        operatorPlusMinus.round()
        operatorPercent.round()
        
        operatorDivision.round()
        operatorMultiplication.round()
        operatorMinus.round()
        operatorPlus.round()
        operatorResult.round()
        
        numberDecimal.setTitle( kDecimalSeparator, for: .normal)
        
        result()
        
    }
    
    
    // MARK: Button Acctions
    
    @IBAction func OperatorACAction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
        temp *= (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        
        if operation != .percent {
            result()
            return
        }
        
        operating = true
        operation =  .percent
        
        result()
        sender.shine()
    }
    
    @IBAction func operatorResultAction(_ sender: UIButton) {
        
        result()
        
        sender.shine()
    }
    
    @IBAction func operatorPlusAction(_ sender: UIButton) {
        
        result()
        operating = true
        operation =  .adiction
        sender.shine()
    }
    
    @IBAction func operatorMinusAction(_ sender: UIButton) {
        result()
        operating = true
        operation =  .substraction
        sender.shine()
    }
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        result()
        operating = true
        operation =  .multiplication
        sender.shine()
    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        result()
        operating = true
        operation =  .division
        sender.shine()
    }
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        
        let currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        resultLabel.text = resultLabel.text! + kDecimalSeparator!
        
        decimal = true
        
        sender.shine()

    }
    @IBAction func numberAction(_ sender: UIButton) {
        
        operatorAC.setTitle("C", for: .normal)
        
        var currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        //Hemos seleccioinado una operacion
        if operating {
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
        //Hemos seleccionado decimales
        
        if decimal {
            currentTemp = "\(currentTemp)\(String(describing: kDecimalSeparator))"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double( currentTemp + String(number))!
        
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        print(":: ",sender.tag)
        sender.shine()
    
    }
    
    // Clean values
    private func clear(){
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        }else{
            total = 0
            result()
        }
    }
    
    private func result() {
        
        switch operation {
       
            case .none:
                //No hacemos nothing
                break
            case .adiction:
                total += temp
                break
            case .substraction:
                total -= temp
                break
            case .multiplication:
                total *= temp

                break
            case .division:
                total /= temp

                break
            case .percent:
                total = total / 100
                break
        }
        
        //Formateo en pantalla
            
        if total <= kMacValue || total >= kMinValue {
            
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        print("TOLA:: ", total)
    }
    
    
    // MARK: - initializacioin
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
}
