//
//  ScrollViewContainerVC.swift
//  WamaTest
//
//  Created by Prakash on 10/09/22.
//

import UIKit

import MyAppUIKit
import APIKit
class ScrollViewContainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        present(CourseViewController(dataFetchable: APICaller.shared), animated: true)
    }
}
