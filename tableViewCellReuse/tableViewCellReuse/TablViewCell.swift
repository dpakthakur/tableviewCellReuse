//
//  TablViewCell.swift
//  tableViewCellReuse
//
//  Created by Deepak Thakur on 01/09/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import UIKit

protocol CellButtonProtocol: class {
    func btnTapCalled(_ sender: TablViewCell);
}

class TablViewCell: UITableViewCell {
    

    @IBOutlet weak var fieldTxt: UITextField!
    
    @IBOutlet weak var btnCheck: UIButton!
    
    weak var delegate: CellButtonProtocol?;
    
    @IBAction func btnCheckAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected;
        delegate?.btnTapCalled(self);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let cell = textField.superview?.superview as! TablViewCell
//        let table = cell.superview as! UITableView
//        let textFieldIndexPath = table.indexPath(for: cell);
//        print("Txt field ended editing for indexpath: ", textFieldIndexPath ?? "Not Found");
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("return");
//        textField.resignFirstResponder()
//        return true;
//    }

}
