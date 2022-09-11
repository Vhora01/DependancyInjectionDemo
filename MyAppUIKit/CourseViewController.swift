//
//  CourseViewController.swift
//  MyAppUIKit
//
//  Created by Prakash on 10/09/22.
//

import UIKit


public protocol DataFetchable{
    func fetchCources(completionHandler: @escaping ([String])->Void)
}

struct Courses{
    var name : String
}
public class CourseViewController: UIViewController {

    let dataFetchable : DataFetchable?
    var cources : [Courses] = []
    public init(dataFetchable : DataFetchable){
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        dataFetchable?.fetchCources(completionHandler: { [weak self] names in
            self?.cources = names.map({Courses(name:$0)})
            print(self?.cources)
        })
        // Do any additional setup after loading the view.
    }
    
}
