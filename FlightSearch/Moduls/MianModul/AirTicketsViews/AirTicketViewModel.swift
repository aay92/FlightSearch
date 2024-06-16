import UIKit

protocol AirTicketViewModelProtocol: AnyObject {
    var networkService: NetworkService? { get }
    func getDataFromServerOnOneScreen()
}

final class AirTicketViewModel: AirTicketViewModelProtocol {
    ///Network injection
    var networkService: NetworkService?
    var dataFromLocalStorage = ItemDataArray.dataForOneSreene

    ///Dynamic arrays with data
    var dataItem: [Offer] = [] {
        didSet { self.dataItem = self.privateDataItem }
    }
    
    // Property caps
    let itemCap = Offer(id: 0, title: "", town: "", price: nil)
    let itemDataCap = ItemData(images: UIImage.holiday, name: "", tag: 0)
    
    ///Private property
    private var privateDataItem = [Offer]()
    
    init() {
        self.networkService = NetworkService()
        getDataFromServerOnOneScreen()
    }

    internal func getDataFromServerOnOneScreen() {
        dataItem = []
        do { networkService?.fetchDataForFirstScreen { [weak self] result in
            guard let self = self else { return }
                switch result {
                case .success(let dataFromServer):
                    DispatchQueue.main.async {
                        self.privateDataItem = dataFromServer.offers
                        self.dataItem = self.privateDataItem
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)") }
            }
        }
    }
}
