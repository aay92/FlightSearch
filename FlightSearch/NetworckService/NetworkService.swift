import UIKit

enum FetchError: Error {
    case notCorrectData, invalidURL
}

class NetworkService {
    
    static let shared = NetworkService()
    init(){}
    
    func fetchDataForFirstScreen(completion: @escaping (Result<UserData, Error>) -> Void) {
        
        guard let url = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd") else {
            completion(.failure(FetchError.invalidURL))
            return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return }
            
            guard let data = data else {
                completion(.failure(FetchError.notCorrectData))
                return }
            
            do { let dataFromServer = try JSONDecoder().decode(UserData.self, from: data)
                completion(.success(dataFromServer))
            } catch { completion(.failure(error)) }
        }.resume()
    }
    
    func fetchDataForSecondScreen(completion: @escaping (Result<TicketsOfferArras, Error>) -> Void) {
        
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else {
            completion(.failure(FetchError.invalidURL))
            return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return }
            
            guard let data = data else {
                completion(.failure(FetchError.notCorrectData))
                return }
            
            do { let dataFromServer = try JSONDecoder().decode(TicketsOfferArras.self, from: data)
                completion(.success(dataFromServer))
            } catch { completion(.failure(error)) }
        }.resume()
    }
    
    func fetchDataAllTickets(completion: @escaping (Result<AllTicketsArray, Error>) -> Void) {
        
        guard let url = URL(string: "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf") else {
            completion(.failure(FetchError.invalidURL))
            return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return }
            
            guard let data = data else {
                completion(.failure(FetchError.notCorrectData))
                return }
            
            do { let dataFromServer = try JSONDecoder().decode(AllTicketsArray.self, from: data)
                completion(.success(dataFromServer))
            } catch { completion(.failure(error)) }
        }.resume()
    }
}
