//
//  ViewController.swift
//  BetterThanSafari
//
//  Created by Степан Усьянцев on 20.12.2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.delegate = self
        webView.navigationDelegate = self
        let homePage = "https://www.apple.com/ru/"

        if let url = URL(string: homePage) {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        urlTextField.text = homePage
        webView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func backTapped(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @IBAction func forwardTapped(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let urlString = textField.text else { return false }
        guard let url = URL(string: urlString) else { return false }

        let request = URLRequest(url: url)
        webView.load(request)

        textField.resignFirstResponder()

        return true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString

        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}

