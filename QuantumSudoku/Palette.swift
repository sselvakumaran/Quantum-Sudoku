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

struct RNG: RandomNumberGenerator {
    init(seed: Int) {
        // Set the random seed
        srand48(seed)
    }
    
    func next() -> UInt64 {
        // drand48() returns a Double, transform to UInt64
        return withUnsafeBytes(of: drand48()) { bytes in
            bytes.load(as: UInt64.self)
        }
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
    
    static let checkValidity = [textSymbolBold, UIColor(named: "ValidCheck")!, UIColor(named: "InvalidCheck")!]
    
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
    
    static var rng: RNG = RNG(seed: Date.now.hashValue)
    
    static func gradientMix(_ set: [Int], _ t: Double) -> UIColor {
        let color1 = gradientColors[set[0]].cgColor.components!
        let color2 = gradientColors[set[1]].cgColor.components!
        return UIColor(red: color1[0] * (1-t) + color2[0] * t,
                       green: color1[1] * (1-t) + color2[1] * t,
                       blue: color1[2] * (1-t) + color2[2] * t,
                       alpha: color1[3] * (1-t) + color2[3] * t)
    }
    static func gradientMix(_ set: [UIColor], _ t: Double) -> UIColor {
        let t2 = t * 0.6
        let color1 = set[0].cgColor.components!
        let color2 = set[1].cgColor.components!
        return UIColor(red: color1[0] * (1-t2) + color2[0] * t2,
                       green: color1[1] * (1-t2) + color2[1] * t2,
                       blue: color1[2] * (1-t2) + color2[2] * t2,
                       alpha: color1[3] * (1-t2) + color2[3] * t2)
    }
    
    static func timeToCosineLerp(_ t: Double) -> Double {
        return 0.5 * (1 + cos(t * Double.pi / gradientPeriod));
    }
    
    static func setRng(seed: Int) {
        rng = RNG(seed: seed)
    }
    
    static func returnWarpGridInit(_ grid_length: Int) -> [SIMD2<Float>] {
        var arr = Array(repeating: SIMD2<Float>(0,0), count: (grid_length + 1) * (grid_length + 1))
        for x in 0..<grid_length + 1 {
            for y in 0..<grid_length + 1 {
                arr[x*grid_length + y] = SIMD2<Float>(Float(x) / Float(grid_length), Float(y) / Float(grid_length))
                print(String(format: "%f, %f ", Float(x) / Float(grid_length), Float(y) / Float(grid_length)))
            }
        }
        return arr
    }

    static func returnRandomWarpGrid(_ grid_length: Int) -> [SIMD2<Float>] {
        var arr = Array(repeating: SIMD2<Float>(0,0), count: (grid_length + 1) * (grid_length + 1))
        let bounds = 0.05 / Float(grid_length)
        for x in 0..<grid_length + 1 {
            for y in 0..<grid_length + 1 {
                let r = Float.random(in: 0..<1, using: &rng) * bounds
                let theta = Float.random(in: 0..<2 * Float.pi, using: &rng)
                arr[x*grid_length + y] = SIMD2<Float>(Float(x) / Float(grid_length),
                                                      Float(y) / Float(grid_length))
            }
        }
        return arr
    }
    
    static let mainTextFont = "Helvetica"
    static let gridNumberFont = "Menlo"
    static let gridNumberBoldFont = "Menlo-Bold"
}
