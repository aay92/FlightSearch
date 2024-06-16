import UIKit

protocol ShowAllTicketViewModelProtocol: AnyObject {
    var networkService: NetworkService? { get }
    func getDataAllTickets()
}

final class ShowAllTicketViewModel: ShowAllTicketViewModelProtocol {
    ///Network injection
    var networkService: NetworkService?
    
    ///Dynamic arrays with data
    var dataItem: [Ticket] = [] {
        didSet { self.dataItem = self.privateDataItem }
    }
    
    var colorArrays = [UIColor.red, UIColor.blue, UIColor.white]
    
    ///Private property
    private var privateDataItem = [Ticket]()
    
    let ticketCap = Ticket(
        id: 00000,
        badge: "",
        price: Price(value: nil),
        providerName: "",
        company: "",
        departure: .init(town: .москва, date: "", airport: .vko),
        arrival: .init(town: .сочи, date: "", airport: .aer),
        hasTransfer: false,
        hasVisaTransfer: false,
        luggage: .init(hasLuggage: false, price: nil),
        handLuggage: .init(hasHandLuggage: false, size: ""),
        isReturnable: false,
        isExchangable: false)
    
    init() {
        self.networkService = NetworkService()
        getDataAllTickets()
    }
    
    internal func getDataAllTickets() {
        dataItem = []
        do { networkService?.fetchDataAllTickets { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dataFromServer):
                DispatchQueue.main.async {
                    self.privateDataItem = dataFromServer.tickets
                    self.dataItem = self.privateDataItem
                }
            case .failure(let error):
                print("Request failed with error: \(error)") }
        }
        }
    }
}
