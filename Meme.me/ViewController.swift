//
//  ViewController.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/23/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lauchLogo: UIImageView!
    @IBOutlet weak var launchSmall: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lauchLogo.transform = CGAffineTransformMakeScale(0.0, 0.0)
        launchSmall.transform = CGAffineTransformMakeScale(0.0, 0.0)
 
        lauchScreenAnimation()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainscreen" {}
    }
    
    func lauchScreenAnimation() {
        
        UIView.animateWithDuration(0.8, delay: 0, options: [.CurveEaseInOut], animations: {
            self.lauchLogo.transform = CGAffineTransformMakeScale(1.2, 1.2)
            
            UIView.animateWithDuration(0, delay: 0.2, options: [], animations: {
                self.launchSmall.transform = CGAffineTransformMakeScale(1.1, 1.1)
                }, completion: nil)
            
            }, completion: {
                (Bool) -> Void in
                
                UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut], animations: {
                    self.lauchLogo.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    UIView.animateWithDuration(0, delay: 0.3, options: [], animations: {
                        self.launchSmall.transform = CGAffineTransformMakeScale(0.8, 0.8)
                        }, completion: nil)
                    
                    }, completion: {
                        (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseInOut], animations: {
                            self.lauchLogo.transform = CGAffineTransformMakeScale(1, 1)
                            UIView.animateWithDuration(0, delay: 0.3, options: [], animations: {
                                self.launchSmall.transform = CGAffineTransformMakeScale(1, 1)
                                }, completion: {
                                    (Bool) -> Void in
                                    UIView.animateWithDuration(0.3, animations: {
                                        self.launchSmall.transform = CGAffineTransformMakeRotation(75)
                                        UIView.animateWithDuration(0.4, delay: 0.8, options: [], animations: {
                                                self.launchSmall.alpha = 0
                                            }, completion: nil)
                                    })
                            })
                            }, completion: {
                                (Bool) -> Void in
                                
                                UIView.animateWithDuration(0.5, delay: 1.5, options: [], animations: {
                                    
                                    self.lauchLogo.transform = CGAffineTransformMakeScale(150, 150)
                                    
                                    }, completion: {
                                        (Bool) -> Void in
                                        self.performSegueWithIdentifier("mainscreen", sender: self)
                                })
                                
                        })
                        
                })
            }
        )
    }
    
}

