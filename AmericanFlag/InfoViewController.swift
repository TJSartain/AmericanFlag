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
        hoistButton.layer.borderWidth = 0.5
        hoistButton.layer.cornerRadius = 5
        let bgImage = imageFromColor(color: oldGloryBlue)
        hoistButton.setBackgroundImage(bgImage, for: .normal)
        let highlightedImage = imageFromColor(color: oldGloryRed)
        hoistButton.setBackgroundImage(highlightedImage, for: .highlighted)
        hoistButton.backgroundColor = oldGloryBlue
        hoistButton.setTitleColor(UIColor.white, for: .normal)
        hoistButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
    }
    
    func color(_ r: Float, _ g: Float, _ b: Float) -> UIColor
    {
        return UIColor.init(colorLiteralRed: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    func imageFromColor(color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: 50, height: 31)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
