//
//  SweetnessPreferences.swift
//  Lemonade Stand
//
//  Created by Steven Shatz on 9/27/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation

class Sweetness {
    
    enum SweetnessLevel: Int {
        case ExtremelySweet = 1,
        VerySweet,
        Sweet,
        ABitSweet,
        Neutral,
        ABitTart,
        Tart,
        VeryTart,
        ExtremelyTart
    }
    
    typealias SweetnessPreference = SweetnessLevel
    
    class func getNameOfSweetnessLevel(sweetnessLevel: SweetnessLevel) -> String {
        switch sweetnessLevel.toRaw() {
        case 1:
            return "Extremely Sweet"
        case 2:
            return "Very Sweet"
        case 3:
            return "Sweet"
        case 4:
            return "A Bit Sweet"
        case 5:
            return "Neutral"
        case 6:
            return "A Bit Tart"
        case 7:
            return "Tart"
        case 8:
            return "Very Tart"
        case 9:
            return "Extremely Tart"
        default:
            return "Neutral"
        }
    }
    
    class func getNameOfSweetnessPreference(sweetnessPreference: SweetnessPreference) -> String {
        let sweetnessLevel: SweetnessLevel = sweetnessPreference
        return getNameOfSweetnessLevel(sweetnessLevel)
    }

    
    class func getLemonadeSweetnessLevel(numLemons: Int, numSugarCubes: Int) -> SweetnessLevel {
        //println("Num Lemons: \(numLemons), Num Sugar Cubes: \(numSugarCubes)")
        if numLemons < 1 || numSugarCubes < 1 {return .Neutral}  // should never happen
        let sweetToTartRatio =  Double(numSugarCubes) / Double(numLemons)
        //println("Sweet-to-Tart Ratio: \(sweetToTartRatio)")
        return getSweetnessLevelFor(sweetToTartRatio)
    }
    
    
    class func getARandomSweetnessPreference() -> SweetnessPreference {
        return randomlyGenerateSweetnessPreference()
    }
    
    class func isLemonadeSuitableForThisSweetnessPreference(sweetnessPreference: SweetnessPreference, lemonadeSweetness: SweetnessLevel) -> Bool {
        let sweetnessPreferenceAsInt = sweetnessPreference.toRaw()
        let lemonadeSweetnessAsInt = lemonadeSweetness.toRaw()
        
        var lemonadeSweetnessAcceptableFrom: Int = lemonadeSweetnessAsInt - 2
        var lemonadeSweetnessAcceptableTo: Int = lemonadeSweetnessAsInt + 2
        
        if lemonadeSweetnessAcceptableFrom < 1  { lemonadeSweetnessAcceptableFrom = 1}
        if lemonadeSweetnessAcceptableTo > 10 { lemonadeSweetnessAcceptableTo = 10 }
        
        for acceptableSweetness in lemonadeSweetnessAcceptableFrom...lemonadeSweetnessAcceptableTo {
            if sweetnessPreferenceAsInt == acceptableSweetness {
                return true
            }
        }
        return false
    }
    
    
    // Helpers
    
    class func getSweetnessLevelFor(sweetToTartRatio: Double) -> SweetnessLevel {
        //println("Sweet-to-Tart Ratio: \(sweetToTartRatio)")
        let kMaxSweetnessLevelValue: Double = 100_000.0
        switch sweetToTartRatio {
        case 7.0...kMaxSweetnessLevelValue:
            return .ExtremelySweet
        case 4.0..<7.0:
            return .VerySweet
        case 2.0..<4.0:
            return .Sweet
        case 1.0..<2.0:
            return .ABitSweet
        case 0.9..<1.0:
            return .Neutral
        case 0.8..<0.9:
            return .ABitTart
        case 0.6..<0.8:
            return .Tart
        case 0.3..<0.6:
            return .VeryTart
        case 0.0..<0.3:
            return .ExtremelyTart
        default:
            return .Neutral
        }
    }
    
    class func randomlyGenerateSweetnessPreference() -> SweetnessPreference {
        let kMaxSweetnessPreferences = 9
        let sweetnessPreference = Int(arc4random_uniform(UInt32(kMaxSweetnessPreferences))) + 1
        switch sweetnessPreference {
        case 1:
            return .ExtremelySweet
        case 2:
            return .VerySweet
        case 3:
            return .Sweet
        case 4:
            return .ABitSweet
        case 5:
            return .Neutral
        case 6:
            return .ABitTart
        case 7:
            return .Tart
        case 8:
            return .VeryTart
        case 9...kMaxSweetnessPreferences:
            return .ExtremelyTart
        default:
            return .Neutral
        }
    }
    
}
