//
//  CustomSegue.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/23/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let sourceVC = self.sourceViewController
        let destinationVC = self.destinationViewController
        
        destinationVC.view.alpha = 0
        
        sourceVC.view.addSubview(destinationVC.view)
        
        UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            
            destinationVC.view.alpha = 1
            
            }) { (finished) -> Void in
                
                destinationVC.view.removeFromSuperview()
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.001 * Double(NSEC_PER_SEC)))
                
                dispatch_after(time, dispatch_get_main_queue()) {
                    
                    sourceVC.presentViewController(destinationVC, animated: false, completion: nil)
                    
                }
        }
    }
}
