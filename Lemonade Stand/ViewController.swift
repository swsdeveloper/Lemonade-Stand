//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by Steven Shatz on 9/18/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TodaysResultsViewControllerDelegate {
    
    
    // To Do: Make # of lemons and sugar cubes used restrict max glasses of lemonade that can be sold
    // the more you risk, the more glasses you can sell
    // formula:  (#lemons used * 3) + (#sugar cubes used *2) = max # of glasses you can sell
    
    
    /*
    This application is meant to be a simple game so you should keep this in mind if you are planning to implement your own custom design. The goal of the game will be to maintain a profit each day of the game. As soon as you don’t have enough money to purchase new inventory, the game should end.
    
    Here are some more details that will be important for the game. The player should start with $10, 1 Lemon, and 1 Ice Cube. Each additional Lemon will cost $2, and each additional Ice Cube $1.
    
    First thing that you should do is set up the storyboard. We’ve attached a screenshot of the view, so that you can imitate it for your project. Be aware of the spacing and connection type of each object in your view. We don’t want anything overlapping or looking cluttered. Also, make sure you are hooking up your storyboard elements properly. For example, your declared IBActions, for when a button is pressed, should be of connection type, Action, with type AnyObject, with the Event type, Touch Up Inside, and finally, has the argument, Sender.
    
    As for the storyboard setup, make sure you have the following 4 sections: What supplies you (the player) have, a section to purchase supplies (like more lemons, ice cubes, etc), a third area where you can create the lemonade, and lastly, a section with your sell lemonade button.
    
    -------------------
    SWS: I changed ice cubes to sugar cubes and made numerous other changes and improvements
    */
    
    
    // Inventory
    
    var cashOnHand: Int = 0
    var lemonsOnHand: Int = 0
    var sugarCubesOnHand: Int = 0
    
    // Purchases (and Unpurchases)
    
    var numberOfLemonsToPurchase: Int = 0
    var numberOfSugarCubesToPurchase: Int = 0
    
    // Usage
    
    var numberOfLemonsToUse: Int = 0
    var numberOfSugarCubesToUse: Int = 0
    
    // Constants
    
    let kLemonPrice: Int = 2         // $2
    let kSugarCubePrice: Int = 1     // $1
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initialSetup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Labels
    
    @IBOutlet weak var cashOnHandLabel: UILabel!
    
    @IBOutlet weak var lemonsOnHandLabel: UILabel!
    
    @IBOutlet weak var sugarCubesOnHandLabel: UILabel!
    
    
    @IBOutlet weak var lemonsToPurchaseLabel: UILabel!
    
    @IBOutlet weak var sugarCubesToPurchaseLabel: UILabel!
    
    
    @IBOutlet weak var lemonsToUseLabel: UILabel!
    
    @IBOutlet weak var sugarCubesToUseLabel: UILabel!
    
    
    
    // Actions

    
    @IBAction func plusLemonsToPurchaseButtonPressed(sender: UIButton) {
        //println("plusLemonsToPurchaseButtonPressed")
        
        if cashOnHand >= kLemonPrice {
            numberOfLemonsToPurchase += 1
            lemonsOnHand += 1
            cashOnHand -= kLemonPrice
        }
        else {
            showAlertWithText(message: "You do not have enough cash to purchase another lemon!")
        }
        updateInventoryLabels()
    }
    
    @IBAction func minusLemonsToPurchaseButtonPressed(sender: UIButton) {
        //println("minusLemonsToPurchaseButtonPressed")
        
        if lemonsOnHand >= 1 {
            numberOfLemonsToPurchase -= 1
            lemonsOnHand -= 1
            cashOnHand += kLemonPrice
        }
        else {
            showAlertWithText(message: "You have no more lemons!")
        }
        updateInventoryLabels()
    }
    
    
    @IBAction func plusSugarCubesToPurchaseButtonPressed(sender: UIButton) {
        //println("plusSugarCubesToPurchaseButtonPressed")

        if cashOnHand >= kSugarCubePrice {
            numberOfSugarCubesToPurchase += 1
            sugarCubesOnHand += 1
            cashOnHand -= kSugarCubePrice
        }
        else {
            showAlertWithText(message: "You do not have enough cash to purchase another sugar cube!")
        }
        updateInventoryLabels()
    }
    
    @IBAction func minusSugarCubesToPurchaseButtonPressed(sender: UIButton) {
        //println("minusSugarCubesToPurchaseButtonPressed")
        
        if sugarCubesOnHand >= 1 {
            numberOfSugarCubesToPurchase -= 1
            sugarCubesOnHand -= 1
            cashOnHand += kSugarCubePrice
        }
        else {
            showAlertWithText(message: "You have no more sugar cubes!")
        }
        updateInventoryLabels()
    }
    
    
    @IBAction func plusLemonsToUseButtonPressed(sender: UIButton) {
        //println("plusLemonsToUseButtonPressed")
        
        if lemonsOnHand >= 1 {
            numberOfLemonsToUse += 1
            lemonsOnHand -= 1
        }
        else {
            showAlertWithText(message: "You have used all of your lemons!")
        }
        updateInventoryLabels()
    }
    
    @IBAction func minusLemonsToUseButtonPressed(sender: UIButton) {
        //println("minusLemonsToUseButtonPressed")
        
        if numberOfLemonsToUse >= 2 {
            numberOfLemonsToUse -= 1
            lemonsOnHand += 1
        }
        else {
            showAlertWithText(message: "You cannot make lemonade without at least 1 lemon!")
        }
        updateInventoryLabels()
    }
    
    @IBAction func plusSugarCubesToUseButtonPressed(sender: UIButton) {
        //println("plusSugarCubesToUseButtonPressed")
        
        if sugarCubesOnHand >= 1 {
            numberOfSugarCubesToUse += 1
            sugarCubesOnHand -= 1
        }
        else {
            showAlertWithText(message: "You have used all of your sugar cubes!")
        }
        updateInventoryLabels()
    }
    
    @IBAction func minusSugarCubesToUseButtonPressed(sender: UIButton) {
        //println("minusSugarCubesToUseButtonPressed")
        
        if numberOfSugarCubesToUse >= 2 {
            numberOfSugarCubesToUse -= 1
            sugarCubesOnHand += 1
        }
        else {
            showAlertWithText(message: "You cannot make lemonade without at least 1 sugar cube!")
        }
        updateInventoryLabels()
    }

    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        // Note: Before this code is executed, prepareForsegue() and shouldPerformSegueWithIdentifier() are invoked !!! (see below)
        println("\nStart Day button was Pressed")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "segueToResultsView" && self.numberOfLemonsToUse > 0 && self.numberOfSugarCubesToUse > 0 {
            let vc = segue.destinationViewController as TodaysResultsViewController
            vc.delegate = self
            vc.numberOfLemonsToUse = self.numberOfLemonsToUse
            vc.numberOfSugarCubesToUse = self.numberOfSugarCubesToUse
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if self.numberOfLemonsToUse < 1 || self.numberOfSugarCubesToUse < 1 {
            showAlertWithText(message: "You need at least 1 lemon and 1 sugar cube to make lemonade!")
            return false
        }
        return true
    }


    // *******************
    // * Delegate Method *
    // *******************
    
    func todaysResultsVCDidFinish(controller: TodaysResultsViewController, todaysResults: Results?) {
        //println("In todaysResultsVCDidFinish")
        
        controller.navigationController?.popViewControllerAnimated(true)
        
        if todaysResults != nil {
            cashOnHand = cashOnHand + todaysResults!.lemonadeSales
            
            if cashOnHand <= 3 && lemonsOnHand < 1 && sugarCubesOnHand < 1 {
                showAlertWithText(header: "You Lose!", message: "You don't have enough cash, lemons, and/or sugar cubes to make lemonade.\n\nPress OK to start again.")
                initialSetup()
            } else {
                numberOfLemonsToPurchase = 0
                numberOfSugarCubesToPurchase = 0
                numberOfLemonsToUse = 0
                numberOfSugarCubesToUse = 0
                updateInventoryLabels()
            }
        }
    }
    
    
    // ***********
    // * Helpers *
    // ***********
    
    func initialSetup() {
        
        cashOnHand = 20
        lemonsOnHand = 1
        sugarCubesOnHand = 1
        
        numberOfLemonsToPurchase = 0
        numberOfSugarCubesToPurchase = 0
        
        numberOfLemonsToUse = 0
        numberOfSugarCubesToUse = 0
        
        updateInventoryLabels()
        
    }
    
    func updateInventoryLabels() {
        var lemonSuffix: String = ""
        if lemonsOnHand != 1 { lemonSuffix = "s" }
        
        var sugarCubeSuffix: String = ""
        if sugarCubesOnHand != 1 { sugarCubeSuffix = "s" }
        
        cashOnHandLabel.text = "$\(cashOnHand)"
        lemonsOnHandLabel.text = "\(lemonsOnHand) Lemon" + lemonSuffix + " ($\(lemonsOnHand * kLemonPrice))"
        sugarCubesOnHandLabel.text = "\(sugarCubesOnHand) Sugar Cube" + sugarCubeSuffix + " ($\(sugarCubesOnHand * kSugarCubePrice))"
        
        lemonsToPurchaseLabel.text = "\(numberOfLemonsToPurchase)"
        sugarCubesToPurchaseLabel.text = "\(numberOfSugarCubesToPurchase)"
        
        lemonsToUseLabel.text = "\(numberOfLemonsToUse)"
        sugarCubesToUseLabel.text = "\(numberOfSugarCubesToUse)"
    }
    
    
    func showAlertWithText(header: String = "Warning", message: String) {   // "Warning" is default value of 1st parm
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

