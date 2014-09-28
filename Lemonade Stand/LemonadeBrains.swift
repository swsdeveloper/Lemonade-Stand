//
//  LemonadeBrains.swift
//  Lemonade Stand
//
//  Created by Steven Shatz on 9/18/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation
import UIKit

/* When day begins:
    1. Determine sweetness level oflemonade (# of sugar cubes / # of lemons):
        eg: Level 1 : 10 sugar cubes /  1 lemon  = sweetness level 10.0   extremely sweet
            Level 2 :  6 sugar cubes /  1 lemon  = sweetness level 6.0    very sweet
            Level 3 :  7 sugar cubes /  2 lemon  = sweetness level 3.5    sweet
            Level 4 :  7 sugar cubes /  4 lemons = sweetness level 1.75   a bit sweet
            Level 5 :  9 sugar cubes / 10 lemons = sweetness level 0.900  neutral
            Level 6 :  5 sugar cubes /  6 lemons = sweetness level 0.833  a bit tart
            Level 7 :  6 sugar cubes /  9 lemons = sweetness level 0.667  tart
            Level 8 :  1 sugar cube  /  3 lemons = sweetness level 0.333  very tart
            Level 9:   1 sugar cube  / 10 lemons = sweetness level 0.100  extremely tart
    2. Randomly gen # of customers (1 - 10)
    3. Randomly gen each customer's taste preference (how sweet vs how tart they prefer their lemonade)
        - if  1: extremely sweet:   >= 7.0
              2: very sweet:        >= 4.0 and < 7.0
              3: sweet:             >= 2.0 and < 4.0
              4: a bit sweet        >= 1.0 and < 2.0
              5: neutral            >= 0.9 and < 1.0
              6: a bit tart         >= 0.8 and < 0.9
              7: tart               >= 0.6 and < 0.8
              8: very tart          >= 0.3 and < 0.6
              9: extremely tart     <  0.3
    4. Randomly gen weather to determine # of glasses of lemonade each customer buys:
        - if cole: each customer buys 1 drink
        - if mild: each customer buys 2 drinks
        - if warm: each customer buys 3 drinks
    5. Each customer will only buy lemonade if its sweetness level is within their acceptable range:
        1. if cust likes extremely sweet - they will buy if lemonade is very sweet to extremely sweet [1 to 2]
        2. if cust likes very sweet - they will buy if lemonade is sweet to extremely sweet [1 to 3]
        3. if cust likes sweet - they will buy if lemonade is a bit sweet to very sweet [2 to 4]
        4. if cust likes a bit sweet - they will buy if lemonade is neutral to sweet [3 to 5]
        5: if cust likes neutral - they will buy if lemonade is a bit tart to a bit sweet [4 to 6]
        6. if cust likes a bit tart - they will buy if lemonade is neutral to tart [5 to 7]
        7. if cust likes tart - they will buy if lemonade is a bit tart to very tart [6 to 8]
        8. if cust likes very tart - they will buy if lemonade is tart to extremely tart [7 to 9]
        9. if cust likes extremely tart - they will buy if lemonade is very tart to extremely tart [8 to 9]
    6. Make # of lemons and sugar cubes used control max glasses of lemonade that can be sold. The more you
        risk, the more glasses you can sell:
        - Formula: (#lemons used * 3) + (#sugar cubes used *2) = max # of glasses you can sell
*/



class LemonadeBrains {
    
    
    class func determineTodaysResults(numberOfLemonsToUse: Int, numberOfSugarCubesToUse: Int) -> Results {
        
        var customerArray: [Customer] = []
        
        let kPricePerLemon: Int = 2         // $2.00
        let kPricePerSugarCube: Int = 1     // $1.00
        let kPricePerGlassSold: Int = 2     // $2.00
        
    
        let todaysNumberOfCustomers = getTodaysNumberOfCustomers()
        
        let todaysWeatherPattern = Weather.getTodaysWeatherPattern()
        let (todaysWeatherImage, todaysWeatherImageBackgroundColor) = Weather.getTodaysWeatherImageFor(todaysWeatherPattern)
        let nameOfTodaysWeather = Weather.getNameOfTodaysWeatherFor(todaysWeatherPattern)
        
        let todaysNumberOfGlassesPerCustomer: Int = todaysWeatherPattern.toRaw()
        
        let todaysLemonadeSweetnessLevel = Sweetness.getLemonadeSweetnessLevel(numberOfLemonsToUse, numSugarCubes: numberOfSugarCubesToUse)
        let nameOfTodaysLemonadeSweetnessLevel = Sweetness.getNameOfSweetnessLevel(todaysLemonadeSweetnessLevel)
        
        for _ in 1...todaysNumberOfCustomers {
            let custSweetnessPreference = Sweetness.getARandomSweetnessPreference()
            let willCustBuyLemonade = Sweetness.isLemonadeSuitableForThisSweetnessPreference(custSweetnessPreference, lemonadeSweetness: todaysLemonadeSweetnessLevel)
            var cust = Customer()
            cust.sweetnessPreference = custSweetnessPreference
            cust.willBuyLemonade = willCustBuyLemonade
            customerArray.append(cust)
        }
        
        var numberOfGlassesSold = 0
        for cust in customerArray {
            if cust.willBuyLemonade {
                numberOfGlassesSold += 1
            }
        }
        
        // Adjust # glasses sold for today's weather:
        
        numberOfGlassesSold *= todaysNumberOfGlassesPerCustomer
        
        // Adjust # glasses sold based on quantity of lemons and sugar cubes used:
        
        let glassesOfLemonadePrepared = (numberOfLemonsToUse * 3) + (numberOfSugarCubesToUse * 2)
        
        if numberOfGlassesSold > glassesOfLemonadePrepared {
            println("Number of glasses sold would have been: \(numberOfGlassesSold), but you did not make enough lemonade to satisfy demand.")
            numberOfGlassesSold = glassesOfLemonadePrepared
        }
        
        
        // Set up Results Object:
        
        var todaysResults = Results()
        
        todaysResults.numberOfLemonsUsed = numberOfLemonsToUse
        todaysResults.pricePerLemon = kPricePerLemon
        todaysResults.costOfLemons = todaysResults.computeCostOfLemons(
            todaysResults.numberOfLemonsUsed,
            pricePerLemon: todaysResults.pricePerLemon
        )
        
        todaysResults.numberOfSugarCubesUsed = numberOfSugarCubesToUse
        todaysResults.pricePerSugarCube = kPricePerSugarCube
        todaysResults.costOfSugarCubes = todaysResults.computeCostOfSugarCubes(
            todaysResults.numberOfSugarCubesUsed,
            pricePerSugarCube: todaysResults.pricePerSugarCube
        )
        
        todaysResults.glassesOfLemonadeAvailable = glassesOfLemonadePrepared
        
        todaysResults.costToMakeLemonade = todaysResults.computeCostToMakeLemonade(
            todaysResults.costOfLemons,
            costOfSugarCubes: todaysResults.costOfSugarCubes
        )
        
        todaysResults.weatherPattern = todaysWeatherPattern
        todaysResults.weatherImage = todaysWeatherImage
        todaysResults.weatherImageBackgroundColor = todaysWeatherImageBackgroundColor
        todaysResults.nameOfWeather = nameOfTodaysWeather
        
        todaysResults.numberOfGlassesPerCustomer = todaysNumberOfGlassesPerCustomer // multiplier based on today's weather

        todaysResults.numberOfCustomers = todaysNumberOfCustomers
        todaysResults.numberOfGlassesSold = numberOfGlassesSold
        todaysResults.pricePerGlassSold = kPricePerGlassSold
        todaysResults.lemonadeSales = todaysResults.computeLemonadeSales(
            todaysResults.numberOfGlassesSold,
            pricePerGlassSold: todaysResults.pricePerGlassSold
        )
        
        todaysResults.totalLemonadeProfitOrLoss = todaysResults.computeTotalLemonadeProfitOrLoss(
            todaysResults.lemonadeSales,
            costToMakeLemonade: todaysResults.costToMakeLemonade
        )
        
        var totalProfit = todaysResults.totalLemonadeProfitOrLoss

        
        println("Lemons Used: \(todaysResults.numberOfLemonsUsed), Sugar Cubes Used: \(todaysResults.numberOfSugarCubesUsed)")
        println("Glasses of Lemonade Prepared: \(todaysResults.glassesOfLemonadeAvailable)")
        println("Resulting Lemonade Sweetness Level: \(todaysLemonadeSweetnessLevel.toRaw()) = \(nameOfTodaysLemonadeSweetnessLevel)")
        println("Number of Customers: \(todaysResults.numberOfCustomers)")
        println("Today's weather: \(todaysResults.nameOfWeather)")
        println("Number of glasses per customer: \(todaysResults.numberOfGlassesPerCustomer)")
        
        for cust in customerArray {
            let nameOfCustSweetnessPreference = Sweetness.getNameOfSweetnessPreference(cust.sweetnessPreference!)
            println("Customer Sweetness Preference: \(cust.sweetnessPreference!.toRaw()) = \(nameOfCustSweetnessPreference), will Cust Buy Lemonade: \(cust.willBuyLemonade)")
        }
        
        println("Number of Glasses Sold: \(todaysResults.numberOfGlassesSold)")
        
        println("Today's Cost: \(todaysResults.costToMakeLemonade)")
        println("Today's Sales: \(todaysResults.lemonadeSales )")
                
        if totalProfit > 0 {
            println("Today's Profit = \(totalProfit)")
        } else if totalProfit < 0 {
            println("Today's Loss = \(totalProfit)")
        } else {
            println("You just broke even today")
        }
        
        return todaysResults
    }
    
    
    class func getTodaysNumberOfCustomers() -> Int {
        let kMaxCustomers: Int = 20
        return Customer.randomlyGenerateNumberOfCustomers(kMaxCustomers)
    }
    
}

