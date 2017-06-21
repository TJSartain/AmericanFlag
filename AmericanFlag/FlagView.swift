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
    
    var oldGloryRed = UIColor()
    var oldGloryBlue = UIColor()
    
    required init!(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
        oldGloryRed  = color(178, 34,  52) // official red of the U.S. flag
        oldGloryBlue = color( 60, 60, 110) // official blue of the U.S. flag
        backgroundColor = UIColor.white // no need to draw the white stripes
    }
    
    override func draw(_ rect: CGRect)
    {
        let A = rect.size.height        // hoist (height)
        let B = rect.size.width         // fly (width) official ratio of the U.S. flag is 1.9
        let L = A / CGFloat(STRIPES)    // height of a stripe
        let C = L * CGFloat(UNION)      // hoist (height) of the canton (union)
        let D = B * 2 / 5               // fly (width) of the canton
        let E = C / 10                  // vertical distance between stars
        let G = D / 12                  // horizontal distance between stars
        let K = L * 4 / 5               // diameter of stars
        
        oldGloryRed.setFill() // draw the red stripes
        drawStripes(B, L)
        
        oldGloryBlue.setFill() // draw the blue canton (union)
        UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: D, height: C)).fill()
        
        UIColor.white.setFill() // stars are white
        drawStarField(E, G, K)
    }
    
    func drawStripes(_ B: CGFloat, _ L: CGFloat)
    {
        var stripeRect = CGRect(x: 0, y: 0, width: B, height: L)
        for _ in stride(from: 0, to: STRIPES, by: 2) {
            UIBezierPath.init(rect: stripeRect).fill()
            stripeRect.origin.y += 2 * L // skip to next stripe
        }
    }
    
    func drawStarField(_ E: CGFloat, _ G: CGFloat, _ K: CGFloat)
    {
        let star = starPath(center: CGPoint(x: G, y: E), radius: K/2) // create one star
        let tab = CGAffineTransform(translationX: 2*G, y: 0) // xform to move to the right
        let cr = CGAffineTransform(translationX: -11*G, y: E) // xform to move down and back
        for r in 0..<9 { // 9 rows
            for _ in 0..<(r%2==0 ? 6 : 5) { // odd rows have 1 less star
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
