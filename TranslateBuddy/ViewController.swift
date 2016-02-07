//
//  ViewController.swift
//  TranslateBuddy
//
//  Created by Kevin Mann on 1/27/16.
//  Copyright © 2016 Freedom Software. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let translator = Translate()

    @IBOutlet weak var sourceLanguageDropdown: NSPopUpButton!
    @IBOutlet weak var destinationLanguageDropdown: NSPopUpButton!
    @IBOutlet weak var inputText: NSTextField!
    @IBOutlet weak var displayTextLabel: NSTextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sourceLanguageDropdown.removeAllItems()
        sourceLanguageDropdown.addItemsWithTitles(["English", "Spanish"])
        destinationLanguageDropdown.removeAllItems()
        destinationLanguageDropdown.addItemsWithTitles(["Spanish", "English"])
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func translate() {
        let text = inputText.stringValue
        let sourceLanguage = sourceLanguageDropdown.selectedItem?.title
        let destinationLanguage = destinationLanguageDropdown.selectedItem?.title
        
        var sourceLanguageCode = ""
        if sourceLanguage == "English" {
            sourceLanguageCode = "en"
        } else {
            sourceLanguageCode = "es"
        }
        
        var destinationLanguageCode = ""
        if destinationLanguage == "English" {
            destinationLanguageCode = "en"
        } else {
            destinationLanguageCode = "es"
        }
        
        translator.translate(text, sourceCode: sourceLanguageCode, destinationCode: destinationLanguageCode) { (res) -> Void in
            print(res)
            self.displayTextLabel.stringValue = res
        }
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 36 {
            translate()
        }
    }

    @IBAction func translateAction(sender: AnyObject) {
        translate()
    }
}

