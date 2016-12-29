//
//  ViewController.swift
//  simpleCalculator
//
//  Created by minh duong on 12/28/16.
//  Copyright © 2016 minh duong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var btn_seven: UIButton!
    @IBOutlet weak var btn_eight: UIButton!
    @IBOutlet weak var btn_nine: UIButton!
    @IBOutlet weak var btn_four: UIButton!
    @IBOutlet weak var btn_five: UIButton!
    @IBOutlet weak var btn_six: UIButton!
    @IBOutlet weak var btn_one: UIButton!
    @IBOutlet weak var btn_two: UIButton!
    @IBOutlet weak var btn_three: UIButton!
    @IBOutlet weak var btn_zero: UIButton!
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var substract: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var equal: UIButton!
    
    var currentNumber = ""
    var leftNumber = ""
    var rightNumber = ""
    var result = ""
    
    enum Operation: String {
        case Add = "+"
        case Divide = "/"
        case Substract = "-"
        case Multiple = "*"
        case Empty = "Empty"
    }
    var currentOperator = Operation.Empty
    override func viewDidLoad() {
        super.viewDidLoad()
        output.text = "0"
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(sender: UIButton)
    {
        playSound()
        currentNumber += "\(sender.tag)"
        output.text = currentNumber
    }
    
    @IBAction func onDIvided(_ sender: Any) {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiply(_ sender: Any) {
        processOperation(operation: Operation.Multiple)
        
    }
    
    @IBAction func onSubstract(_ sender: Any) {
        processOperation(operation: Operation.Substract)
    }
    @IBAction func onAdd(_ sender: Any) {
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onEqual(_ sender: Any) {
        processOperation(operation: currentOperator)
    }
    
    
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation)
    {
        playSound()
        if currentOperator != Operation.Empty
        {
            if currentNumber != ""
            {
                rightNumber = currentNumber
                currentNumber = ""
                if currentOperator == Operation.Add
                {
                    result = "\(Double(leftNumber)! + Double(rightNumber)!)"
                }
                else if  currentOperator == Operation.Substract
                {
                    result = "\(Double(leftNumber)! - Double(rightNumber)!)"
                }
                else if  currentOperator == Operation.Divide
                {
                    result = "\(Double(leftNumber)! / Double(rightNumber)!)"
                }
                else if  currentOperator == Operation.Multiple
                {
                    result = "\(Double(leftNumber)! * Double(rightNumber)!)"
                }
                leftNumber = result
                output.text = result
            }
            currentOperator = operation
        }
        else
        {
            //first time press operator
            currentOperator = operation
            leftNumber = currentNumber
            currentNumber = ""
            
        }
    }
    


}

