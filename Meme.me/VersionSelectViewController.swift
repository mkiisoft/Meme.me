//
//  VersionSelectViewController.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/29/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import UIKit

class VersionSelectViewController: UIViewController {
    
    @IBOutlet weak var versionTitle: UILabel!

    @IBOutlet weak var versionOneText: UILabel!
    @IBOutlet weak var versionOne: UIButton!
    @IBOutlet weak var versionOneWidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var versionTwo: UIButton!
    @IBOutlet weak var versionTwoText: UILabel!
    @IBOutlet weak var versionTwoWidth: NSLayoutConstraint!
    
    var didFinish = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonStyle([versionOne, versionTwo])
        
        versionTitle.alpha = 0; versionOne.alpha = 0; versionTwo.alpha = 0;
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.4, animations: {
            self.versionTitle.alpha = 1
        })
        
        initButtonAnimation(versionOne, text: versionOneText, width: versionOneWidth, delay: 0.3, delaytwo: 0)
        initButtonAnimation(versionTwo, text: versionTwoText, width: versionTwoWidth, delay: 0.8, delaytwo: 0.3)
    }
    
    @IBAction func versionOneSelect(sender: AnyObject) {
        initVersionSelect(versionOne, buttontwo: versionTwo, text: versionOneText, texttwo: versionTwoText, width: versionOneWidth, segue: "versionone", color: false)
    }
    
    @IBAction func versionTwoSelect(sender: AnyObject) {
        initVersionSelect(versionTwo, buttontwo: versionOne, text: versionTwoText, texttwo: versionOneText, width: versionTwoWidth, segue: "versiontwo", color: true)
    }
    
    /*
    *
    * @brief Setting the default button style
    *
    */
    
    func setButtonStyle(button: [UIButton]){
        
        for i in 0...button.count - 1 {
            button[i].transform = CGAffineTransformMakeScale(0,0)
            button[i].backgroundColor = UIColor.clearColor()
            button[i].layer.cornerRadius = 22
            button[i].layer.borderWidth = 2.5
            button[i].layer.borderColor = UIColor.whiteColor().CGColor
        }
        
    }
    
    /*
    *
    * @brief Setting the animation when the buttons appear
    *
    */
    
    func initButtonAnimation(button: UIButton, text: UILabel, width: NSLayoutConstraint, delay: NSTimeInterval, delaytwo: NSTimeInterval) {
        UIView.animateWithDuration(0.4, delay: delay, options: [.CurveEaseInOut], animations: {
            button.alpha = 1
            button.transform = CGAffineTransformMakeScale(1,1)
            }, completion: {
                (Bool) -> Void in
                self.didFinish = true
        })
        
        if didFinish == true {
            width.constant = +240
            UIView.animateWithDuration(0.4, delay: delaytwo, options: [.CurveEaseIn], animations: {
                self.view.layoutIfNeeded()
                }, completion: {
                    (Bool) -> Void in
                    text.alpha = 0
                    text.hidden = false
                    
                    UIView.animateWithDuration(0.5, animations: {
                        text.alpha = 1
                    })
            })
        }
    }
    
    /*
    *
    * @brief Button selection animation
    *
    */
    
    func initVersionSelect(button: UIButton, buttontwo: UIButton, text: UILabel, texttwo: UILabel, width:
        NSLayoutConstraint, segue: String, color: Bool) {
            
            let colors: CGColor
        
            if color == true {
                colors = UIColor(red: 159.0/255, green: 0.0/255, blue: 187.0/255, alpha: 1.0).CGColor
            }else {
                colors = UIColor.whiteColor().CGColor
            }
        
            
            width.constant = +44
            UIView.animateWithDuration(0.4, delay: 0, options: [.CurveEaseIn], animations: {
                self.view.layoutIfNeeded()
                buttontwo.alpha = 0; texttwo.alpha = 0; self.versionTitle.alpha = 0; text.alpha = 0
                button.layer.backgroundColor = UIColor.whiteColor().CGColor
                }, completion: {
                    (Bool) -> Void in
                    UIView.animateWithDuration(0.5, delay: 0.2, options: [.CurveEaseInOut], animations: {
                        button.transform = CGAffineTransformMakeScale(150, 150)
                        button.layer.backgroundColor = colors
                        }, completion: {
                            (Bool) -> Void in
                            self.performSegueWithIdentifier(segue, sender: self)
                            self.normalState()
                })
        })
    }
    
    func normalState() {
        
        UIView.animateWithDuration(1, delay: 1, options: [], animations: {
            self.setButtonStyle([self.versionOne, self.versionTwo])
            self.versionTitle.alpha = 0; self.versionOne.alpha = 0; self.versionTwo.alpha = 0;
            }, completion: nil)

    }
    
}
