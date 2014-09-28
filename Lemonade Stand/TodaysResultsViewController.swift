//
//  TodaysResultsViewController.swift
//  Lemonade Stand
//
//  Created by Steven Shatz on 9/23/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation
import UIKit

protocol TodaysResultsViewControllerDelegate {
    func todaysResultsVCDidFinish(controller: TodaysResultsViewController, todaysResults: Results?)
}

class TodaysResultsViewController: UIViewController {
    
    var delegate: TodaysResultsViewControllerDelegate? = nil
    
    var numberOfLemonsToUse: Int!
    var numberOfSugarCubesToUse: Int!
    
    var todaysResults: Results!

    @IBOutlet weak var numCustomersLabel: UILabel!
    @IBOutlet weak var lemonadeAvailableLabel: UILabel!
    @IBOutlet weak var glassesSoldLabel: UILabel!
    @IBOutlet weak var pricePerGlassLabel: UILabel!
    @IBOutlet weak var totalSalesLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    @IBOutlet weak var todaysProfitOrLossLabel: UILabel!
    @IBOutlet weak var todaysProfitOrLossAmountLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if numberOfLemonsToUse < 1 || numberOfSugarCubesToUse < 1 {
//            showAlertWithText(message: "You need at least 1 lemon and 1 sugar cube to make lemonade!")
//            delegate!.todaysResultsVCDidFinish(self, todaysResults: nil)
//        }
        
        todaysResults = LemonadeBrains.determineTodaysResults(numberOfLemonsToUse, numberOfSugarCubesToUse: numberOfSugarCubesToUse)
        
        self.setDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDisplay() {
        numCustomersLabel.text = "\(self.todaysResults.numberOfCustomers)"
        lemonadeAvailableLabel.text = "\(self.todaysResults.glassesOfLemonadeAvailable)"
        glassesSoldLabel.text = "\(self.todaysResults.numberOfGlassesSold)"
        pricePerGlassLabel.text = "\(self.todaysResults.pricePerGlassSold)"
        totalSalesLabel.text = "\(self.todaysResults.lemonadeSales)"
        totalCostLabel.text = "\(self.todaysResults.costToMakeLemonade)"
        
        if self.todaysResults.totalLemonadeProfitOrLoss >= 0 {
            todaysProfitOrLossLabel.text = "F. Today's Profit:"
        } else {
            todaysProfitOrLossLabel.text = "F. Today's Loss:"
        }
        
        todaysProfitOrLossAmountLabel.text = "\(self.todaysResults.totalLemonadeProfitOrLoss)"
        
        weatherImageView.image = self.todaysResults.weatherImage!
        self.view.backgroundColor = self.todaysResults.weatherImageBackgroundColor!
        self.view.addSubview(weatherImageView)
    }
    
    @IBAction func continueButtonPressed(sender: UIButton) {
        //println("\nContinue button was Pressed")
        if delegate != nil {
            delegate!.todaysResultsVCDidFinish(self, todaysResults: self.todaysResults)
        } else {
            println("delegate is nil - should never happen")
        }
        
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {   // "Warning" is default value of 1st parm
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}