//
//  PassingOptions.swift
//  MicrosoftWord
//
//  Created by HuuLuong on 8/4/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import UIKit

protocol OptionDelegate {
    func setColor(colorName: UIColor)
}

class PassingOptions: UIViewController {
    
    
    @IBOutlet weak var currentSize: UITextField!
    
    @IBOutlet weak var currentFontName: UITextField!
    
    @IBOutlet weak var currentColor: UILabel!
    
    @IBOutlet weak var currentAlign: UILabel!
    
    var delegate: OptionDelegate! = nil
    var colorLabelText: String! = nil
    var option: OptionFont!
    var completion: ((para1: String, para2: String) -> (Void))?
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        currentFontName.text = option.fontName
        currentSize.text = String(option.size!)
        currentColor.backgroundColor = option.color
        var align = ""
        switch(option.alignment) {
        case 0: align = "Lef"
        case 1: align = "Cen"
        case 2: align = "Rig"
        default: break;
        }
        currentAlign.text = align
    }
    
    override func viewWillDisappear(animated: Bool) {
        //using singleton
        let option = OptionFont.sharedInstance
        option.size = Int(currentSize.text!)
        option.fontName = currentFontName.text
        self.completion!(para1:"1", para2: "2")
        
        
    }
    
    //using delegate 
    
    @IBAction func action_selectColor(sender: UIButton) {
        if let color = sender.backgroundColor {
            currentColor.backgroundColor = color
            delegate.setColor(color)
        }
    }
    
    //using notificationCenter
    @IBAction func action_selectAlignment(sender: UIButton) {
        let dic: NSDictionary = ["Align": sender.tag - 100]
        
        NSNotificationCenter.defaultCenter().postNotificationName("Alignment", object: nil, userInfo: dic as [NSObject : AnyObject])
        
        var align = ""
        switch sender.tag {
        case 100: align = "Lef"
        case 101: align = "Cen"
        case 102: align = "Rig"
        default:
            break;
        }
        currentAlign.text = align
    }
    
    //using Block
    func setStyle(completion: ((para1: String, para2: String) -> Void)?) {
        print("action")
        self.completion = completion
    }
    
    @IBAction func action_selectStyle(sender: UIButton) {
        let dic: NSDictionary = ["Style": sender.tag - 200]
        
        NSNotificationCenter.defaultCenter().postNotificationName("Style", object: nil, userInfo: dic as [NSObject : AnyObject])
        
    }
    
    
    
}
