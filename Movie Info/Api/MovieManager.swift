//
//  MovieManager.swift
//  Movie Info
//
//  Created by Mohammed Ibrahim on 3/7/21.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateData(data : NewAraivaLData)
}

struct MovieManager {
    
    var delegate : MovieManagerDelegate?
    let headers = [
        "x-rapidapi-key": "key",
        "x-rapidapi-host": "ott-details.p.rapidapi.com"
    ]
    
    func fetchNewArrivals(){
        let newArraivals = NSMutableURLRequest(url: NSURL(string: "https://ott-details.p.rapidapi.com/getnew?region=US&page=1")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
    
        request(requert_url: newArraivals)
    }
    
    func request(requert_url : NSMutableURLRequest){
        requert_url.httpMethod = "GET"
        requert_url.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: requert_url as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error")
                print(error!)
                return
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
                print(data!.count)
            }
            if let safeData = data {
                if let newArraival = self.JSONParse(data: safeData ){
                    self.delegate?.didUpdateData(data: newArraival)
                }
            }
            
        })
        dataTask.resume()
       
    }
    
//    func JSONParse(data : Data) -> NewArraivalModel?{
//        let decoder = JSONDecoder()
//        do{
//            let decodedData = try decoder.decode(NewAraivaLData.self, from: data)
//            let imdbid : String = decodedData.results[0].imdbid
//            let title : String = decodedData.results[0].title
//            let runtime : String = decodedData.results[0].runtime
//            let imdbrating : Float = decodedData.results[0].imdbrating
//            let type : String = decodedData.results[0].type
//            let synopsis : String = decodedData.results[0].synopsis
//            let newArraival = NewArraivalModel(imdbid: imdbid, title: title, runtime: runtime, imdbrating: imdbrating, type: type, synopsis: synopsis)
//            return newArraival
//        }catch{
//            print(error)
//            return nil
//        }
//    }
    func JSONParse(data : Data) -> NewAraivaLData?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(NewAraivaLData.self, from: data)
            print(decodedData)
            return decodedData
        }catch{
            print(error)
            return nil
        }
    }

}


//print(datastring!)
//let jsonData = datastring!.data(using: .utf8)
//
//if let newArraival = try? JSONDecoder().decode(NewAraivaLData.self, from: jsonData!) {
//    print(newArraival.results[0].imdbid)
//    DispatchQueue.main.async {
//        let VC = ViewController()
//        VC.didUpdateData(data: newArraival.results[0].imdbid)
//        print("change")
//    }
//
//}
