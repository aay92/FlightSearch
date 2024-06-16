
import UIKit

protocol SearchWhenCountrySelectedViewModelProtocol: AnyObject {
    var networkService: NetworkService? { get }
    func getDataTickets()
}

final class SearchWhenCountrySelectedViewModel: SearchWhenCountrySelectedViewModelProtocol {
    ///Network injection
    var networkService: NetworkService?
    var postItem = TagItem.getDate()

    var items = TagItem.getDate()
    ///Dynamic arrays with data
    var dataItem: [TicketsOffer] = [] {
        didSet { self.dataItem = self.privateDataItem }
    }
    
    var colorArrays = [UIColor.red, UIColor.blue, UIColor.white]
    var postItemCount = TagItem.getDate().count
    ///Private property
    private var privateDataItem = [TicketsOffer]()
    
    init() {
        self.networkService = NetworkService()
        getDataTickets()
    }

    internal func getDataTickets() {
        dataItem = []
        do { networkService?.fetchDataForSecondScreen { [weak self] result in
            guard let self = self else { return }
                switch result {
                case .success(let dataFromServer):
                    DispatchQueue.main.async {
                        self.privateDataItem = dataFromServer.ticketsOffers
                        self.dataItem = self.privateDataItem
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)") }
            }
        }
    }
}
