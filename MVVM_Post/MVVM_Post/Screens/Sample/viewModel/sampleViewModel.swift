//
//  sampleViewModel.swift
//  MVVM_Post
//
//  Created by Adarsh Singh on 17/09/23.
//

import Foundation

final class sampleViewModel{
    
    var sample:[SampleModel] = []
    var eventHandler:((_ event: Event)->Void)?
    
    func fetchdata(){
        self.eventHandler?(.loading)
        ApiManager.shared.fetchData(modelType: [SampleModel].self, type: SampleEndPoint.sample) { response in
            self.eventHandler?(.stopLoading)
            switch response{
                
            case .success(let sample):
                self.sample = sample
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    
    func addSampleData(parameter: AddData){
        
        ApiManager.shared.fetchData(modelType: AddData.self, type: SampleEndPoint.addSample(data: parameter)) { response in
            switch response{
                
            case .success(let sample):
                self.eventHandler?(.newData(data: sample))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
}
extension sampleViewModel{
    
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        
        case newData(data: AddData)
    }
}
