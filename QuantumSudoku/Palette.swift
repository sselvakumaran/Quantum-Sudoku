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
    
    static let text = UIColor(named: "TextColor")!
    static let titleLow = UIColor(named: "EntangledPurple")!
    static let titleHigh = UIColor(named: "EntangledGreen")!
    static let selected = UIColor(named: "PrimarySelectedBackground")!
    static let selectedText = UIColor(named: "PrimarySelectedTextColor")!
    static let secondarySelected = UIColor(named: "SecondarySelectedBackground")!
    static let secondaryText = UIColor(named: "SecondarySelectedTextColor")!
    static let background = UIColor(named: "Background")
    
    //    static let homeComponentDims = ["Title1": UIDim2(0,0,0,0.4)
    //
    //    ]
    
    
    //    static func getFrameOfHomeComponent(_ name: String,_ frame:CGRect) {
    //        switch(name) {
    //        case "Title1":
    //            break
    //        default:
    //            break
    //        }
    //    }
    
    
    
    
    
}
