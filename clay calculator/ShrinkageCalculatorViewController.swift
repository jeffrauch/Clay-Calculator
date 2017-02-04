//
//  ShrinkageCalculatorViewController.swift
//  clay calculator
//
//  Created by Jeff Rauch on 12/30/16.
//  Copyright © 2016 Jeff Rauch. All rights reserved.
//

import UIKit

class ShrinkageCalculatorViewController: UIViewController, KeyboardDelegate, UITextFieldDelegate {
    
    // outlets
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var heightOutput: UILabel!
    @IBOutlet weak var widthInput: UITextField!
    @IBOutlet weak var widthOutput: UILabel!
    @IBOutlet weak var sliderValue: UISlider!
    @IBOutlet weak var sliderPercentageLabel: UILabel!
    
    // variables
    var heightAmount = Double()
    var widthAmount = Double()
    var sliderAmount = Int()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightInput.delegate = self
        self.widthInput.delegate = self
        
        
        heightInput.becomeFirstResponder()
        
        // initialize custom keyboard
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 280))
        keyboardView.delegate = self

        heightInput.inputView = keyboardView
        widthInput.inputView = keyboardView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    
    
    // required method for keyboard delegate protocol
    func keyWasTapped(character: String) {
        heightInput.insertText(character)
        widthInput.insertText(character)

    }
    
    func backspace() {
        heightInput.deleteBackward()
        widthInput.deleteBackward()
    }

    
    @IBAction func sliderValueChanged(_ sender: Any) {
        doCalculation()
    }
    
    @IBAction func heightValueChanged(_ sender: Any) {
        doCalculation()
    }
    
    @IBAction func widthValueChanged(_ sender: Any) {
        doCalculation()
    }
    
   
    //Textfield delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // return false to not change text
        // max 2 fractional digits allowed
        let newText = (heightInput.text! as NSString).replacingCharacters(in: range, with: string)
        let regex = try! NSRegularExpression(pattern: "\\..{3,}", options: [])
        let matches = regex.matches(in: newText, options:[], range:NSMakeRange(0, newText.characters.count))
        guard matches.count == 0 else { return false }
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            return true
        case ".":
            let array = heightInput.text?.characters.map { String($0) }
            var decimalCount = 0
            for character in array! {
                if character == "." {
                    decimalCount += 1
                }
            }
            if decimalCount == 1 {
                return false
            } else {
                return true
            }
        default:
            let array = string.characters.map { String($0) }
            if array.count == 0 {
                return true
            }
            return false
        }
    }
    

    
    func doCalculation() {
        

        // Slider
        sliderAmount = Int(sliderValue.value)
        sliderPercentageLabel.text = String(sliderAmount) + " %"
        
        
        // Height Calculation
        if heightInput.text != "" {
            heightAmount = Double(heightInput.text!)!
            heightOutput.text = String(format: "%.2f", heightAmount / ( 1 - ( Double(sliderAmount) / 100 ) ) )
        } else {
            heightOutput.text = String("0")
        }
        
        // Width Calculation
        if widthInput.text != ""  {
            widthAmount = Double(widthInput.text!)!
            widthOutput.text = String(format: "%.2f", widthAmount / ( 1 - ( Double(sliderAmount) / 100 ) ) )
            // widthOutput.minimumScaleFactor: 10
            // widthOutput.adjustsFontSizeToFitWidth: true
        } else {
            widthOutput.text = String("0")
        }
        
        sliderPercentageLabel.text = String(Int(sliderValue.value) ) + " %"
    }
    
    
}
