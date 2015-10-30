//
//  MainViewController.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/23/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var titleButton: UIButton!

    @IBOutlet weak var pickFromGallery: UILabel!
    @IBOutlet weak var pickFromCamera: UILabel!
    @IBOutlet weak var pickFromInternet: UILabel!
    @IBOutlet weak var pickFromArchive: UILabel!
    
    @IBOutlet weak var fromGallery: UIStackView!
    @IBOutlet weak var fromCamera: UIStackView!
    @IBOutlet weak var fromInternet: UIStackView!
    @IBOutlet weak var fromArchive: UIStackView!
    
    @IBOutlet weak var imageGallery: UIImageView!
    @IBOutlet weak var imageCamera: UIImageView!
    @IBOutlet weak var imageInternet: UIImageView!
    @IBOutlet weak var imageArchive: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    var imagePickerBool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableSender(imageGallery, target:"imageTappedGallery:")
        enableSender(imageCamera, target: "imageTappedCamera:")
        
        changeFont(["GALLERY", "CAMERA", "INTERNET", "ARCHIVE"], length: [7,6,8,7], label: [pickFromGallery, pickFromCamera, pickFromInternet, pickFromArchive], font: "monofur", size: 18)

    }
    
    override func viewWillAppear(animated: Bool) {
        
        initViewAlpha([fromGallery, fromCamera, fromInternet, fromArchive], alpha: 0)
        
        startAnimation([self.fromGallery, self.fromCamera, self.fromInternet, self.fromArchive], duration: 1.0, delay: [1, 1.2, 1.4, 1.6])
        
        if imagePickerBool == true {
            resetImageState(imageGallery, imageset: "From Gallery", label: pickFromGallery)
        }
    }
    
    /*!
    *
    *  @brief Enable user interaction and sender
    *
    */
    
    func enableSender(imgbutton: UIImageView, target: String) {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector(target))
        imgbutton.userInteractionEnabled = true
        imgbutton.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    /*!
    *
    *  @brief Change font in array with attributes
    *
    */
    
    func changeFont(title: [String], length: [Int], label: [UILabel], font: String, size: CGFloat) {
        for i in 0...title.count - 1 {
            
            let attGallery = attributesToFonts(title[i], length: length[i])
            
            label[i].attributedText = attGallery
            label[i].font = UIFont(name: font, size: size)
        }
    }
    
    /*!
    *
    *  @brief Open sender Activity View
    *
    */
    
    func imageTappedCamera(img: AnyObject) {
        
    }
    
    /*!
    *
    *  @brief Perform the Animation and Open Gallery
    *
    */
    
    func imageTappedGallery(img: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseIn], animations: {
            self.imageGallery.image = UIImage(named: "From Gallery")!.imageWithRenderingMode(.AlwaysTemplate)
            self.imageGallery.tintColor = UIColor.whiteColor()
            self.pickFromGallery.alpha = 0; self.initViewAlpha([self.fromCamera, self.fromInternet, self.fromArchive], alpha: 0); self.titleButton.alpha = 0
            }, completion: {
                (Bool) -> Void in
                UIView.animateWithDuration(0.5, delay: 0.2, options: [.CurveEaseIn], animations: {
                        self.imageGallery.transform = CGAffineTransformMakeScale(150, 150)
                    }
                    , completion: {
                        (Bool) -> Void in
                        self.imagePicker.delegate = self
                        self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                        self.presentViewController(self.imagePicker, animated: true, completion: nil)
                        self.imagePickerBool = true
                        
                        self.resetAnimation([self.fromGallery, self.fromCamera, self.fromInternet, self.fromArchive])
                })
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*!
    *
    *  @brief Set attributes to fonts and/or custom fonts
    *
    */
    
    func attributesToFonts(title: String, length: Int) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(0.5), range: NSRange(location: 0, length: length))
        
        return attributedString
    }
    
    /*!
    *
    *  @brief Set array of outlets with an alpha
    *
    */
    
    func initViewAlpha(stack: [UIStackView], alpha: CGFloat) {
        for i in 0...stack.count - 1 {
            stack[i].alpha = alpha
        }
    }
    
    /*!
    *
    *  @brief Init array stack animation
    *
    */
    
    func startAnimation(stack: [UIStackView], duration: NSTimeInterval, delay: [NSTimeInterval]) {
        for i in 0...stack.count - 1 {
            UIView.animateWithDuration(duration, delay: delay[i], usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.CurveEaseIn, .AllowUserInteraction], animations: {
                    self.titleButton.alpha = 1
                    stack[i].center.y = stack[i].frame.origin.y + 90
                    stack[i].alpha = 1
                }, completion: nil)
        }
    }
    
    /*!
    *
    *  @brief Reset location state after picking or cancel image
    *
    */
    
    func resetAnimation(stack: [UIStackView]) {
        UIView.animateWithDuration(0, animations: {
            for i in 0...stack.count - 1 {
                stack[i].center.y = stack[i].frame.origin.y + 55
            }
            
            }
        )
    }
    
    /*!
    *
    *  @brief Reset image state after touching and launching new segue/action
    *
    */
    
    func resetImageState(image: UIImageView, imageset: String, label: UILabel){
        image.transform = CGAffineTransformMakeScale(1, 1)
        image.tintColor = UIColor.clearColor()
        image.image = UIImage(named: imageset)
        label.alpha = 1
    }
    
    @IBAction func comeBack(sender: AnyObject) {
       self.dismissViewControllerAnimated(false, completion: nil)
    }
}
