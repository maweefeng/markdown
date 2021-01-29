//
//  MardDownCell.swift
//  MarkDemo
//
//  Created by Alex wee on 2021/1/29.
//

import UIKit
import WebKit
import Down
class MardDownCell: UITableViewCell {
   /* lazy var webView:WKWebView = {
        let web = WKWebView(frame: self.bounds)
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()*/
    
    let queue = DispatchQueue(label: "renderMarkdowncellQueue")
    lazy var contentLabel:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        return l
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    private func configSubviews(){
        
        /*self.addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true*/
        
        self.addSubview(contentLabel)
        contentLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        

    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configModel() -> Void {
        let markdown: String = """
        # test
        测试显示图片的markdown字符串
        ![hello](https://t7.baidu.com/it/u=1595072465,3644073269&fm=193&f=GIF)
        """
        /*
        let parser = MarkdownParser()
        let html = parser.html(from: markdown)
        print(html)
        webView.loadHTMLString(html, baseURL: nil)*/
        queue.async {
            let down = Down(markdownString: markdown)
            let attributedString = try? down.toAttributedString()
            print(attributedString ?? "")
            
            DispatchQueue.main.async {
                self.contentLabel.attributedText = attributedString
            }
        }
    
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
