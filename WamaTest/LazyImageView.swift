//
//  LazyImageView.swift
//  WamaTest
//
//  Created by Prakash on 01/06/22.
//

import Foundation
import UIKit
class LazyImageView : UIImageView{
    
    func loadImage(fromURL imageURL:URL,placeHolderImage:String){
        self.image = UIImage(named: placeHolderImage)
        self.layer.cornerRadius = 10.0
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: imageURL){
                if let image = UIImage(data: imageData){
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.contentMode = .scaleAspectFill
                    }
                }
            }
        }
    }
}
