//
//  FirstVersionViewController.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/30/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import UIKit

class FirstVersionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func returnVersion(sender: AnyObject) {
        let transition = CATransition()
        transition.duration = 0.3;
        transition.type = kCATransitionFade;
        self.view.window!.layer.addAnimation(transition, forKey: kCATransition)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}
