//
//  WebViewPDF.swift
//  TestPDF
//
//  Created by Irena on 11.09.17.
//  Copyright © 2017 Irena. All rights reserved.
//

import UIKit

class WebViewPDF: UIWebView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var isCasesensitive: Bool = false
    private var isHighliteSearch: Bool = false
    // Contain search string which will searched after pdf file is loaded
    private var searchAfterLoad: String = ""
    private(set) var filePath: String?
    private(set) var searchString: String?
    
    func loadPDF(filePath: String) {
        // Assign new file path to the property
        self.filePath = filePath
        let sPath: String? = Bundle.main.path(forResource: "viewer", ofType: "html", inDirectory: "PDFJS/web")
        print("sPath: \(String(describing: sPath))")
        let finalPath: String = "\(String(describing: sPath))?file=\(filePath)#page=1"
        print("finalPath: \(String(describing: finalPath))")
        let request = URLRequest(url: URL(string: finalPath)!)
        print("request: \(String(describing: request))")
        loadRequest(request)
    }
    
    /**
     Display page number of pdf file
     **/
    
    func showPage(_ page: Int) {
        let sPath: String? = Bundle.main.path(forResource: "viewer", ofType: "html", inDirectory: "PDFJS/web")
        let finalPath: String = "\(String(describing: sPath))?file=\(String(describing: filePath))#page=\(Int(page))"
        let request = URLRequest(url: URL(string: finalPath)!)
        loadRequest(request)
    }
    
    // MARK: - Search related function
    /**
     Search stirng in pdf file
     **/
    func search(_ searchStirng: String) {
        search(searchStirng, withHighliteSearch: false, withCasesencitive: false)
    }
    
    /**
     Search stirng in pdf file.
     \param isHighliteSearch highlite search all result
     \param isCasesensitive perform search with case sensitive
     **/
    
    func search(_ searchStirng: String, withHighliteSearch isHighliteSearch: Bool, withCasesencitive isCasesensitive: Bool) {
        self.isHighliteSearch = isHighliteSearch
        self.isCasesensitive = isCasesensitive
        self.searchString = searchStirng
        let javaScript: String = "var event = document.createEvent('CustomEvent');event.initCustomEvent('find', true, true, {query: '\(searchStirng)',caseSensitive: \(self.isCasesensitive ? "true" : "false"),highlightAll: \(self.isHighliteSearch ? "true" : "false"),findPrevious:false});window.dispatchEvent(event);"
        stringByEvaluatingJavaScript(from: javaScript)
    }
    
    /**
     Perform next search result
     **/
    
    func nextSearchResult() {
        let javaScript: String = "var event = document.createEvent('CustomEvent');event.initCustomEvent('findagain', true, true, {query: '\(String(describing: searchString))',caseSensitive: \(isCasesensitive ? "true" : "false"),highlightAll: \(isHighliteSearch ? "true" : "false"),findPrevious:false});window.dispatchEvent(event);"
        stringByEvaluatingJavaScript(from: javaScript)
    }
    
    /**
     Perform previous search result
     **/
    func previousSearchResult() {
        let javaScript: String = "var event = document.createEvent('CustomEvent');event.initCustomEvent('findagain', true, true, {query: '\(String(describing: searchString))',caseSensitive: \(isCasesensitive ? "true" : "false"),highlightAll: \(isHighliteSearch ? "true" : "false"),findPrevious:true});window.dispatchEvent(event);"
        stringByEvaluatingJavaScript(from: javaScript)
    }
    
    /**
     Highlte all search result
     **/
    
    func setHighliteSearch(_ isHighliteSearch: Bool) {
        self.isHighliteSearch = isHighliteSearch
    }
    
    /**
     Display result on base of case sensitive value
     **/
    func setCasesensitiveSearch(_ isCasesensitive: Bool) {
        self.isCasesensitive = isCasesensitive
    }
    
    //#pragma mark - UIWebView delegates
    //-(void)webViewDidFinishLoad:(UIWebView *)webView
    //{
    //    if(searchAfterLoad.length != 0)
    //    {
    //        [self search:searchAfterLoad withHighliteSearch:_isHighliteSearch withCasesencitive:_isCasesensitive];
    //    }
    //}

}
