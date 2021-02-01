//
//  MardDownCell.swift
//  MarkDemo
//
//  Created by Alex wee on 2021/1/29.
//

import UIKit
import WebKit
import YYKit
import Down

struct Msg {
    let markDown:String
    
    static func caculate(markDown:String)->NSAttributedString{
        
        let down = Down(markdownString: markDown)
        let attributedString = try? down.toAttributedString()
        let new_attribute_string:NSMutableAttributedString = NSMutableAttributedString()
        attributedString?.enumerateAttributes(in: NSRange(location: 0, length: attributedString?.length ?? 0), options: [], using: { (attibuteKeysDic, range, _) in
            if attibuteKeysDic[.attachment] == nil{
                //说明不是图片
                if let subattributeString = attributedString?.attributedSubstring(from: range){
                    new_attribute_string.append(subattributeString)
                }
            }else{
                //图片
                new_attribute_string.append(Self.pString())
            }
        })
        return new_attribute_string

    }
    var attributeString:NSAttributedString{
        didSet{}
        willSet{}

    }
    var height:CGFloat{
        let size = attributeString.boundingRect(with: CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil)
        return size.height
    }
    
    static func pString()->NSAttributedString{
        
        return self.aStringByImage(image: UIImage(named: "loading")!)
    }
    
    static func aStringByImage(image:UIImage)->NSAttributedString{
        
        let attchImage = NSTextAttachment();
        attchImage.image = image;
        attchImage.bounds = CGRect(x: 0, y: 0, width: 100, height: 100);
        let stringImage = NSAttributedString.init(attachment: attchImage);
        return stringImage;
    }
}
class MardDownCell: UITableViewCell {
    var imageMap:[NSRange:String] = [:]
    let queue = DispatchQueue(label: "renderMarkdowncellQueue")
    lazy var contentLabel:UILabel = {
        let l = UILabel(frame: .zero)
        l.isUserInteractionEnabled = true
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        return l
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    private func configSubviews(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTappedCell(_:)))
        self.addGestureRecognizer(tap)
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
    var model:Msg?{
        willSet{
            if self.contentLabel.attributedText != nil {
                return
            }
        }
        didSet{
            if let model = model{
                self.contentLabel.attributedText = model.attributeString
            }
        }
    }
    

    
   
    @objc func onTappedCell(_ gesture: UITapGestureRecognizer) {
    
        
    }
    private func dealHTML(html:String){
        var content = ""
        var arr:[String] = []
        if let regularExpression = try? NSRegularExpression.init(pattern: "<[^>]*>|\n", options: .allowCommentsAndWhitespace){
            content = regularExpression.stringByReplacingMatches(in: html, options: .reportProgress, range: NSRange(location: 0, length: html.count), withTemplate: "-")
            if let regularExpretion = try? NSRegularExpression.init(pattern: "-{1,}", options: NSRegularExpression.Options(rawValue: 0)){
                content = regularExpretion.stringByReplacingMatches(in: content, options: .reportProgress, range: NSRange(location: 0, length: content.count), withTemplate: "-")
                arr = content.components(separatedBy: "-")
                arr.removeAll(where: {$0==""})
                print(arr)
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
