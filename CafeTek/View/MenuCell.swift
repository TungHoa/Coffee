//
//  MenuCell.swift
//  CafeTek
//
//  Created by Tung on 9/28/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia

class MenuCell: UITableViewCell {
    
    let imageMenu = UIImageView()
    let lblTitle = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.sv(imageMenu,lblTitle)
        
        self.layout(
            
            |-24-imageMenu.centerVertically()-40-lblTitle.centerVertically()-(>=20)-|
            
        )
        imageMenu.contentMode = .scaleAspectFit
        lblTitle.font = UIFont.systemFont(ofSize: 20)
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
