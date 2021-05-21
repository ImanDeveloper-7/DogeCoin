//
//  APICaller.swift
//  DogeCoin
//
//  Created by Iman Zabihi on 20/05/2021.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let apikey = "fe96a915-da48-43cf-ad94-31ebede368f3"
        static let apiHeader = "X-CMC_PRO_API_KEY"
        static let baseUrl = "https://pro-api.coinmarketcap.com/v1/"
        static let doge = "dogecoin"
        static let endpoint = "cryptocurrency/quotes/latest"
    }
    
    enum APIError: Error {
        case invalidUrl
    }
    
    public func getDogeCoinData(completion: @escaping (Result<DogeCoineData, Error>) -> Void) {
        guard let url = URL(string: Constants.baseUrl + Constants.endpoint + "?slug=" + Constants.doge) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        print("\n\n API URL: \(url.absoluteString) \n\n")
        
        var request = URLRequest(url: url)
        request.setValue(Constants.apikey, forHTTPHeaderField: Constants.apiHeader)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                guard let dogeCoinData = response.data.values.first else { return }
                completion(.success(dogeCoinData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
