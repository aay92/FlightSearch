
import UIKit

// MARK: - UserImageElement
struct UserImageElement: Codable, Hashable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

// MARK: - UserData
struct UserData: Codable {
    let offers: [Offer]
}

// MARK: - Offer
struct Offer: Codable {
    let id: Int?
    let title, town: String?
    let price: Price?
}

// MARK: - Price
struct Price: Codable {
    let value: Int?
}


// MARK: - UserImage
struct TicketsOfferArras: Codable {
    let ticketsOffers: [TicketsOffer]

    enum CodingKeys: String, CodingKey {
        case ticketsOffers = "tickets_offers"
    }
}

// MARK: - TicketsOffer
struct TicketsOffer: Codable {
    let id: Int?
    let title: String?
    let timeRange: [String]?
    let price: Price?

    enum CodingKeys: String, CodingKey {
        case id, title
        case timeRange = "time_range"
        case price
    }
}

// MARK: - UserImage
struct AllTicketsArray: Codable {
    let tickets: [Ticket]
}

// MARK: - Ticket
struct Ticket: Codable {
    let id: Int
    let badge: String?
    let price: Price
    let providerName, company: String
    let departure, arrival: Arrival
    let hasTransfer, hasVisaTransfer: Bool
    let luggage: Luggage
    let handLuggage: HandLuggage
    let isReturnable, isExchangable: Bool

    enum CodingKeys: String, CodingKey {
        case id, badge, price
        case providerName = "provider_name"
        case company, departure, arrival
        case hasTransfer = "has_transfer"
        case hasVisaTransfer = "has_visa_transfer"
        case luggage
        case handLuggage = "hand_luggage"
        case isReturnable = "is_returnable"
        case isExchangable = "is_exchangable"
    }
}

// MARK: - Arrival
struct Arrival: Codable {
    let town: Town
    let date: String
    let airport: Airport
}

enum Airport: String, Codable {
    case aer = "AER"
    case vko = "VKO"
}

enum Town: String, Codable {
    case москва = "Москва"
    case сочи = "Сочи"
}

// MARK: - HandLuggage
struct HandLuggage: Codable {
    let hasHandLuggage: Bool
    let size: String?

    enum CodingKeys: String, CodingKey {
        case hasHandLuggage = "has_hand_luggage"
        case size
    }
}

// MARK: - Luggage
struct Luggage: Codable {
    let hasLuggage: Bool
    let price: Price?

    enum CodingKeys: String, CodingKey {
        case hasLuggage = "has_luggage"
        case price
    }
}
