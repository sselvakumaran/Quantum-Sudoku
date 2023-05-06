//
//  Palette.swift
//  QuantumSudoku
//
//  Created by Sriman Selvakumaran on 4/24/23.
//

import UIKit

struct UIDim2 {
    var xOffset: Double
    var yOffset: Double
    var xScale: Double
    var yScale: Double
    
    init (_ xOff:Double, _ yOff:Double, _ xScl:Double, _ yScl:Double){
        xOffset = xOff; yOffset = yOff; xScale = xScl; yScale = yScl
    }
}

class Palette {
    
    static let backgroundFrame = UIColor(named: "BackgroundFrame")!
    static let backgroundNormal = UIColor(named: "BackgroundNormal")!
    static let backgroundPrimary = UIColor(named: "BackgroundPrimary")!
    static let backgroundSecondary = UIColor(named: "BackgroundSecondary")!
    static let backgroundTertiary = UIColor(named: "BackgroundTertiary")!
    
    static let textSymbolBold = UIColor(named: "TextSymbolBold")!
    static let textSymbolLight = UIColor(named: "TextSymbolLight")!
    static let textSymbolNormal = UIColor(named: "TextSymbolNormal")!
    
    static let gridStrongLine = UIColor(named: "GridStrongLine")!
    static let gridWeakLine = UIColor(named: "GridWeakLine")!
    
    static let gradientColors = [UIColor(named: "GradientPink")!,
                                 UIColor(named: "GradientHotPink")!,
                                 UIColor(named: "GradientOrange")!,
                                 UIColor(named: "GradientYellow")!,
                                 UIColor(named: "GradientGreen")!,
                                 UIColor(named: "GradientPurple")!]
    
    static let gradientSets = [[0,1], [0,2], [0,3], [0,4], [0,5],
                               [1,2], [1,3], [1,4], [1,5],
                               [2,3], [2,4], [2,5],
                               [3,4], [3,5],
                               [4,5]]
    
    static let gradientPeriod = 0.5
    
    static func gradientMix(_ set: [Int], _ t: Double) -> UIColor {
        let color1 = gradientColors[set[0]].cgColor.components!
        let color2 = gradientColors[set[1]].cgColor.components!
        return UIColor(red: color1[0] * (1-t) + color2[0] * t,
                       green: color1[1] * (1-t) + color2[1] * t,
                       blue: color1[2] * (1-t) + color2[2] * t,
                       alpha: color1[3] * (1-t) + color2[3] * t)
    }
    static func gradientMix(_ set: [UIColor], _ t: Double) -> UIColor {
        let color1 = set[0].cgColor.components!
        let color2 = set[1].cgColor.components!
        print(color1)
        print(color2)
        return UIColor(red: color1[0] * (1-t) + color2[0] * t,
                       green: color1[1] * (1-t) + color2[1] * t,
                       blue: color1[2] * (1-t) + color2[2] * t,
                       alpha: color1[3] * (1-t) + color2[3] * t)
    }
    
    static func timeToCosineLerp(_ t: Double) -> Double{
        return 0.5 * (1 + cos(t * Double.pi / gradientPeriod));
    }
    
    static let mainTextFont = "Helvetica"
    static let gridNumberFont = "Menlo"
}
