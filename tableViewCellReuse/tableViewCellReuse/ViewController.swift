//
//  ViewController.swift
//  tableViewCellReuse
//
//  Created by Deepak Thakur on 31/08/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CellButtonProtocol, UITextFieldDelegate {

    @IBOutlet weak var tablView: UITableView!
    var checkmark = Set<IndexPath>()
    var txtFieldTxtSet = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tablView.tableFooterView = UIView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnTapCalled(_ sender: TablViewCell) {
        guard let tappedIndexPath = self.tablView.indexPath(for: sender) else { return }
        //print("checkbox: ", sender, tappedIndexPath)
        if (sender.btnCheck.isSelected) {
            checkmark.insert(tappedIndexPath);
        } else {
            checkmark.remove(tappedIndexPath);
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let origin: CGPoint = textField.frame.origin
        let point: CGPoint? = textField.superview?.convert(origin, to: self.tablView)
        let indexPath: IndexPath? = self.tablView.indexPathForRow(at: point ?? CGPoint.zero)
        self.tablView.scrollToRow(at: indexPath!, at: .middle, animated: true);
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as! TablViewCell
        let table = cell.superview as! UITableView
        let textFieldIndexPath = table.indexPath(for: cell);
        print("Txt field ended editing for indexpath: ", textFieldIndexPath ?? "Not Found");
        if let txt = textField.text {
            txtFieldTxtSet[textFieldIndexPath!] = txt;
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("return");
        textField.resignFirstResponder()
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true;
    }

}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TablViewCell;
        cell.delegate = self;
        cell.btnCheck.isSelected = checkmark.contains(indexPath) ? true : false;
        cell.fieldTxt.text = txtFieldTxtSet.object(forKey: indexPath) as? String;
        return cell;
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0;
    }
    
}






