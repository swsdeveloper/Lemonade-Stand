//
//  Results.swift
//  Lemonade Stand
//
//  Created by Steven Shatz on 9/27/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation
import UIKit


struct Results {
    
    // Lemonade Cost variables
    
    var numberOfLemonsUsed: Int
    var pricePerLemon: Int
    var costOfLemons: Int               // = numberOfLemonsUsed * pricePerLemon
    
    var numberOfSugarCubesUsed: Int
    var pricePerSugarCube: Int
    var costOfSugarCubes: Int           // = numberOfSugarCubesUsed * pricePerSugarCube
    
    var glassesOfLemonadeAvailable: Int
    
    var costToMakeLemonade: Int         // = costOfLemons + costOfSugarCubes
    
    // Lemonade Sales variables
    
    var weatherPattern: Weather.WeatherPattern?
    var weatherImage: UIImage?
    var weatherImageBackgroundColor: UIColor?
    var nameOfWeather: String
    
    var numberOfGlassesPerCustomer: Int // multiplier based on weather
    
    var numberOfCustomers: Int
    var numberOfGlassesSold: Int
    var pricePerGlassSold: Int
    var lemonadeSales: Int              // = numberOfGlassesSold * pricePerGlassSold

    // Lemonade Profit or Loss variables
    
    var totalLemonadeProfitOrLoss: Int  // = lemonadeSales - costOfLemonade (if < 0, it's a Loss)
    
    
    // *************
    // * Functions *
    // *************
    
    init() {
        numberOfLemonsUsed = 0
        pricePerLemon = 0
        costOfLemons = 0
        numberOfSugarCubesUsed = 0
        pricePerSugarCube = 0
        costOfSugarCubes = 0
        glassesOfLemonadeAvailable = 0
        costToMakeLemonade = 0
        weatherPattern = nil
        weatherImage = nil
        nameOfWeather = "Unknown"
        numberOfCustomers = 0
        numberOfGlassesPerCustomer = 0
        pricePerGlassSold = 0
        numberOfGlassesSold = 0
        lemonadeSales = 0
        totalLemonadeProfitOrLoss = 0
    }
    
    func computeCostOfLemons(numberOfLemonsUsed: Int, pricePerLemon: Int) -> Int {
        return numberOfLemonsUsed * pricePerLemon
    }
    
    func computeCostOfSugarCubes(numberOfSugarCubesUsed: Int, pricePerSugarCube: Int) -> Int {
        return numberOfSugarCubesUsed * pricePerSugarCube
    }
    
    func computeCostToMakeLemonade(costOfLemons: Int, costOfSugarCubes: Int) -> Int {
        return costOfLemons + costOfSugarCubes
    }
    
    func computeLemonadeSales(numberOfGlassesSold: Int, pricePerGlassSold: Int) -> Int {
        return numberOfGlassesSold * pricePerGlassSold
    }
    
    func computeTotalLemonadeProfitOrLoss(lemonadeSales: Int, costToMakeLemonade: Int) -> Int {
        return lemonadeSales - costToMakeLemonade
    }
    
}