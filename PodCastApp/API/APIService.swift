//
//  APIService.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/6/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit
class APIService {
    static let shared = APIService()
    
    
    func fetchEpisodes(url : String , completion : @escaping(_ epsiodes : [Episode])->()){
        guard let feedURL = URL(string: url)else {return}
        DispatchQueue.global(qos: .userInteractive).async {
            let feedParser = FeedParser(URL: feedURL)
            feedParser?.parseAsync(result: { (result) in
                guard let feed  = result.rssFeed else{return}
                completion(feed.toEpisodes())
            })
        }
    }
    
    func fetchPodCasts(searchText : String,completion: @escaping(_ podCasts : [PodCast])->()) {
        let url = URL(string: "https://itunes.apple.com/search")
        let parameters = ["term":searchText,"media":"podcast"]
        Alamofire.request(url!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (response) in
          
            if let err = response.error{
                print(err)
                return
            }
            guard let data  = response.data else{return}
            do{
                let returnedValue = try JSONDecoder().decode(searchResults.self, from: data)
                print("number is \(returnedValue.resultCount)")
                completion(returnedValue.results)
            }catch let error{
                print("++++",error.localizedDescription)
            }
            
            
        }
    }
  
}

struct searchResults : Decodable {
    let resultCount : Int
    let results : [PodCast]
    
}


