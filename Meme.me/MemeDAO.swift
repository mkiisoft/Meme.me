//
//  MemeDAO.swift
//  Meme.me
//
//  Created by Mariano Zorrilla on 11/1/15.
//  Copyright © 2015 MkiiSoft. All rights reserved.
//

import Foundation
import UIKit

class MemeDAO {
    
    var editTop = ""
    var editBottom = ""
    var image = UIImage()
    var imageMeme = UIImage()
    
    init(editTop: String, editBottom: String, image: UIImage, imageMeme: UIImage) {
        self.editTop = editTop
        self.editBottom = editBottom
        self.image = image
        self.imageMeme = imageMeme
    }
    
    /*
     *
     * @brief save the Meme in Device
     *
     */
    
    func save() {
        MemeDAO.getStorage().memes.append(self)
    }
    
    /*
     *
     * @brief get the storage
     *
     */
    
    class func getStorage() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    
    /*
     *
     * @brief get the total of Meme in Device
     *
     */
    
    class func countAll() -> Int {
        return MemeDAO.getStorage().memes.count
    }
}