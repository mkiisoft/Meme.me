//
//  ViewController.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/23/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var lauchLogo: UIImageView!
    @IBOutlet weak var launchSmall: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lauchLogo.transform = CGAffineTransformMakeScale(0.0, 0.0)
        launchSmall.transform = CGAffineTransformMakeScale(0.0, 0.0)
 
        lauchScreenAnimation([lauchLogo, launchSmall], delay: [0, 0.3])
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainscreen" {}
    }
    
    func lauchScreenAnimation(image: [UIImageView], delay: [NSTimeInterval]) {
        for i in 0...image.count - 1 {
            UIView.animateWithDuration(1.2,
                delay: delay[i],
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 10.0,
                options: .CurveLinear,
                animations: {
                    image[i].transform = CGAffineTransformMakeScale(1, 1)
                    self.view.layoutIfNeeded()
                }, completion: nil)
        }
        
        UIView.animateWithDuration(0.3, delay: 2.0, options: [], animations: {
            self.launchSmall.transform = CGAffineTransformMakeRotation(75)
            }, completion: {
                (Bool) -> Void in
                UIView.animateWithDuration(0.4, animations: {
                    self.launchSmall.alpha = 0
                    }, completion: {
                        (Bool) -> Void in
                        UIView.animateWithDuration(0.5, animations: {
                            self.lauchLogo.transform = CGAffineTransformMakeScale(150, 150)
                            }, completion: {
                                (Bool) -> Void in
                                self.performSegueWithIdentifier("versionselect", sender: self)
                        })
                        
                })
                
        })
    }
    
}

