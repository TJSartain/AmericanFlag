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
        drawFlag(rect)
    }
    
    /// Draws the entire flag based on the official dimensions and colors
    ///
    /// - Parameter rect: the reactangle of this UIView
    
    func drawFlag(_ rect: CGRect)
    {
        let A = rect.size.height        // hoist (height) official ratio of the U.S. flag is 1.9
        let B = rect.size.width         // fly (width)    but we're just fitting it to the screen
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
        
        UIColor.white.setFill() // draw the white stars
        drawStarField(E, G, K)
    }
    
    /// Draws the red stripes only
    ///
    /// - Parameters:
    ///   - B: width
    ///   - L: height
    
    func drawStripes(_ B: CGFloat, _ L: CGFloat)
    {
        var stripeRect = CGRect(x: 0, y: 0, width: B, height: L)
        for _ in stride(from: 0, to: STRIPES, by: 2) {
            UIBezierPath.init(rect: stripeRect).fill()
            stripeRect.origin.y += 2 * L // skip to next stripe
        }
    }
    
    /// Draws the entire star field by creating one star path
    /// and translating it to the other 49 locations
    ///
    /// - Parameters:
    ///   - E: vertical distance between stars
    ///   - G: horizontal distance between stars
    ///   - K: diameter of each star
    
    func drawStarField(_ E: CGFloat, _ G: CGFloat, _ K: CGFloat)
    {
        let star = regularPolygon(sides: 5, center: CGPoint(x: G, y: E), radius: K/2, stride: 2) // create one star
        let tab = CGAffineTransform(translationX: 2*G, y: 0) // xform to move to the right
        let cr = CGAffineTransform(translationX: -11*G, y: E) // xform to move down and back
        for r in 0..<9 { // 9 rows
            for _ in 0..<(r%2==0 ? 6 : 5) { // odd rows have 1 less star
                star.fill()
                star.apply(tab) // next spot over
            }
            star.apply(cr) // next row
        }
    }
    
    /// Creates the Bezier path of a regular N-sided polygon pointing up by default
    ///
    /// - Parameters:
    ///   - sides: number of sides or vertices
    ///   - center: center point
    ///   - radius: distance from center to any vertex
    ///   - start: angle of first vertex (defaults to -π/2)
    ///   - stride: points to skip when connecting the dots
    ///
    /// - Returns: Bezier path
    
    func regularPolygon(sides: Int, center: CGPoint, radius: CGFloat, start: CGFloat? = -CGFloat.pi/2, stride: Int? = 1) -> UIBezierPath
    {
        let delta = 2 * CGFloat.pi / CGFloat(sides) * CGFloat(stride!)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: center.x + CGFloat(cos(start!)) * radius,
                              y: center.y + CGFloat(sin(start!)) * radius))
        for i in 0..<sides {
            let theta = start! + CGFloat(i) * delta
            path.addLine(to: CGPoint(x: center.x + CGFloat(cos(theta)) * radius,
                                     y: center.y + CGFloat(sin(theta)) * radius))
        }
        path.close()
        return path
    }
    
    /// Helper method to create a UIColor, alpha = 1
    ///
    /// - Parameters:
    ///   - r: red component 0-255
    ///   - g: green component 0-255
    ///   - b: blue component 0-255
    ///
    /// - Returns: UIColor
    
    func color(_ r: Float, _ g: Float, _ b: Float) -> UIColor
    {
        return UIColor.init(colorLiteralRed: r/255, green: g/255, blue: b/255, alpha: 1)
    }

}
