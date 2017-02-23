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
    
    // variables
    var heightAmount = Double()
    var widthAmount = Double()
    var sliderAmount = Int()

    
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
        
        let array = heightInput.text?.components(separatedBy: ".")
        
        if (array?.count)! <= 2 {
        
            // Slider
            sliderAmount = Int(sliderValue.value)
            sliderPercentageLabel.text = String(sliderAmount) + " %"
            
            // Height Calculation
            if heightInput.text != ""  {
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
            
            print("yes")
            
        } else {
            
            heightInput.deleteBackward()
            
            jiggleTextField(view: self.heightInput, amount: 5.0)
            
        }

    }
    
    
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
