//
//  ViewController.swift
//  MyCurrency
//
//  Created by Aleksandr Grek on 17.09.2020.
//  Copyright © 2020 Aleksandr Grek. All rights reserved.
//

import UIKit
import QuartzCore
import SwiftSoup

class ViewController: UIViewController {

    
    @IBOutlet weak var textInput: UILabel!
    @IBOutlet weak var button1: CustomButton!
    @IBOutlet weak var textOutput: UILabel!
    @IBOutlet weak var clearOneButton: CustomButton!
    
    @IBOutlet weak var plusButton: CustomButton!
    @IBOutlet weak var minusButton: CustomButton!
    @IBOutlet weak var equalsButton: CustomButton!
    
    @IBOutlet weak var firstBar: UISegmentedControl!
    @IBOutlet weak var secondBar: UISegmentedControl!
    
    
    
    let impactGenerator = UIImpactFeedbackGenerator()
    let generator = UINotificationFeedbackGenerator()
    
    var prevClickedButtonIsEquals : Bool = false
    var prevClickeddButtonPlusOrMinus : Bool = false
    var prevClickeddButtonIsNumeric : Bool = false
    let pasteboard = UIPasteboard.general
    
  
 
    

    var previousValue : Double = 0.0
    var nextValue : Double = 0.0
    var actionCalculator = ""
    var actionEnabled : Bool = false
    
    
    
    var UsdToEur : Double = 0.84
    var UsdToRub : Double = 75.70
    var UsdToUah : Double = 28.16
    
    
    var EurToUsd : Double = 1.18
    var EurToRub : Double = 89.64
    var EurToUah : Double = 33.35
    
    
    var RubToUsd : Double = 0.013
    var RubToEur : Double = 0.011
    var RubToUah : Double = 0.37
    
    var UahToUsd : Double = 0.036
    var UahToEur : Double = 0.030
    var UahToRub : Double = 2.69
    
    
    
    
    override func viewDidLoad() { // initializing Strart
       
        super.viewDidLoad()
    
        textInput.layer.cornerRadius = 30
        textInput.layer.masksToBounds = true
        
        textOutput.layer.cornerRadius = 30
        textOutput.layer.masksToBounds = true
        
        firstBar.frame.size.height = 35
        secondBar.frame.size.height = 35
        
    
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        refreshCurrencies()
    }
    
    
    
    @IBAction func plusButtonAction(_ sender: CustomButton) {
        
        
        if prevClickeddButtonPlusOrMinus  && prevClickeddButtonIsNumeric { // may be shit
            
        
            
            if(actionCalculator == "plus"){
                
                nextValue = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))!
                previousValue = previousValue + nextValue
           
                textInput.text = splitNumber(input :String(previousValue))
              
               
               
               
                
            }
            
            else if actionCalculator == "minus" {
           
             nextValue = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))!
             previousValue = previousValue - nextValue
        
                textInput.text = splitNumber(input: String(previousValue))
                
            }
        
            
            
            actionCalculator = "plus"
            actionEnabled = true
            impactGenerator.impactOccurred()
            prevClickeddButtonIsNumeric = false
            return
            
            
        }
        
        
        actionCalculator = "plus"
        actionEnabled = true
        impactGenerator.impactOccurred()
        
      
    
        
        previousValue = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))!
        
        
      
        prevClickeddButtonIsNumeric = false
        
        prevClickedButtonIsEquals = false
        prevClickeddButtonPlusOrMinus = true
        
        minusButton.backgroundColor = UIColor.systemOrange
        minusButton.tintColor = UIColor.white
    }
    
    
    
    @IBAction func minusButtonAction(_ sender: CustomButton) {
        
      
        if prevClickeddButtonPlusOrMinus && prevClickeddButtonIsNumeric { // may be shit
            
        
            
            if(actionCalculator == "plus"){
                
                nextValue = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))!
                previousValue = previousValue + nextValue
           
                textInput.text = splitNumber(input : String(previousValue))
              
               
                
            }
            
            else if actionCalculator == "minus" {
           
             nextValue = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))!
             previousValue = previousValue - nextValue
        
                textInput.text = splitNumber(input : String(previousValue))
                
            }
        
            
            
            actionCalculator = "minus"
            actionEnabled = true
            impactGenerator.impactOccurred()
            prevClickeddButtonIsNumeric = false
            return
        }
        
        
        
        
        actionCalculator = "minus"
        actionEnabled = true
        impactGenerator.impactOccurred()
        
        
     
        
        previousValue = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))!
        
       

        
        
        prevClickedButtonIsEquals = false
        prevClickeddButtonPlusOrMinus = true
        
        prevClickeddButtonIsNumeric = false
        
        
        plusButton.backgroundColor = UIColor.systemOrange
        plusButton.tintColor = UIColor.white
        
    }
    
    
    @IBAction func equalsAction(_ sender: CustomButton) {
        
        
        if(actionCalculator == ""){
            impactGenerator.impactOccurred()
            return
        }
        
        if(prevClickedButtonIsEquals){
            
            if(actionCalculator == "plus"){
                textInput.text = splitNumber(input : String(Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! + nextValue))
                impactGenerator.impactOccurred()
            }
            else if (actionCalculator == "minus"){
            
            textInput.text = splitNumber(input : String(Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! - nextValue))
                impactGenerator.impactOccurred()
                
            }
            
            
            exchange()
            prevClickeddButtonPlusOrMinus = false
            return
        }
        
        
        if actionCalculator == "plus" {
            
           nextValue = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))!
            textInput.text = splitNumber(input : String(previousValue + nextValue))
            impactGenerator.impactOccurred()
        }
        
        else if actionCalculator == "minus" {
            
            nextValue = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))!
             textInput.text = splitNumber(input : String(previousValue - nextValue))
             impactGenerator.impactOccurred()
        }
       
        
        plusButton.backgroundColor = UIColor.systemOrange
        plusButton.tintColor = UIColor.white
        minusButton.backgroundColor = UIColor.systemOrange
        minusButton.tintColor = UIColor.white
    
        
        
        
        
        exchange()
        prevClickedButtonIsEquals = true
        prevClickeddButtonPlusOrMinus = false
        prevClickeddButtonIsNumeric = false
    }
    
    
    
    @IBAction func action(_ sender: CustomButton) {
        

        // code to add numberValue to textInput
        
        if let text = sender.titleLabel?.text {
            
            if(actionEnabled){
                
                textInput.text = splitNumber(input : text)
                actionEnabled = false
            }
            
            else {
            
            if (textInput?.text) != nil {
                
                
                if textInput.text == "0" {
                    
                    textInput.text =  splitNumber(input : text)
                }
                else {
                
                textInput.text = splitNumber(input : textInput.text! + text)
                    
                }
            }
            
            }
            
        }
       
        impactGenerator.impactOccurred()
        exchange()
        
        
        prevClickedButtonIsEquals = false
        prevClickeddButtonIsNumeric = true
    }
    
    
    @IBAction func comaAction(_ sender: CustomButton) {
        
        
        let textInInput : String = textInput.text!.replacingOccurrences(of: " ", with: "")
        
    
        if textInInput.contains(".") {
            
            sender.anotherShake()
            impactGenerator.impactOccurred()
            return
        }
        else {
            
            textInput.text = splitNumber(input : textInput.text! + ".")
            
        }
        
        impactGenerator.impactOccurred()
        prevClickedButtonIsEquals = false
    }
    
    
    
    
    @IBAction func clearAction(_ sender: CustomButton) {
        
        
        previousValue = 0.0
        nextValue = 0.0
        actionCalculator = ""
        actionEnabled = false
        
        textInput.text = "0"
        textOutput.text = "0"
       
        generator.notificationOccurred(.success)
        
        

        prevClickedButtonIsEquals = false
        prevClickeddButtonPlusOrMinus = false
        prevClickeddButtonIsNumeric = false
    }
    
    
    
    @IBAction func clearOne(_ sender: CustomButton) {
        
        

            if (textInput?.text) != nil {
                
                let text = textInput.text!
                
                
                if textInput.text == "0" {
                    
                    
                }
                else if textInput.text?.count == 1{
                    textInput.text = "0"
                }
                else if textInput.text?.count == 2 && text.contains("-")
                {
                    textInput.text = "0"
                }
                else {
                    
                    
                    var lol = textInput.text!.replacingOccurrences(of: " ", with: "")
                    lol.removeLast()
                    textInput.text = splitNumber(input : lol)
                
                   
                    
                }
            }
        
        
      
        impactGenerator.impactOccurred()
        exchange()
        
        
        prevClickedButtonIsEquals = false
    }
    
    
    
    
    @IBAction func firstBarChanged(_ sender: UISegmentedControl) {
        
        impactGenerator.impactOccurred()
        exchange()
        
    }
    
    @IBAction func secondBarChanged(_ sender: UISegmentedControl) {
        
        impactGenerator.impactOccurred()
        exchange()
    }
    
    
    
    func exchange(){
        
        if(firstBar.selectedSegmentIndex == secondBar.selectedSegmentIndex || textInput.text == "0"){
            textOutput.text = textInput.text
            return
            
        }
        
        if (textInput?.text) != nil {
        
        if(firstBar.selectedSegmentIndex == 0){ // from dollar
            
            
            if(secondBar.selectedSegmentIndex == 1){ // to euro
                
               
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * UsdToEur
                    textOutput.text = splitNumber(input : rounD(input: a))
                    
            }
            else if secondBar.selectedSegmentIndex == 2 { // to ruble
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * UsdToRub
                textOutput.text = splitNumber(input : rounD(input: a))
                
                
                
                
            }
            
            else if secondBar.selectedSegmentIndex == 3{ // to uah
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * UsdToUah
                textOutput.text = splitNumber(input : rounD(input: a))
            }
        
            
        }
        else if firstBar.selectedSegmentIndex == 1 { // from euro
            
            
            if secondBar.selectedSegmentIndex == 0 { // to dollar
                
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * EurToUsd
                textOutput.text = splitNumber(input : rounD(input: a))
                
                
            }
            else if secondBar.selectedSegmentIndex == 2 { // to ruble
                
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * EurToRub
                textOutput.text = splitNumber(input : rounD(input: a))
            }
            else if(secondBar.selectedSegmentIndex == 3){ // to uah
                
                
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * EurToUah
                textOutput.text = splitNumber(input : rounD(input: a))
                
            }
            
            
        }
        
        else if firstBar.selectedSegmentIndex == 2 { // from ruble
        
            
            if secondBar.selectedSegmentIndex == 0 { // to dollar
                
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * RubToUsd
                textOutput.text = splitNumber(input : rounD(input: a))
            }
            
            
            else if secondBar.selectedSegmentIndex == 1 { // to euro
                
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * RubToEur
                textOutput.text = splitNumber(input : rounD(input: a))
                
            }
            else if secondBar.selectedSegmentIndex == 3 { // to uah
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * RubToUah
                textOutput.text = splitNumber(input : rounD(input: a))
            }
            
        }
        else if firstBar.selectedSegmentIndex == 3 { // from uah
            
            if secondBar.selectedSegmentIndex == 0 { // to dollar
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * UahToUsd
                textOutput.text = splitNumber(input :  rounD(input: a))
                
            }
            else if secondBar.selectedSegmentIndex == 1 { // to euro
                
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * UahToEur
                textOutput.text = splitNumber(input : rounD(input: a))
                
            }
            else if secondBar.selectedSegmentIndex == 2{ // to ruble
                
                
                let a = Double(textInput.text!.replacingOccurrences(of: " ", with: ""))! * UahToRub
                textOutput.text = splitNumber(input : rounD(input: a))
                
            }
            
            
        }
        
        
        
                                    }
    }
    
    
    func rounD(input : Double) -> String {
        let a = Double(round((input*100))/100)
        return String(a)
        
    }
    
    
    
    
    
    
    @IBAction func holdDown(_ sender: CustomButton) {
        
        
        
        sender.backgroundColor = UIColor.lightGray
        sender.tintColor = UIColor.black
        
        
        
        
    }
    
    
    
    @IBAction func holdRelease(_ sender: CustomButton) {
        
        
        
        sender.backgroundColor =  UIColor.init(red: 0.187257, green: 0.187257, blue: 0.187257, alpha: 1)
        sender.tintColor = UIColor.white
        
    }
    
    
    
    @IBAction func holdReleaseOrange(_ sender: CustomButton) {
        
        
        sender.backgroundColor = UIColor.systemOrange
        sender.tintColor = UIColor.white
    
        
    }
    
    
    
    
    @IBAction func touchDownOrange(_ sender: CustomButton) {
        
        sender.backgroundColor = UIColor.white
        sender.tintColor = UIColor.black
       
        
        
        
        
    }
    
    
    
    @IBAction func touchMinusPlus(_ sender: CustomButton) {
        
        sender.backgroundColor = UIColor.white
        sender.tintColor = UIColor.black
       
        
        
    }
    
    
    
    func refreshCurrencies(){
        
        
        
        let myURLString = "https://www.profinance.ru/currency_eur.asp"
        guard let myURL = URL(string: myURLString) else {
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            // myHTMLString I got
            // now use SwiftSoup
            
            
            let doc: Document = try SwiftSoup.parse(myHTMLString)
            
            
            let USD_TO_RUB = Double(try doc.select("#curtable > tbody > tr:nth-child(6) > td:nth-child(4)").text())!
            
            let EUR_TO_RUB = Double(try doc.select("#curtable > tbody > tr:nth-child(7) > td:nth-child(4)").text())!
            
            let UAH_TO_RUB =  Double(try doc.select("#curtable > tbody > tr:nth-child(15) > td:nth-child(4)").text())! / 10
            
            
            print("USD_TO_RUB : " + String(USD_TO_RUB))
            print("EUR_TO_RUB : " + String(EUR_TO_RUB))
            print("UAH_TO_RUB : " + String(UAH_TO_RUB))
            
            
            UsdToRub = USD_TO_RUB
            RubToUsd = 1 / USD_TO_RUB
            
            
            EurToRub = EUR_TO_RUB
            RubToEur = 1 / EurToRub
            
            UahToRub = UAH_TO_RUB
            RubToUah = 1 / UahToRub
            
            
            UsdToEur = UsdToRub / EurToRub
            UahToUsd = UahToRub / UsdToRub
            
            
            UsdToUah = 1 / UahToUsd
            EurToUsd = 1 / UsdToEur
            
            
            
            
            
            
        }
        catch let error {
        print(error)
            
        }
    
    
    }
    
    
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        
        
        
        if (textInput?.text) != nil {
            
            let text = textInput.text!
            
            
            if textInput.text == "0" {
                
                
            }
            else if textInput.text?.count == 1{
                textInput.text = "0"
            }
            else if textInput.text?.count == 2 && text.contains("-")
            {
                textInput.text = "0"
            }
            else {
            
                
                var lol = textInput.text!.replacingOccurrences(of: " ", with: "")
                lol.removeLast()
                textInput.text = splitNumber(input : lol)
            
                
            }
        }
    
    
  
    impactGenerator.impactOccurred()
    exchange()
    
    
    prevClickedButtonIsEquals = false
        
    }
    
    
    
    @IBAction func copyAction(_ sender: UITextField) {
        

        pasteboard.string = textInput.text!.replacingOccurrences(of: " ", with: "")
        
     
                   generator.notificationOccurred(.success)
        


        let alertController = UIAlertController(title: "Copied", message:
                                                    "", preferredStyle: .alert)
        present(alertController, animated: true) {
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                      alertController.dismiss(animated: true, completion: nil)
                  }
    

      
    }
    }
    
    
    
    @IBAction func copyOutputAction(_ sender: Any) {
        
        pasteboard.string = textOutput.text!.replacingOccurrences(of: " ", with: "")
        generator.notificationOccurred(.success)


        let alertController = UIAlertController(title: "Copied", message:
                                         "", preferredStyle: .alert)
        present(alertController, animated: true) {
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
           alertController.dismiss(animated: true, completion: nil)
       }



}
       
    }
    
    
    
    @IBAction func refreshAction(_ sender: CustomButton) {
        
        refreshCurrencies()
        
        sender.roll()
        generator.notificationOccurred(.success)
        
        let alertController = UIAlertController(title: "Currencies refreshed", message:
                                         "", preferredStyle: .alert)
        present(alertController, animated: true) {
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
           alertController.dismiss(animated: true, completion: nil)
       }



}
        
        exchange()
        
    }
    
    
    
    func splitNumber(input : String) -> String {
        
        let input2 = input.replacingOccurrences(of: " " , with: "")
        
        var after : String = ""
        
        
        if input2.contains(".") {
            
            after = String(input2[input2.firstIndex(of: ".")!...])
            
            
            
            
        }
        
        else if input2.count <= 3 {
        
                return input2
            
        }
        
        let before : String = input2.replacingOccurrences(of: after, with: "")
        
        
        var newBefore = ""
        
        for char in before.reversed() {
            
            
            if(newBefore.replacingOccurrences(of: " ", with: "").count % 3 == 0){
                
                newBefore = newBefore + " "
            }
            
            newBefore = newBefore + String(char)
            
           /// was here
            
        }
        
        newBefore = String(newBefore.reversed())
        
       
        
        if newBefore.last == " " {
            
            newBefore.removeLast()
            
        }
        
        
        if after == ".0" { // to delete zero value of double number 
            
            return  newBefore
            
        }
        
        return newBefore + after
    }
    
    
    
}

