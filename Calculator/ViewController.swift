//
//  ViewController.swift
//  Calculator
//

import UIKit

class ViewController: UIViewController {
    
    //--------------------------------//
    // Constants and Varibles
    var result: Double = 0.0
    var preResult: Double = 0.0
    var formula: String = ""
    var myCal: Calculator!
    //--------------------------------//
    // Outlets
    // A tip to check data type
    // lblResult.text = String(describing: type(of: sender.titleLabel!.text!))

    @IBOutlet weak var lblFormula: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet var formulaBtns: [UIButton]!
    
    //--------------------------------//
    // Function Button Action
    
    @IBAction func clickBtnEqual(_ sender: UIButton) {
        myCal.calculateResult()
    }
    
    @IBAction func clickBtnAllClear(_ sender: UIButton) {
        myCal.allClear()
    }
    
    @IBAction func clickBtnDeleteLast(_ sender: UIButton) {
        myCal.removeLastCharacter()
    }
    @objc func clickBtnRelatedToFormula(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            myCal.addToFormula(title)
        }
    }
    
    //--------------------------------//
    // Support Functions
    func formulaBtnsActionInit() {
        for btn in formulaBtns {
            btn.addTarget(self, action: #selector(clickBtnRelatedToFormula(_:)), for: .touchUpInside)
        }
    }
    
    //--------------------------------//
    // Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        formulaBtnsActionInit()
        myCal.allClear()
        myCal.testCase3()
    }
}

class Calculator {
    var result: Double = 0.0
    var preResult: Double = 0.0
    var formula : String
    weak var lblResult: UILabel!
    weak var lblFormula: UILabel!

    init(_ formula:String,_ lblResult : UILabel, _ lblFormula : UILabel){
        self.formula = formula
        self.lblResult = lblResult
        self.lblFormula = lblFormula
        
    }
    
    
   
    
    func addToFormula(_ str: String) {
        formula += str
        lblFormula.text = formula
    }

    func removeLastCharacter() {
        if formula == "" {
            return
        }
        formula.removeLast()
        lblFormula.text = formula
    }
    
    func evaluateFormula(_ formula: String) -> Double? {
        let expression = NSExpression(format:formula)
        let value = expression.expressionValue(with: nil, context: nil) as? Double
        return value
    }
    
    func calculateResult() {
        if let result = evaluateFormula(formula) {
            self.result = result
            lblResult.text = "= " + String(result)
            print("\(formula) = \(result)")
        }
    }
    
    func allClear() {
        result = 0.0
        preResult = 0.0
        formula = ""
        lblFormula.text = formula
        lblResult.text = String(result)
    }

    //--------------------------------//
    // Testcases
    
    func testCase1() {
        formula = "123"
        lblFormula.text = formula
        calculateResult()
    }
    
    func testCase2() {
        formula = "123*0.5"
        lblFormula.text = formula
        calculateResult()
    }
    
    func testCase3() {
        formula = "1+2*3"
        lblFormula.text = formula
        calculateResult()
    }

    
}

