//
//  DetailsViewController.swift
//  Dummy
//
//  Created by DonorRaja on 5/06/21.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var userId: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var completedLabel: UILabel!
    
    var userID:String?
    var detailText:String?
    var completedText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userId.text = userID
        self.detailLabel.text = detailText
        self.completedLabel.text = completedText
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
