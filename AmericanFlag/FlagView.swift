//
//  FlagView.swift
//  AmericanFlag
//
//  Created by TJ Sartain on 6/16/17.
//  Copyright © 2017 iTrinity Inc. All rights reserved.
//

import UIKit

class FlagView: UIView
{
    let STRIPES = 13
    let UNION = 7 // stripes in the union height
    
    var A: CGFloat = 0 // height
    var B: CGFloat = 0 // official ratio of the U.S. flag is 1.9
    var L: CGFloat = 0 // height of a stripe
    var C: CGFloat = 0 // height of the union
    var D: CGFloat = 0 // width of the union
    var E: CGFloat = 0 // vertical distance between stars
    var G: CGFloat = 0 // horizontal distance between stars
    var K: CGFloat = 0 // diameter of stars
    
    var oldGloryRed = UIColor()
    var oldGloryBlue = UIColor()
    
    required init!(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
        oldGloryRed  = color(r: 178, g: 34, b:  52) // official red of the U.S. flag
        oldGloryBlue = color(r:  60, g: 60, b: 110) // official blue of the U.S. flag
        backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect)
    {
        A = rect.size.height // ratio will probably be incorrect
        B = rect.size.width  // but this will fill the screen
        L = A / CGFloat(STRIPES)
        C = L * CGFloat(UNION)
        D = B * 0.4
        E = C / 10
        G = D / 12
        K = A * 0.0616
        
        oldGloryRed.setFill()
        var stripeRect = CGRect(x: 0, y: 0, width: B, height: L)
        for _ in stride(from: 0, to: STRIPES, by: 2) {
            UIBezierPath.init(rect: stripeRect).fill()
            stripeRect.origin.y += 2 * L
        }
        
        oldGloryBlue.setFill()
        UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: D, height: C)).fill()
        
        UIColor.white.setFill()
        for r in 0..<5 {
            for c in 0..<6 {
                let center = CGPoint(x: G * (2 * CGFloat(c) + 1), y: E * (2 * CGFloat(r) + 1))
                starPath(center: center, radius: K / 2).fill()
            }
        }
        for r in 0..<4 {
            for c in 0..<5 {
                let center = CGPoint(x: 2 * G * (CGFloat(c) + 1), y: 2 * E * (CGFloat(r) + 1))
                starPath(center: center, radius: K / 2).fill()
            }
        }
    }
    
    func starPath(center: CGPoint, radius: CGFloat) -> UIBezierPath
    {
        let angleDiff = 4 * CGFloat(Float.pi) / 5
        let path = UIBezierPath()
        path.move(to: CGPoint(x: center.x + CGFloat(cos(-Float.pi/2)) * radius,
                              y: center.y + CGFloat(sin(-Float.pi/2)) * radius))
        for i in 0..<5 {
            let theta = CGFloat(i) * angleDiff - CGFloat(Float.pi/2)
            path.addLine(to: CGPoint(x: center.x + CGFloat(cos(theta)) * radius,
                                     y: center.y + CGFloat(sin(theta)) * radius))
        }
        return path
    }
    
    func color(r: Float, g: Float, b: Float) -> UIColor
    {
        return UIColor.init(colorLiteralRed: r/255, green: g/255, blue: b/255, alpha: 1)
    }

}
