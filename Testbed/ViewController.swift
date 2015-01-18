//
//  ViewController.swift
//  Testbed
//
//  Created by Bill Weinman on 2015-01-18.
//  Copyright (c) 2015 Bill Weinman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let _version = "1.0.0"
    
    @IBOutlet var textView: UITextView!

    private func test1() {
        for i in 1...10 {
            message(String(format: "This is line %02d", i))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextView()
        message("Testbed \(_version)")
        test1()
    }

    // MARK: Testbed message() support

    private func initTextView() {
        // intermittent scrollview bug workaround
        textView.scrollEnabled = false
        textView.scrollEnabled = true

        textView.editable = false
        textView.font = UIFont(name: "Courier", size: 14.0)
    }

    private func message( m: String ) {
        textView.text = textView.text + m + "\n"
        textView.scrollRangeToVisible(NSRange(location: countElements(textView.text) - 1, length: 0))
    }
}
