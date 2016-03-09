//
//  ViewController.swift
//  retrocalc
//
//  Created by Marek Stefanowski on 08/03/2016.
//  Copyright © 2016 frequen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    @IBAction func clearButon(sender: AnyObject) {
        runningNumber = ""
        leftVar = ""
        rightVar = ""
        result = ""
        currentoperation = Operation.Empty
        calculation.text = "0"
    }
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftVar = ""
    var rightVar = ""
    var result = ""
    var currentoperation : Operation = Operation.Empty
    
    @IBOutlet weak var calculation: UILabel!

    @IBAction func ButtonPressed(sender: UIButton) {
        let button = sender.tag
        runningNumber += "\(button)"
        calculation.text = runningNumber
        playSound()
    }
    
    @IBAction func operand(sender: UIButton) {
          playSound()
        //        btn.imageView.image == UIImage(named:"BluePiece.png"
        
        if sender.currentImage == UIImage(named: "add.png")
        {
            processOperation(Operation.Add)
        }
        else if sender.currentImage == UIImage(named: "subtract.png")
        {
            processOperation(Operation.Subtract)
        }
        else if sender.currentImage == UIImage(named: "multiply.png")
        {
            processOperation(Operation.Multiply)
        }
        else if sender.currentImage == UIImage(named: "divide.png")
        {
            processOperation(Operation.Divide)
        }
        else
        {
            processOperation(Operation.Empty)
        }

    }
    
    func processOperation(op: Operation){
        print(currentoperation)
        if currentoperation != Operation.Empty
        {
            if runningNumber != ""
            {
                rightVar = runningNumber
                print("rightvar " + rightVar)
                print("leftvar " + leftVar)
                runningNumber = ""
                if leftVar == ""
                {
                    leftVar = "0"
                }
                if currentoperation == Operation.Multiply{
                    result = "\(Double(leftVar)! * Double(rightVar)!)"
                }
                else if currentoperation == Operation.Divide{
                    result = "\(Double(leftVar)! / Double(rightVar)!)"
                }
                else if currentoperation == Operation.Add{
                    result = "\(Double(leftVar)! + Double(rightVar)!)"
                }
                else if currentoperation == Operation.Subtract{
                    result = "\(Double(leftVar)! - Double(rightVar)!)"
                }
                leftVar = result
                calculation.text = result
            }
           if op != Operation.Empty
           {
            currentoperation = op
            }
        }
        else
        {
            leftVar = runningNumber
            runningNumber = ""
            print(leftVar)
                currentoperation = op
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do{
          try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
            // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound(){
        if buttonSound.playing{
            buttonSound.stop()
        }
        buttonSound.play()
    }


}

