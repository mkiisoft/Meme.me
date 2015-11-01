//
//  ViewController.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/23/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var launchLogo: UIImageView!
    @IBOutlet weak var launchSmall: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchLogo.transform = CGAffineTransformMakeScale(0.0, 0.0)
        launchSmall.transform = CGAffineTransformMakeScale(0.0, 0.0)
 
        lauchScreenAnimation([launchLogo, launchSmall], delay: [0, 0.3])
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainscreen" {}
    }
    
    func lauchScreenAnimation(image: [UIImageView], delay: [NSTimeInterval]) {
        for i in 0...image.count - 1 {
            UIView.animateWithDuration(1.2,
                delay: delay[i],
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 5.0,
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
                UIView.animateWithDuration(0.3, delay: 0.6, options: [], animations: {
                    self.launchSmall.alpha = 0
                    }, completion: {
                        (Bool) -> Void in
                        UIView.animateWithDuration(0.5, delay: 0.2, options: [.CurveEaseIn], animations: {
                            self.launchLogo.transform = CGAffineTransformMakeScale(150, 150)
                            }, completion: {
                                (Bool) -> Void in
                                self.performSegueWithIdentifier("versionselect", sender: self)
                        })
                        
                })
                
        })
    }
    
}

