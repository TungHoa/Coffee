//
//  CartCell.swift
//  CafeTek
//
//  Created by Tung on 10/7/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia

class CartCell: UITableViewCell {
    
    let imgName = UIImageView()
    let lblName = UILabel()
    let lblSize = UILabel()
    let lblSugar = UILabel()
    let lblAddtion = UILabel()
    let lblMoney = UILabel()
    let lblQuanlity = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        self.sv(imgName,lblName,lblSize,lblSugar,lblAddtion,lblMoney,lblQuanlity)
        
        //imgName.contentMode = .scaleAspectFill
        
        imgName.centerVertically()
//        imgName.Top == self.Top + 10
        imgName.Left == self.Left + 16
//        imgName.Bottom == self.Bottom - 10
        imgName.Right == lblName.Left - 20

        //imgName.size(50)
        
        
        
        lblName.Top == self.Top + 10
        
        
        
        lblSize.Top == lblName.Top
        lblSize.Left == lblName.Right + 10

        lblSugar.Left == imgName.Right + 20
        lblSugar.Top == lblName.Bottom + 5
        

        lblAddtion.Left == imgName.Right + 20
        lblAddtion.Top == lblSugar.Bottom + 5
        //lblAddtion.Bottom == imgName.Bottom
        
        lblQuanlity.Right == lblMoney.Left - 50
        lblQuanlity.centerVertically()



        lblMoney.Right == self.Right - 10
        lblMoney.centerVertically()
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
