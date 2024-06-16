import UIKit

struct ItemData {
    let images: UIImage
    let name: String
    let tag: Int
}

struct ItemDataArray {
    static var data: [ItemData] = [
        ItemData(images: .hard, name: "Сложный мрашрут", tag: 10),
        ItemData(images: .where, name: "Куда угожно", tag: 20),
        ItemData(images: .holiday, name: "Выходные", tag: 30),
        ItemData(images: .fire, name: "Горячие билеты", tag: 40)
    ]
    
    static var dataForOneSreene: [ItemData] = [
        ItemData(images: ._11, name: "Сложный мрашрут", tag: 10),
        ItemData(images: ._22, name: "Куда угожно", tag: 20),
        ItemData(images: ._33, name: "Выходные", tag: 30),
    ]
}

struct DataForSearchViewCell {
    let images: UIImage
    let titleLabel: String
    let descriptionLabel: String
}

struct DataForSearchViewCellArray {
    static var data: [DataForSearchViewCell] = [
        DataForSearchViewCell(images: .img1,
                              titleLabel: "Стамбул",
                              descriptionLabel: "Популярное направление"),
        DataForSearchViewCell(images: .img2,
                              titleLabel: "Сочи",
                              descriptionLabel: "Популярное направление"),
        DataForSearchViewCell(images: .img3,
                              titleLabel: "Сызрань",
                              descriptionLabel: "Популярное направление")
    ]
}

class TagItem {
   static var dataItem: [String] = []

   static func getDate() -> [String] {
       dataItem = []
       dataItem.append("+ обратно")
       let date = Date()
       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "ru_RU")
       dateFormatter.dateFormat = "LLLL"
       let dayInWeek = dateFormatter.string(from: date)
       let dayDate = String(Date().dayNumberOfWeek()!)
       dataItem.append("\(dayDate) \(dayInWeek)")
       dataItem.append("1.эконом")
       return dataItem
    }
    
}


