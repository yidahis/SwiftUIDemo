//
//  ViewController.swift
//  手势解锁
//
//  Created by yidahis on 2020/1/29.
//  Copyright © 2020 fame.inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lockView: LockView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lockView.delegate = self
        // Do any additional setup after loading the view.
        var psw = 11
        switch psw {
        case 1:
            do {
                print("123")
            }
        default:
            break
        }
    }
}

extension ViewController: LockViewDelegate{
    func lockView(_ view: LockView, path: String, didFinished: Bool) {
        print(path)
    }
}

