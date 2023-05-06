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
    
    static let mainTextFont = "Helvetica"
    static let gridNumberFont = "Menlo"
}
