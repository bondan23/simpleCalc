//
//  ViewController.swift
//  simpleCalc
//
//  Created by Bondan Eko Prasetyo on 3/11/17.
//  Copyright © 2017 B-Soft. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound:AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Substract = "-"
        case Empty = "Empty"
    }
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    @IBOutlet weak var outputLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        print(currentOperation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK : Action
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onPressedAdd(sender: AnyObject)
    {
        processOperation(operation: .Add)
    }
    
    @IBAction func onPressedSubstract(sender: AnyObject)
    {
        processOperation(operation: .Substract)
    }
    
    @IBAction func onPressedMultiply(sender: AnyObject)
    {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onPressedDivided(sender: AnyObject)
    {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onPressedEqual(sender: AnyObject)
    {
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation : Operation){
        print(currentOperation)
        //user already press operator
        if currentOperation != Operation.Empty {
            print("State ke 2")
            print("Operation yg di pilih adalah \(operation)")
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        }else{
            print("State ke 1")
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }


}

