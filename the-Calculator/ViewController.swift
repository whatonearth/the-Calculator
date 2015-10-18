//
//  ViewController.swift
//  HP Calculator
//
//  Created by LarryNguyen Macbook Pro on 10/17/15.
//  Copyright © 2015 LarryNguyen Macbook Pro. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation : String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound : AVAudioPlayer!
    var leftStr = ""
    var rightStr = ""
    var runningNumber = ""
    var result = ""
    var currentOperation : Operation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL =  NSURL(fileURLWithPath:path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
            
        }catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        
    }
    @IBAction func onNumberPressed (btn : UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text =  runningNumber
        
        
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation (op : Operation){
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Divide {
                    result =  "\(Double(leftStr)! / Double (rightStr)!)"
                }else if currentOperation ==  Operation.Multiply {
                    result = "\(Double(leftStr)! * Double (rightStr)!)"
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftStr)! + Double (rightStr)!)"
                }else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftStr)! - Double (rightStr)!)"
                }
                
                
                leftStr = result
                outputLbl.text = result
                
            }
            
            currentOperation = op
            
        }else  {
            leftStr = runningNumber
            outputLbl.text = runningNumber
            currentOperation = op
            
            
        }
        
        
        
    }
    
    func playSound(){
        
        if btnSound.playing{
            
            btnSound.stop()
        }
        
        btnSound.play()
        
        
    }
    
    
    
}

