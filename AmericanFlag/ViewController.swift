//
//  ViewController.swift
//  AmericanFlag
//
//  Created by TJ Sartain on 6/16/17.
//  Copyright © 2017 iTrinity Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var infoButton: UIButton!
    
    @IBAction func tap(_ sender: Any)
    {
        fadeButton(show: self.infoButton.alpha == 0)
    }
    
    func fadeButton(show: Bool)
    {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseIn],
                       animations:
                        {
                            self.infoButton.alpha = show ? 1 : 0
                        },
                       completion: nil)
    }

}

