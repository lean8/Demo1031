//
//  APICaller.swift
//  Demo1031
//
//  Created by lean on 2022/10/31.
//

import Foundation
import UIKit

class APICaller{
    
    static let shared = APICaller()
    
    func getData(completion: @escaping (Result<[UserData] , Error>) -> Void){
        guard let url = URL(string: "https://raw.githubusercontent.com/winwiniosapp/interview/main/interview.json") else{return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {return}
                
            do{
                let results = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(results.data.items))
            }
            catch{
               print("SomeThing Wrong",error)
            }
            
        }
        task.resume()
    }
    
    func getCount(completion: @escaping (Result<Int , Error>) -> Void){
        guard let url = URL(string: "https://raw.githubusercontent.com/winwiniosapp/interview/main/interview.json") else{return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {return}
                
            do{
                let results = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(results.data.totalCount ?? 0))
            }
            catch{
               print("SomeThing Wrong",error)
            }
            
        }
        task.resume()
    }
}
