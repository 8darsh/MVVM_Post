//
//  AddSampleDataViewController.swift
//  MVVM_Post
//
//  Created by Adarsh Singh on 17/09/23.
//

import UIKit

class AddSampleDataViewController: UIViewController {
    
    var viewModel = sampleViewModel()
    @IBOutlet var userid: UITextField!
    
    @IBOutlet var titletxt: UITextField!
    
    @IBOutlet var body: UITextField!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.

    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        let sampleData = AddData(userId: userid.hashValue, title: titletxt.text!, body: body.text!)
        viewModel.addSampleData(parameter: sampleData)
        navigationController?.popViewController(animated: true)
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
