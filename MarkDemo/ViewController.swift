//
//  ViewController.swift
//  MarkDemo
//
//  Created by Alex wee on 2021/1/29.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var heightCache:[IndexPath:CGFloat] = [:]

    let markdown: String = """
    ### WOA新版功能介绍 2021-01-21   \n   \n▪ PC端在线时默认关闭手机通知  \n \n▪ PC支持自定义快捷键，让设置更贴近习惯   \n \n▪ 输入框双击图片预览，确保编辑内容准确性 \n \n▪ 建群时查看已有群，相同成员无需重复建群  \n  \n▪ 按需创建单双人群，群人数不再受限制  \n  \n▪ 更新日志常驻设置页，新功能不再被遗漏 \n \n  \n \n 更多功能：[WOA新功能说明](https://kdocs.cn/l/cscJV4oD8aFs)\n\n![hello](https://t7.baidu.com/it/u=1595072465,3644073269&fm=193&f=GIF)"
    """

    let markdown2:String = """
    # test
    测试显示图片的markdown字符串                dier

    ![hello](https://t7.baidu.com/it/u=1595072465,3644073269&fm=193&f=GIF)

    [baidu](https://www.baidu.com)
    """
    var dataList:[Msg] = []
    
    
    lazy var tabView:UITableView = {
        let tab = UITableView(frame: self.view.bounds, style: .plain)
        tab.register(MardDownCell.self, forCellReuseIdentifier: "cell")
        tab.delegate = self
        tab.dataSource = self
        return tab
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tabView)
        tabView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tabView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
        let msg = Msg(markDown: markdown, attributeString: Msg.caculate(markDown: markdown))
        let msg2 = Msg(markDown: markdown, attributeString: Msg.caculate(markDown: markdown2))

        dataList.append(contentsOf: [msg,msg,msg,msg2,msg,msg2,msg,msg,msg,msg,msg,msg,msg,msg,msg,msg,msg,msg,msg,msg])
        
        
    }
    
    //  MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MardDownCell
        let msg = dataList[indexPath.row]
        cell.model = msg
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let msg = dataList[indexPath.row]
        if heightCache[indexPath] == nil {
            let height = msg.height
            heightCache[indexPath] = height
            return height
        }else{
            return heightCache[indexPath]!
        }
    }
}

