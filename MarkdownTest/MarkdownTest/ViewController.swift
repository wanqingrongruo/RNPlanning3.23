//
//  ViewController.swift
//  MarkdownTest
//
//  Created by 婉卿容若 on 2017/3/28.
//  Copyright © 2017年 婉卿容若. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Symbol documentation
    // 注释显示方式
    // 1. 把光标放到demo1所在的行上，按住option点一下，就会弹出这个函数的说明，可以看到Xcode已经把markdown注释渲染了；
    // 2. 按Option + Command + 2打开Quick Help Inspector，保持光标在demo1()函数名上，同样，我们可以看到被渲染过的Markdown注释

    // 单行注释
    /// A **demo** function
    func demo() {
        
    }
    
    // 多行注释
    /**
      * item1
      * item2
      * item3
    */
    func demo02() {
        
    }
    
    
    /**
      # IMPORTANT: something important you want to mention:
      A general description here.
      1. item1
      2. item2
      3. item3
      ---
      [More info - Access boxueio.com](https://boxueio.com)
    */
    func demo03() {
        
    }
    
}

