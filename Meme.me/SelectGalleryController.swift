//
//  SelectGalleryViewController.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/24/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//
//  Part of Version 2.0
//

import UIKit

class SelectGalleryController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func selectBack(sender: UIButton) {
        self.performSegueWithIdentifier("returntohome", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "returntohome" {}
    }
}
