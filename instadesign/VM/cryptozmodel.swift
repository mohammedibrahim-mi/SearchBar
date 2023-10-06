//
//  cryptozmodel.swift
//  instadesign
//
//  Created by Mohammed Ibrahim on 06/10/23.
//

import Foundation
import Alamofire
import Combine

class CryptoCurrenciesViewModel :  ObservableObject {
    
    @Published var cryptoCurrenciesObj : [CryptoCurrenciesDatum] = []
    @Published var cryptoImg : String = ""
    @Published var cryptoName : String = ""
    @Published var crypto : String = ""
    @Published var cryptoId : Int = 0
    @Published var isSuccess : Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var tokens = UserDefaults.standard.string(forKey: "token") ?? ""
    
    func crytoCurrenciesFunc(){
        
        let token = tokens
        
        guard let url = URL(string: "https://new.demo.com//api/public/api/cryptocurrencies")
        else {
            return
        }
        
        let headers : HTTPHeaders = ["Authorization" : "Bearer XL3qVNU9XhGyVnRn4LRMQN2v3NpAm4IbzH4pk9IT45414dab"]
        
        AF.request(url , method: .get , parameters: nil , headers: headers)
            
        
        .publishDecodable(type: CryptoCurrenciesModel.self)
        .compactMap{response in
            response.value
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: {completion in
            
            switch completion{
                
            case .finished:
                break
                
            case .failure(let error):
                print("Error : \(error)")
            }
            
        }, receiveValue: {responseData in
            
            if responseData != nil{
                if responseData.success{
                    
                    self.cryptoCurrenciesObj = responseData.data
                    self.crypto = self.cryptoCurrenciesObj.first?.slug ?? ""
                    self.cryptoImg = self.cryptoCurrenciesObj.first?.logo ?? ""
                    self.cryptoName = self.cryptoCurrenciesObj.first?.name ?? ""
                    self.cryptoId = self.cryptoCurrenciesObj.first?.id ?? 0
                    self.isSuccess = true
                }
                else{
                    print("Failed")
                }
            }
            else{
                print("Invalid response data")
            }
            
        })
        .store(in: &self.cancellables)
            
        
    }
    
    
}
