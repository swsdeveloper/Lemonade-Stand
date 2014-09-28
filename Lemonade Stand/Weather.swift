//
//  Weather.swift
//  Lemonade Stand
//
//  Created by Steven Shatz on 9/27/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation
import UIKit

class Weather {
    
    enum WeatherPattern: Int {
        case Cold = 1,
        Mild = 2,
        Warm = 3
    }
    
    
    class func getTodaysWeatherPattern() -> WeatherPattern {
        let kMaxWeatherPatterns: Int = 3
        return randomlyGenerateWeatherPattern(kMaxWeatherPatterns)
    }

    class func getTodaysWeatherImageFor(todaysWeatherPattern: WeatherPattern) -> (UIImage, UIColor) {
        return getWeatherImageFor(todaysWeatherPattern)
    }

    class func getNameOfTodaysWeatherFor(todaysWeatherPattern: WeatherPattern) -> String {
        switch todaysWeatherPattern.toRaw() {
        case 1:
            return "Cold"
        case 2:
            return "Mild"
        case 3:
            return "Warm"
        default:
            return "Unknown"
        }
    }

    
    // Helpers

    class func randomlyGenerateWeatherPattern(maxWeatherPatterns: Int) -> WeatherPattern {
        let randomNumber = Int(arc4random_uniform(UInt32(maxWeatherPatterns))) + 1
        switch randomNumber {
        case 1:
            return .Cold
        case 2:
            return .Mild
        case 3:
            return .Warm
        default:
            return .Mild
        }
    }
    
    class func getWeatherImageFor(weatherPattern: WeatherPattern) -> (UIImage, UIColor) {
        switch weatherPattern.toRaw() {
        case 1:
            return (UIImage(named: "Cold"), UIColor.cyanColor())
        case 2:
            return (UIImage(named: "Mild"), UIColor.lightGrayColor())
        case 3:
            return (UIImage(named: "Warm"), UIColor.orangeColor())
        default:
            return (UIImage(named: "Mild"), UIColor.lightGrayColor())
        }
    }
}
