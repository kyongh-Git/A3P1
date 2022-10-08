//
//  ViewController.swift
//  A2_P1_Kim_YongHwan
//
//  Created by YongHwan Kim on 9/14/19.
//  Copyright © 2019 YongHwan Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // data for sub label
    var currTempStr : String = ""
    // data for main label
    var currMainStr : String = ""
    // sub string helps to calculate main label
    /*var currSubStr : String = ""*/
    var done :Bool = false
    
    // main label
    @IBOutlet weak var mainLabel: UILabel!
    // sub label collects inputs
    /*@IBOutlet weak var subLabel: UILabel!*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //button 0
    @IBAction func button0(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "0"
            mainLabel.text = currMainStr
        }
        
    }
    //button 1
    @IBAction func button1(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "1"
            mainLabel.text = currMainStr
        }
    }
    //button 2
    @IBAction func button2(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "2"
            mainLabel.text = currMainStr
        }
    }
    //button 3
    @IBAction func button3(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "3"
            mainLabel.text = currMainStr
        }
    }
    //button 4
    @IBAction func button4(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "4"
            mainLabel.text = currMainStr
        }
    }
    //button 5
    @IBAction func button5(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "5"
            mainLabel.text = currMainStr
        }
    }
    //button 6
    @IBAction func button6(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "6"
            mainLabel.text = currMainStr
        }
    }
    //button 7
    @IBAction func button7(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "7"
            mainLabel.text = currMainStr
        }
    }
    //button 8
    @IBAction func button8(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "8"
            mainLabel.text = currMainStr
        }
    }
    //button 9
    @IBAction func button9(_ sender: UIButton) {
        if !done{
            currMainStr = currMainStr + "9"
            mainLabel.text = currMainStr
        }
    }
    //button dot .
    @IBAction func buttonDot(_ sender: UIButton) {
        if !done{
            if(currMainStr.last != "+" && currMainStr.last != "-" && currMainStr.last != "*" && currMainStr.last != "/" && currMainStr.last != "."){
                currMainStr = currMainStr + "."
                mainLabel.text = currMainStr
            }
        }
        
    }
    // button equal =
    @IBAction func buttonEqual(_ sender: UIButton) {
       
        if(currMainStr.last != "+" && currMainStr.last != "-" && currMainStr.last != "*" && currMainStr.last != "/" && currMainStr.last != "."){
            var result = calString(current: currMainStr)
            if (result.last == "0" && result.contains(".0")){
                var resultInt = result
                resultInt.removeLast()
                resultInt.removeLast()
                
                print(resultInt)
                mainLabel.text = String(resultInt)
                currMainStr = String(resultInt)
            }
            else{
                mainLabel.text = result
                currMainStr = result
            }
            
            
            let resultIn = Double(result)!
            if resultIn < 0 {
                mainLabel.backgroundColor = UIColor.black
            }
            done = true
        }
    }
    //button +
    @IBAction func buttonAdd(_ sender: UIButton) {
        if(currMainStr.last != "+" && currMainStr.last != "-" && currMainStr.last != "*" && currMainStr.last != "/" && currMainStr.last != "."){
            mainLabel.backgroundColor = UIColor.darkGray
            currMainStr = currMainStr + "+"
            mainLabel.text = currMainStr
            done = false
        }
    }
    //button -
    @IBAction func buttonSub(_ sender: UIButton) {
        if(currMainStr.last != "+" && currMainStr.last != "-" && currMainStr.last != "*" && currMainStr.last != "/" && currMainStr.last != "."){
            mainLabel.backgroundColor = UIColor.darkGray
            currMainStr = currMainStr + "-"
            mainLabel.text = currMainStr
            done = false
        }
    }
    // button *
    @IBAction func buttonMul(_ sender: UIButton) {
        if(currMainStr.last != "+" && currMainStr.last != "-" && currMainStr.last != "*" && currMainStr.last != "/" && currMainStr.last != "."){
            mainLabel.backgroundColor = UIColor.darkGray
            currMainStr = currMainStr + "*"
            mainLabel.text = currMainStr
            done = false
        }
    }
    //button /
    @IBAction func buttonDiv(_ sender: UIButton) {
        if(currMainStr.last != "+" && currMainStr.last != "-" && currMainStr.last != "*" && currMainStr.last != "/" && currMainStr.last != "."){
            mainLabel.backgroundColor = UIColor.darkGray
            currMainStr = currMainStr + "/"
            mainLabel.text = currMainStr
            done = false
        }
    }
    //button AC
    @IBAction func buttonAllClean(_ sender: UIButton) {
        mainLabel.backgroundColor = UIColor.darkGray
        currMainStr = ""
        /*currSubStr = ""
        currTempStr = ""*/
        mainLabel.text = "0"
        done = false
    }
    //button backspace
    @IBAction func buttonBS(_ sender: UIButton) {
        if(currMainStr.count == 1)
        {
            currMainStr = ""
            mainLabel.text = "0"
            done = false
        }
        else if(currMainStr == "")
        {
            
        }
        else{
            currMainStr.removeLast()
            mainLabel.text = currMainStr
        }
    }
    
    // calculation module
    func calString(current: String) -> String{
        
        var numberCollector :Array<Double> = []
        var signCollector :String = ""
        var currentStr = current
        if currentStr.first == "-"
        {
            currentStr = "0" + currentStr
            
        }
        currentStr.append("$")
        
        var tempStr :String = ""
        for char in currentStr{
            //print(char,"char")
            if(char.isNumber)
            {
                tempStr.append(char)
            }
            else if(char == ".")
            {
                tempStr.append(char)
            }
            //print(tempStr,"tempstr")
            if(char == "/" || char == "*")
            {
                numberCollector.append(Double(tempStr)!)
                tempStr = ""
                signCollector.append(char)
            }
            if(char == "+" || char == "-"){
                numberCollector.append(Double(tempStr)!)
                tempStr = ""
                signCollector.append(char)
            }
            if(char == "$")
            {
                numberCollector.append(Double(tempStr)!)
                tempStr = ""
            }
            //print(tempStr,"tempstr2")
        }
        
        //print(numberCollector)
        //print(signCollector)
    
        var count =  0
        
            while(!signCollector.isEmpty){
                var number = numberCollector[numberCollector.index(numberCollector.startIndex, offsetBy: count)]
                if(count+1 >= numberCollector.count)
                {
                    break
                }
                var number2 = numberCollector[numberCollector.index(numberCollector.startIndex+1, offsetBy: count)]
                var sign = signCollector[signCollector.index(signCollector.startIndex, offsetBy: count)]
                //print("1: ",number)
                //print("2: ",number2)
                if(sign == "*"){
                    var result = Double(number) * Double(number2)
                    numberCollector[numberCollector.index(numberCollector.startIndex, offsetBy: count)] = result
                    //print(numberCollector[numberCollector.index(numberCollector.startIndex, offsetBy: count)] )
                    numberCollector.remove(at: count+1)
                    let index = signCollector.index(signCollector.startIndex, offsetBy: count)
                    signCollector.remove(at: index)
                    print(signCollector)
                    count = 0
                }
                else if(sign == "/")
                {
                    var result = Double(number) / Double(number2)
                    numberCollector[numberCollector.index(numberCollector.startIndex, offsetBy: count)] = result
                    numberCollector.remove(at: count+1)
                    let index = signCollector.index(signCollector.startIndex, offsetBy: count)
                    signCollector.remove(at: index)
                    //print(signCollector)
                    count = 0
                }
                else
                {
                    count+=1
                }
                
            }
        //print(numberCollector)
        //print(signCollector)
        
        count = 0
        while(!signCollector.isEmpty){
            var number = numberCollector[numberCollector.index(numberCollector.startIndex, offsetBy: count)]
            if(count+1 >= numberCollector.count)
            {
                break
            }
            var number2 = numberCollector[numberCollector.index(numberCollector.startIndex+1, offsetBy: count)]
            var sign = signCollector[signCollector.index(signCollector.startIndex, offsetBy: count)]
            //print("1: ",number)
            //print("2: ",number2)
            if(sign == "+"){
                var result = Double(number) + Double(number2)
                numberCollector[numberCollector.index(numberCollector.startIndex, offsetBy: count)] = result
                //print(numberCollector[numberCollector.index(numberCollector.startIndex, offsetBy: count)] )
                numberCollector.remove(at: count+1)
                let index = signCollector.index(signCollector.startIndex, offsetBy: count)
                signCollector.remove(at: index)
                //print(signCollector)
                count = 0
            }
            else if(sign == "-")
            {
                var result = Double(number) - Double(number2)
                numberCollector[numberCollector.index(numberCollector.startIndex, offsetBy: count)] = result
                numberCollector.remove(at: count+1)
                let index = signCollector.index(signCollector.startIndex, offsetBy: count)
                signCollector.remove(at: index)
                //print(signCollector)
                count = 0
            }
            else
            {
                count+=1
            }
        }
        //print(numberCollector)
        //print(signCollector)
        var changeForm :String = String(numberCollector.first!)
        return changeForm
    }
    
    //func cal(


}

