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
    
    var A: CGFloat = 0 // hoist (height)
    var B: CGFloat = 0 // fly (width) official ratio of the U.S. flag is 1.9
    var L: CGFloat = 0 // height of a stripe
    var C: CGFloat = 0 // hoist (height) of the canton (union)
    var D: CGFloat = 0 // fly (width) of the canton
    var E: CGFloat = 0 // vertical distance between stars
    var G: CGFloat = 0 // horizontal distance between stars
    var K: CGFloat = 0 // diameter of stars
    
    var oldGloryRed = UIColor()
    var oldGloryBlue = UIColor()
    
    var star = UIBezierPath()
    
    required init!(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
        oldGloryRed  = color(178, 34,  52) // official red of the U.S. flag
        oldGloryBlue = color( 60, 60, 110) // official blue of the U.S. flag
        backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect)
    {
        A = rect.size.height // ratio will probably not be the official 1.9
        B = rect.size.width  // but it will fill the screen
        L = A / CGFloat(STRIPES)
        C = L * CGFloat(UNION)
        D = B * 0.4
        E = C / 10
        G = D / 12
        K = L * 0.8
        
        oldGloryRed.setFill()
        var stripeRect = CGRect(x: 0, y: 0, width: B, height: L)
        for _ in stride(from: 0, to: STRIPES, by: 2) {
            UIBezierPath.init(rect: stripeRect).fill()
            stripeRect.origin.y += 2 * L
        }
        
        oldGloryBlue.setFill()
        UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: D, height: C)).fill()
        
        star = starPath(center: CGPoint(x: G, y: E), radius: K/2)
        let tab = CGAffineTransform(translationX: 2*G, y: 0) // move to the right
        var cr = CGAffineTransform(translationX: -12*G, y: 2*E) // move down and all the way back
        UIColor.white.setFill()
        for _ in 0..<5 {
            for _ in 0..<6 {
                star.fill()
                star.apply(tab)
            }
            star.apply(cr)
        }
        star = starPath(center: CGPoint(x: 2*G, y: 2*E), radius: K/2) // different starting opint
        cr = CGAffineTransform(translationX: -10*G, y: 2*E) // moving back but less far
        for _ in 0..<4 {
            for _ in 0..<5 {
                star.fill()
                star.apply(tab)
            }
            star.apply(cr)
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
    
    func color(_ r: Float, _ g: Float, _ b: Float) -> UIColor
    {
        return UIColor.init(colorLiteralRed: r/255, green: g/255, blue: b/255, alpha: 1)
    }

}
