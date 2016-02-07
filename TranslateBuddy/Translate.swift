//
//  Translate.swift
//  TranslateBuddy
//
//  Created by Kevin Mann on 1/27/16.
//  Copyright © 2016 Freedom Software. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class Translate {
    let clientId = "translate-buddy"
    let clientSecret = "CxUU4M+Qi1DoQDKC4oy9+KQPiN1kolH57qAQUfycKrA="
    let translatorAccessUri = "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13"
    let translateUri = "http://api.microsofttranslator.com/v2/Http.svc/Translate"
    let scope = "http://api.microsofttranslator.com"
    let accessHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
    var translateHeaders = ["Authorization": ""]
    
    
    func translate(translateString: String, sourceCode: String, destinationCode: String, completion: (String) -> Void) {
        
        let data = [
            "client_id": clientId,
            "client_secret": clientSecret,
            "scope": scope,
            "grant_type": "client_credentials"
        ]
        Alamofire.request(.POST, translatorAccessUri, parameters: data, headers: accessHeaders)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let access_token = JSON["access_token"] as? String {
                        self.translateHeaders["Authorization"] = "Bearer \(access_token)"
                        let finalTranslateText = translateString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
                        let finalTranslateUri = "\(self.translateUri)?text=\(finalTranslateText)&from=\(sourceCode)&to=\(destinationCode)"
                        Alamofire.request(.GET, finalTranslateUri, headers: self.translateHeaders)
                            .response { (request, response, data, error) in
                                if data == nil {
                                    completion("error")
                                }
                                let xml = SWXMLHash.parse(data!)
                                if let definition = xml["string"].element?.text {
                                    completion(definition)
                                }
                            }
                        
                    } else {
                        completion("error")
                    }

                } else {
                    completion("error")
                }
                
            }
    }
    
}

