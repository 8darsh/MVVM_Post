//
//  ViewController.swift
//  MVVM_Post
//
//  Created by Adarsh Singh on 17/09/23.
//

import UIKit

class ViewController: UIViewController {
    
     var viewModel = sampleViewModel()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addData))
        configuration()
    }
    @objc func addData(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddSampleDataViewController") as!
        AddSampleDataViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController{
    
    func configuration(){
        
        initModel()
        observeEvent()
    }
    
    func initModel(){
        
        viewModel.fetchdata()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            
            guard let self else {return}
            
            switch event{
                
            case .loading:
                print("loading")
            case .stopLoading:
                print("stoploading")
            case .dataLoaded:
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            case .newData(data: let data):
                print(data)
            }
            
        }
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sample.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = viewModel.sample[indexPath.row].title
        
        return cell!
    }
    
    
}

