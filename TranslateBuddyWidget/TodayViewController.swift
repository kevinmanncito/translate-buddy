//
//  TodayViewController.swift
//  TranslateBuddyWidget
//
//  Created by Kevin Mann on 1/30/16.
//  Copyright © 2016 Freedom Software. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

    let translator = Translate()
    
    @IBOutlet weak var translateTextField: NSTextField!
    @IBOutlet weak var sourceLanguageWidgetDropdown: NSPopUpButton!
    @IBOutlet weak var destinationLanguageWidgetDropdown: NSPopUpButton!
    @IBOutlet weak var translatedTextLabel: NSTextField!

    override var nibName: String? {
        return "TodayViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceLanguageWidgetDropdown.removeAllItems()
        sourceLanguageWidgetDropdown.addItemsWithTitles(["English", "Spanish"])
        destinationLanguageWidgetDropdown.removeAllItems()
        destinationLanguageWidgetDropdown.addItemsWithTitles(["Spanish", "English"])
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.NoData)
    }

    @IBAction func translateButtonAction(sender: AnyObject) {
        let text = translateTextField.stringValue
        let sourceLanguage = sourceLanguageWidgetDropdown.selectedItem?.title
        let destinationLanguage = destinationLanguageWidgetDropdown.selectedItem?.title
        
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
            self.translatedTextLabel.stringValue = res
        }
    }
}
