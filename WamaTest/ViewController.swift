//
//  ViewController.swift
//  WamaTest
//
//  Created by Prakash on 31/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    var arrArticles : [NewsArticle]? = nil
    var expandedIndexSet : IndexSet = []
    
    @IBOutlet weak var wamaTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DBManager.sharedInstance.fetchAllData().count > 0{
            self.getArcticles()
        }else{
            APIManager.sharedInstance.getAPIResponse { response, errorMesage in
                DBManager.sharedInstance.save(arrArticles: response!) { msg, error in
                    if let msg = msg{
                        print(msg)
                        self.getArcticles()
                        DispatchQueue.main.async {
                            self.wamaTableView.reloadData()
                        }
                    }else{
                        print(error?.localizedDescription ?? "")
                    }
                }
            }
        }
    }
    
    //get news articles detail from local database
    private func getArcticles(){
        self.arrArticles = DBManager.sharedInstance.fetchAllData()
        print(DBManager.sharedInstance.fetchAllData())
        
    }
    
    //local function to handle like dislike button click
    private func likeDisLikeButtonClick(buttonType:ButtonType,index:Int){
        if DBManager.sharedInstance.likeDislike(buttonType: buttonType, index: index){
            self.arrArticles?.removeAll()
            self.getArcticles()
            let indexPath = IndexPath(row: index, section: 0)
            wamaTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    //local function to handle read more button click
    private func readMoreButtonClick(index:Int){
        if(expandedIndexSet.contains(index)){
            expandedIndexSet.remove(index)
        } else {
            expandedIndexSet.insert(index)
        }
        let indexPath = IndexPath(row: index, section: 0)
        wamaTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "headerCell")!
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrArticles != nil ? self.arrArticles!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.newsArticle = self.arrArticles![indexPath.row]
        cell.index = indexPath.row
        cell.selectedButtonType = { buttonType,index in
            switch buttonType{
            case .like : self.likeDisLikeButtonClick(buttonType: .like, index: index!)
            case .dislike : self.likeDisLikeButtonClick(buttonType: .dislike, index: index!)
            case .readmore : self.readMoreButtonClick(index: index!)
            }
        }
        if expandedIndexSet.contains(indexPath.row) {
            cell.isMultiLine = true
        } else {
            cell.isMultiLine = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ScrollViewContainerVC(), animated: true)
    }
}
