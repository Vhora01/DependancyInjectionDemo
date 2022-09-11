//
//  TableViewCell.swift
//  WamaTest
//
//  Created by Prakash on 01/06/22.
//

import UIKit

enum ButtonType{
    case like
    case dislike
    case readmore
}

class TableViewCell: UITableViewCell {

    
    var selectedButtonType : ((_ buttonType:ButtonType,_ index:Int?)->Void)? = nil
    var isMultiLine : Bool? {
        didSet{
            if let isMultiLine = isMultiLine{
                if isMultiLine{
                    lblDescription.numberOfLines = 0
                }else{
                    lblDescription.numberOfLines = 1
                }
            }
        }
    }
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lazyImageView : LazyImageView!
    
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var btnDisLike: UIButton!
    @IBOutlet weak var btnReadMore: UIButton!
    var index: Int?
    var newsArticle : NewsArticle?{
        didSet{
            if let article = newsArticle{
                self.setCell(object: article)
            }
        }
    }
    
    //configure tableviewcell
    private func setCell(object:NewsArticle){
        lblTitle.text = object.title
        lblDescription.text = object.descriptions
        
        if let strImageURL = object.urlToImage{
            if let imageURL = URL(string: strImageURL){
                lazyImageView.loadImage(fromURL: imageURL, placeHolderImage: "")
            }
        }
        btnLike.setRoundedCorner(corner: 10.0)
        btnDisLike.setRoundedCorner(corner: 10.0)
        if object.like == true{
            btnLike.backgroundColor = .blue
            btnLike.setTitleColor(.white, for: .normal)
        }else{
            btnLike.backgroundColor = .lightGray
            btnLike.setTitleColor(.black, for: .normal)

        }
        
        if object.dislike == true{
            btnDisLike.backgroundColor = .blue
            btnDisLike.setTitleColor(.white, for: .normal)
        }else{
            btnDisLike.backgroundColor = .lightGray
            btnDisLike.setTitleColor(.black, for: .normal)

        }
        
        if let dateString = object.publishedAt{
            
            lblDate.text =  convertDateFormat(inputDate: dateString)
             
        }
        
        
    }
    //Date Formatting
   private func convertDateFormat(inputDate: String) -> String {
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM"

         return convertDateFormatter.string(from: oldDate!)
    }
    
    
    //Button Tapped Function
    @IBAction func btnTapped(_ sender: UIButton) {
        if sender == btnLike{
            if let selectedButtonType = selectedButtonType{
                selectedButtonType(.like, index)
            }
        }else if sender == btnDisLike{
            if let selectedButtonType = selectedButtonType{
                selectedButtonType(.dislike, index)
            }
        }else if sender == btnReadMore{
            if let selectedButtonType = selectedButtonType{
                selectedButtonType(.readmore, index)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



extension UIButton{
    func setRoundedCorner(corner:CGFloat){
        self.layer.cornerRadius = corner
    }
}
