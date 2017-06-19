//
//  InfoViewController.swift
//  AmericanFlag
//
//  Created by TJ Sartain on 6/17/17.
//  Copyright © 2017 iTrinity Inc. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController
{
    @IBOutlet weak var hoistButton: UIButton!
    
    override func viewDidLoad()
    {
        let oldGloryRed  = color(178, 34,  52) // official red of the U.S. flag
        let oldGloryBlue = color( 60, 60, 110) // official blue of the U.S. flag
        hoistButton.clipsToBounds = true
        hoistButton.layer.borderColor = oldGloryRed.cgColor
        hoistButton.layer.borderWidth = 2
        hoistButton.layer.cornerRadius = 7
        let bgImage = imageFromColor(color: oldGloryBlue)
        hoistButton.setBackgroundImage(bgImage, for: .normal)
       // let highlightedImage = imageFromColor(color: oldGloryRed)
       // hoistButton.setBackgroundImage(highlightedImage, for: .highlighted)
        hoistButton.setTitleColor(UIColor.white, for: .normal)
        hoistButton.titleLabel?.font = UIFont(name: "Helvetica-Neue", size: 15)
    }
    
    func color(_ r: Float, _ g: Float, _ b: Float) -> UIColor
    {
        return UIColor.init(colorLiteralRed: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    func imageFromColor(color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext as! CGContext
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
