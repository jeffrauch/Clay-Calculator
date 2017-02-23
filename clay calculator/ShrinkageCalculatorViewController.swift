//
//  ShrinkageCalculatorViewController.swift
//  clay calculator
//
//  Created by Jeff Rauch on 12/30/16.
//  Copyright © 2016 Jeff Rauch. All rights reserved.
//

import UIKit

class ShrinkageCalculatorViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {
    
    // outlets
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var heightOutput: UILabel!
    @IBOutlet weak var widthInput: UITextField!
    @IBOutlet weak var widthOutput: UILabel!
    @IBOutlet weak var sliderValue: UISlider!
    @IBOutlet weak var sliderPercentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightInput.delegate = self
        
        // select first input
        heightInput.becomeFirstResponder()
        
        // custom keyboard
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

    
    // IBActions
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        doCalculation()
    }
    
    @IBAction func heightValueChanged(_ sender: Any) {
        doCalculation()
    }
    
    @IBAction func widthValueChanged(_ sender: Any) {
        doCalculation()
    }
    

    func doCalculation() {
        
        // variables
        var heightAmount = Double()
        var widthAmount = Double()
        var sliderAmount = Int()
        
        // Slider
        sliderAmount = Int(sliderValue.value)
        sliderPercentageLabel.text = String(sliderAmount) + " %"
        
        
        
        // Height Calculation
        let heightArray = heightInput.text?.components(separatedBy: ".")
        
        if (heightArray?.count)! <= 2 {
            
            if heightInput.text != ""  {
                heightAmount = Double(heightInput.text!) ?? 0
                heightOutput.text = String(format: "%.2f", heightAmount / ( 1 - ( Double(sliderAmount) / 100 ) ) )
            } else {
                heightOutput.text = String("0")
            }
            
        } else {
            
            heightInput.deleteBackward()
            jiggleTextField(view: self.heightInput, amount: 5.0)
            
        }
        
        // Width Calculation
        let widthArray = widthInput.text?.components(separatedBy: ".")
        
        if (widthArray?.count)! <= 2 {
            
            // Width Calculation
            if widthInput.text != ""  {
                widthAmount = Double(widthInput.text!) ?? 0
                widthOutput.text = String(format: "%.2f", widthAmount / ( 1 - ( Double(sliderAmount) / 100 ) ) )
                // widthOutput.minimumScaleFactor: 10
                // widthOutput.adjustsFontSizeToFitWidth: true
            } else {
                widthOutput.text = String("0")
            }
            
        } else {
            
            widthInput.deleteBackward()
            jiggleTextField(view: self.widthInput, amount: 5.0)
            
        }
        

    }
    
    //Stolen from Alex
    
    func jiggleTextField(view: UIView, amount: CGFloat) {
        UIView.animate(withDuration: 0.02, delay: 0, options: [.curveEaseInOut], animations: {
            view.center.x -= amount
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.04, delay: 0, options: [], animations: {
                view.center.x += amount * 2
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.02, delay: 0, options: [.curveEaseInOut], animations: {
                    view.center.x -= amount
                }, completion: { (finished: Bool) in
                    
                })
            })
        })
    }
    
    
}
