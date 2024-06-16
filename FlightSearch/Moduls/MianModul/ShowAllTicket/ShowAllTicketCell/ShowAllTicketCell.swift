import UIKit

class ShowAllTicketCell: UITableViewCell {
    static let identifier = "ShowAllTicketCell"

    private lazy var bgView: UIView = {
        $0.backgroundColor = AppColors.bgShowAllTicketCell
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())
    
    private lazy var badgeLabel: UILabel = {
        $0.text = " "
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        $0.backgroundColor = AppColors.colorBellFill
        $0.textColor = AppColors.textColorTFFrom
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.font = UIFont.italicSystemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
   
    private lazy var costTicket: UILabel = {
        $0.text = " "
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 22, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var timeToTrip: UILabel = {
        $0.text = " "
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let circleLabel: UILabel = {
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var avioLineLabel: UILabel = {
        $0.text = " "
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = AppColors.textColorDown
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setConfigure(data: Ticket){
        if data.badge == nil { self.badgeLabel.isHidden = true }
        else { self.badgeLabel.text = data.badge }
        
        guard let price = data.price.value else { return }
        costTicket.text = String(price) + " ₽"
        
        let dateDeparture = getTime(data: data.departure.date)
        let dateArrival = getTime(data: data.arrival.date)

        let difirentNum = getDifferentBetweenTwoDate(firstDate: data.departure.date, secondDate: data.arrival.date)
        
        avioLineLabel.text =
        data.departure.airport.rawValue + "  " +  data.arrival.airport.rawValue
                
        data.hasTransfer
        ? (timeToTrip.text = dateDeparture + "-" + dateArrival + " " + difirentNum + " ч в пути" + " / Без пересадок")
        : (timeToTrip.text = dateDeparture + "-" + dateArrival + " " + difirentNum + " ч в пути")
    }
    
    private func setConstraint(){
        backgroundColor = .clear
        [bgView,
         costTicket,
         timeToTrip,
         circleLabel,
         avioLineLabel,
         badgeLabel
        ].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            badgeLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: -10),
            badgeLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            badgeLabel.heightAnchor.constraint(equalToConstant: 21),
            badgeLabel.widthAnchor.constraint(equalToConstant: 126),

            costTicket.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 21),
            costTicket.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            costTicket.heightAnchor.constraint(equalToConstant: 26),
            
            circleLabel.topAnchor.constraint(equalTo: costTicket.bottomAnchor, constant: 23),
            circleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            circleLabel.heightAnchor.constraint(equalToConstant: 24),
            circleLabel.widthAnchor.constraint(equalToConstant: 24),
            
            timeToTrip.topAnchor.constraint(equalTo: costTicket.bottomAnchor, constant: 23),
            timeToTrip.leadingAnchor.constraint(equalTo: circleLabel.trailingAnchor, constant: 8),
            timeToTrip.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            timeToTrip.heightAnchor.constraint(equalToConstant: 24),
            
            avioLineLabel.topAnchor.constraint(equalTo: timeToTrip.bottomAnchor, constant: 4),
            avioLineLabel.leadingAnchor.constraint(equalTo: circleLabel.trailingAnchor, constant: 8),
            avioLineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            avioLineLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

//MARK: - Логика получения времени прилета и отлета
extension ShowAllTicketCell {
    private func getTime(data: String) -> String {
        var finalTime = ""
        let dateArrival = data
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "ru_RU")
        dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date1 = dateFormatter1.date(from:dateArrival)!
        let calendar1 = Calendar.current
        let components1 = calendar1.component(.hour , from: date1)
        let components2 = calendar1.component(.minute , from: date1)
        
        components1 == 0
        ? (finalTime = "\(components1)" + "0" + ":" + "\(components2)")
        : (finalTime = "\(components1)" + ":" + "\(components2)")
        components2 == 0
        ? (finalTime = "\(components1)" + ":" + "\(components2)" + "0")
        : (finalTime = "\(components1)" + ":" + "\(components2)")
        return finalTime
    }
    
    private func getSumMinutes(data: String ) -> Double {
        let dateArrival = data
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "ru_RU")
        dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date1 = dateFormatter1.date(from: dateArrival)!
        let calendar1 = Calendar.current
        var components1 = calendar1.component(.hour , from: date1)
        if components1 == 0 { components1 = 24 }
        let components2 = calendar1.component(.minute , from: date1)
        let finalSum = Double ((components1 * 60) + components2)
        return finalSum
    }
    
    private func getDifferentBetweenTwoDate(firstDate: String, secondDate: String) -> String {
        let oneNum = getSumMinutes(data: firstDate)
        let twoNum = getSumMinutes(data: secondDate)
        let finalNum = String(((twoNum - oneNum) / 60).rounded(toPlaces: 1))
        return finalNum
    }
}
