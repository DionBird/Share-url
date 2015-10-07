//  ViewController.swift
//  Copyright (c) 2015 Bill Weinman. All rights reserved.

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let _version = "1.0.1"

    @IBOutlet var status: UILabel!
    @IBOutlet weak var urlTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        status("Share URL demo \(_version)")
        urlTextField.delegate = self
        urlTextField.becomeFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.shareText(textField)
        return true
    }

    @IBAction func shareText(sender: AnyObject) {
        // add the URL scheme, if there is none
        if let urlText = urlTextField.text where urlText.characters.count > 0 {
            if urlText.rangeOfString("://") == nil {
                urlTextField.text = "http://" + urlText
            }
        } else {
            status("Empty URL")
            return
        }
        
        if let url = NSURL(string: urlTextField.text!) {
            urlTextField.text = url.absoluteString
            // only accept HTTP or HTTPS URLs
            if url.scheme != "http" && url.scheme != "https" {
                status("Invalid URL scheme \(url.scheme)")
                return
            }
            let sharingItems = [url]
            let applicationActivities = [SafariActivity(), ChromeActivity()]
            let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: applicationActivities)
            self.presentViewController(activityViewController, animated: true, completion: nil)
        } else {
            status("Nothing to share")
        }
    }

    private func status( m: String ) {
        status.text = m
    }
}
