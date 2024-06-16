import UIKit

class AirTicketCell: UICollectionViewCell {
    
    static let identifier = "AirTicketCell"
    
    private let imageStars: UIImageView = {
        $0.image = UIImage(named: "hotels")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.text = "Die Antwoord"
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont(name: "SF Pro Display", size: 16)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UILabel())
    
    private let countryLabel: UILabel = {
        $0.text = "Будапешт"
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont(name: "SF Pro Display", size: 14)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    private let costLabel: UILabel = {
        $0.text = "от 22 264 ₽ "
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont(name: "SF Pro Display", size: 14)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraints()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(data: ItemData, dataFromServer: Offer){
        let img = data.images.resize(133, 133)
        imageStars.image = img.withRoundedCorners(radius: 8)
        nameLabel.text = dataFromServer.title
        countryLabel.text = dataFromServer.town
        guard let price = dataFromServer.price?.value else { return }
        costLabel.text = String(price)
    }
    
    private func setView(){
        self.clipsToBounds = false
    }
        
    private func setConstraints(){
        [imageStars,
         nameLabel,
         countryLabel,
         costLabel
        ].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            imageStars.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageStars.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageStars.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            nameLabel.topAnchor.constraint(equalTo: imageStars.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 19),
            
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            countryLabel.heightAnchor.constraint(equalToConstant: 17),
            
            costLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 8),
            costLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            costLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            costLabel.heightAnchor.constraint(equalToConstant: 17),
        ])
    }
    
}


