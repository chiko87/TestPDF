//
//  ViewController.swift
//  TestPDF
//
//  Created by Irena on 11.09.17.
//  Copyright © 2017 Irena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Responsible for display PDF file
    var pdfViewer: WebViewPDF?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pdfViewer = WebViewPDF(frame: self.view.bounds)
        var frame: CGRect = pdfViewer!.frame
        frame.origin.y += 80
        pdfViewer?.frame = frame
        self.view.addSubview(pdfViewer!)
        // Disbale scroll bounce
        pdfViewer?.scrollView.bounces = false
        
        let filepath: String = Bundle.main.path(forResource: "compressed.tracemonkey-pldi-09", ofType: "pdf")!
        pdfViewer?.loadPDF(filePath: filepath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextfield delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pdfViewer?.search(textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let finalString: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        do {
            pdfViewer?.search(finalString)
        }
        return true
    }
    
    // MARK: - handel click event
    @IBAction func btnPreviusClicked(_ sender: Any) {
        pdfViewer?.previousSearchResult()
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        pdfViewer?.nextSearchResult()
    }
}

