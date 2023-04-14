//
//  MoviePreviewViewController.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 14/04/2023.
//

import UIKit
import WebKit

class MoviePreviewViewController: UIViewController {
    
    private let webview: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 22, weight: .bold)
        return title
    }()
    
    private let overviewLabel: UILabel = {
        let overview = UILabel()
        
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.font = .systemFont(ofSize: 18, weight: .regular)
        overview.textAlignment = .justified
        overview.numberOfLines = 0
        return overview
    }()
    
    private let downloadBtn: UIButton = {
        let download = UIButton()
        
        download.translatesAutoresizingMaskIntoConstraints = false
        download.backgroundColor = .red
        download.setTitle("Download", for: .normal)
        download.setTitleColor(.white, for: .normal)
        download.layer.cornerRadius = 8
        download.layer.masksToBounds = true
        return download
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadBtn)
        view.addSubview(webview)
        
        configureConstraints()
    }

    
    func configureConstraints() {
        
        let webviewConst = [
            webview.topAnchor.constraint(equalTo: view.topAnchor),
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webview.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleConst = [
            titleLabel.topAnchor.constraint(equalTo: webview.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let overviewConst = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadCosnt = [
            downloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadBtn.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            downloadBtn.widthAnchor.constraint(equalToConstant: 140),
            downloadBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webviewConst)
        NSLayoutConstraint.activate(titleConst)
        NSLayoutConstraint.activate(overviewConst)
        NSLayoutConstraint.activate(downloadCosnt)
    }
    
    func getPreviewData(with model: MoviePreviewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        
        
        guard let url = URL(string: "https://youtube.com/embed/\(model.youtube_url)") else {return}
                
        webview.load(URLRequest(url: url))
    }
 }
