//
//  ViewController.swift
//  MicrosoftWord
//
//  Created by HuuLuong on 8/4/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import UIKit


class ViewController: UIViewController, OptionDelegate {

    
    @IBOutlet weak var txt_View: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 66/255, green: 133/255, blue: 244/255, alpha: 1)
        txt_View.textColor = UIColor.blackColor()
        
        
 //     txt_View.font = UIFont.italicSystemFontOfSize((txt_View.font?.pointSize)!)
        
        txt_View.allowsEditingTextAttributes = true
        
        let mutableAttributeString = NSMutableAttributedString.init(string: txt_View.text)
        
        let value = NSNumber.init(integer: 1)
        
        let range = NSRange(location: 0, length: mutableAttributeString.length)
        
        mutableAttributeString.addAttribute(kCTUnderlineStyleAttributeName as String, value: value, range:range )
        
        txt_View.attributedText = mutableAttributeString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setColor(color: UIColor) {
        txt_View.textColor = color
    }
    
    func alignment(notification: NSNotification) {
        //notification.userInfo 
        if let info = notification.userInfo as? Dictionary<String,Int> {
            if let value = info["Align"] {
                txt_View.textAlignment = NSTextAlignment(rawValue: value)!
                
                print(value)
            } else {
                print("no valuefor key\n")
            }
        }
    }
    
    func style(notification: NSNotification){
        if let info = notification.userInfo as? Dictionary<String,Int> {
            if let value = info["Style"] {
                switch value {
                case 0: txt_View.font = UIFont.boldSystemFontOfSize((txt_View.font?.pointSize)!); print(value); break;
                case 1: txt_View.font = UIFont.italicSystemFontOfSize((txt_View.font?.pointSize)!); print(value); break;
                //case 2:
                default: break;
                    
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //using singleton
        let option = OptionFont.sharedInstance
        if let size = option.size {
            if let name = option.fontName {
                txt_View.font = UIFont(name: name, size: CGFloat(size))
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Options") {
            let destination = segue.destinationViewController as! PassingOptions
            //using strong counpling
            destination.option = OptionFont(size: Int((txt_View.font?.pointSize)!), fontName: (txt_View.font?.fontName)!, color: txt_View.textColor!, alignment: txt_View.textAlignment.rawValue)
            
            //using delegate
            destination.delegate = self
            
            //using NotificationCenter
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.alignment(_:)), name: "Alignment", object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.style(_:)), name: "Style", object: nil)
            
            //using Block
            destination.setStyle({ (para1, para2) -> Void in
                print("p1:\(para1) p2:\(para2)")
            })
            
        } else {
            print("Unknown segue")
        }
    }

}

