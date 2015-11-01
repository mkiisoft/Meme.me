//
//  FirstVersionViewController.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 10/30/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import UIKit

class FirstVersionViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var editTextTop: UITextField!
    @IBOutlet weak var editTextBottom: UITextField!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    
    @IBOutlet weak var imageMeme: UIImageView!
    
    @IBOutlet weak var aspectSelector: UISwitch!
    
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var galleryY: NSLayoutConstraint!
    @IBOutlet weak var cameraY: NSLayoutConstraint!
    
    @IBOutlet weak var toggleStack: UIStackView!
    
    @IBOutlet weak var titleButton: UIButton!
    let imagePicker = UIImagePickerController()
    
    var kbHeight: CGFloat!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let aspectWide:CGFloat = 1.33
    let aspectSquare:CGFloat = 1
    
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
    
    var finishAnimation = false
    var didSelectImage  = false
    
    /*
    *
    *   @brief  Attributes to style the TextFields
    *
    */
    
    let textAttributes = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName: UIFont(name: "Impact", size: 43)!,
        NSStrokeWidthAttributeName: -4.0
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initImageAspectRatio()
        aspectSelector.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        initTextFields([editTextTop, editTextBottom])
        
        isCameraAvailable()
        
        titleButton.hidden = false
        toggleStack.hidden = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.initButtonAnimation([self.galleryY, self.cameraY], delay: [0.0, 0.4])
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        if finishAnimation == true {
            UIView.animateWithDuration(0.1, animations: {
                self.galleryY.constant = +20
                self.cameraY.constant = +20
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    @IBAction func returnVersion(sender: AnyObject) {
        let transition = CATransition()
        transition.duration = 0.3;
        transition.type = kCATransitionFade;
        self.view.window!.layer.addAnimation(transition, forKey: kCATransition)
        self.dismissViewControllerAnimated(false,
        completion: nil)
    }
    
    @IBAction func selectGallery(sender: AnyObject) {
        
        if galleryButton.currentImage == UIImage(named: "From Gallery") {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            let image = generateMemeImage()
            let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            presentViewController(activity, animated: true, completion: {
                () -> Void in
                
                self.resetVisual()
                self.setButtonImage([self.galleryButton, self.cameraButton], source: ["From Gallery", "From Camera"])
            })
        }
        
    }
    
    @IBAction func selectCamera(sender: AnyObject) {
        if cameraButton.currentImage == UIImage(named: "From Camera") {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        } else {
            
            resetVisual()
            
            self.galleryY.constant = -80
            self.cameraY.constant = -80
            
            UIView.animateWithDuration(0.3, animations: {
                self.view.layoutIfNeeded()
                }, completion: {
                    (Bool) -> Void in
                    
                    self.setButtonImage([self.galleryButton, self.cameraButton], source: ["From Gallery", "From Camera"])
                    
                    self.isCameraAvailable()

                    self.galleryY.constant = +20
                    self.cameraY.constant = +20
                    
                    UIView.animateWithDuration(0.3, animations: {
                        self.view.layoutIfNeeded()
                    })
            })
            
        }
    }
    
    /*
    *
    *   @brief  init the Async Bounce Animation
    *
    */
    
    func initButtonAnimation(button: [NSLayoutConstraint], delay: [NSTimeInterval]){
        for i in 0...button.count - 1 {
            button[i].constant = +20
            UIView.animateWithDuration(0.8,
                delay: delay[i],
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 10.0,
                options: .CurveLinear,
                animations: {
                    self.view.layoutIfNeeded()
                }, completion: {
                    (Bool) -> Void in
                    self.finishAnimation = true
            })
        }
    }
    
    /*
    *
    *   @brief  Reset all the Visual to init state
    *
    */
    
    func resetVisual(){
        editTextTop.text = ""
        editTextBottom.text = ""
        
        imageMeme.image = UIImage(named: "Select")
        
        didSelectImage = false
        
        toggleStack.hidden = true
        titleButton.hidden = false
        
    }
    
    /*
    *
    *   @brief  Check if Device has a Camera or not
    *
    */
    
    func isCameraAvailable() {
        if cameraButton.currentImage == UIImage(named: "From Camera") {
            cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        } else {
            cameraButton.enabled = true
        }
    }
    
    /*
    *
    *   @brief  KeyBoard will only push the view if
    *           bottom TextField is getting editing
    *
    */
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                if editTextBottom.editing {
                    self.view.frame.origin.y -= getKeyboardHeight(notification)
                }
            }
        }
    }
    
    /*
    *
    *   @brief  KeyBoard will hide and the view will
    *           return to previous state if 
    *           bottom TextField is getting editing
    *
    */
    
    func keyboardWillHide(notification: NSNotification) {
        if editTextBottom.editing {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    /*
    *
    *   @brief  Getting the KeyBoard Height
    *
    */
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    /*
    *
    *   @brief  Generating the final UIImage to share it
    *           This will give you a perfect crop of it
    *
    */
    
    func generateMemeImage() -> UIImage {
        
        UIGraphicsBeginImageContext(imageMeme.frame.size)
        view.drawViewHierarchyInRect(CGRectMake(view.frame.origin.x, -imageMeme.frame.origin.y, view.frame.size.width, view.frame.size.height), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /*
    *
    *   @brief  Styling the TextFields
    *
    */
    
    func initTextFields(textField: [UITextField]) {
        for i in 0...textField.count - 1 {
            textField[i].hidden = true
            textField[i].delegate = self
            textField[i].defaultTextAttributes = textAttributes
            textField[i].textAlignment = .Center
        }
    }
    
    /*
    *
    *   @brief  Will dismiss the keyboard when hit return
    *
    */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    /*
    *
    *   @brief  clear text to start editing
    *           disable Buttons till finish editing
    *
    */
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        galleryButton.enabled = false
        cameraButton.enabled = false
    }
    
    /*
    *
    *   @brief  if TextFields are empty, return state text
    *           enable Buttons after finishing editing
    *
    */
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if editTextTop.text == "" {
            editTextTop.text = "TOP"
        } else if editTextBottom.text == "" {
            editTextBottom.text = "BOTTOM"
        }
        
        galleryButton.enabled = true
        cameraButton.enabled = true
        
        return true
    }
    
    /*
    *
    *   @brief  func to quick change image from UIButton
    *
    */
    
    func setButtonImage(image: [UIButton], source: [String]) {
        for i in 0...image.count - 1 {
            image[i].setImage(UIImage(named: source[i]), forState: UIControlState.Normal)
        }
    }
    
    /*
     *
     *  @brief  Switch + Aspect Ratio selector
     *
     *          if switch.on  the image will be 4:3
     *          if switch.off the image will be 1:1
     *
     */
    
    func stateChanged(switchState: UISwitch) {
        
        if switchState.on {
            aspectRatio(aspectWide)
        } else {
            aspectRatio(aspectSquare)
        }
    }
    
    /*
     *  @brief  changing aspect ratio. Gets screen size
     *          values to know the height and width
     *
     */
    
    func aspectRatio(aspect: CGFloat) {
        height.constant = screenSize.width / aspect
        width.constant  = screenSize.width
    }
    
    /*
     *
     *  @brief  init the app with an specific Aspect Ratio
     *
     */
    
    func initImageAspectRatio() {
        height.constant = screenSize.width
        width.constant  = screenSize.width
    }
    
    
    /*
     *
     *  @brief  Setting the picked image to the UIImageView, also, checking the
     *          swift Aspect Ratio
     *
     */
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        imageMeme.image = image
        stateChanged(aspectSelector)
        
        editTextTop.hidden = false; editTextBottom.hidden = false
        editTextTop.text = "TOP"; editTextBottom.text = "BOTTOM"
        titleButton.hidden = true
        
        setButtonImage([galleryButton, cameraButton], source: ["Share", "Cancel"])
        
        self.isCameraAvailable()
        
        if didSelectImage == false {
            toggleStack.hidden = false
            didSelectImage = true
        }
    }
}
