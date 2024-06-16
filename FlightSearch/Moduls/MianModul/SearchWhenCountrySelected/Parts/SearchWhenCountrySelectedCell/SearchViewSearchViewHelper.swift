import UIKit

class SearchViewHelper: UICollectionViewCell {
    
    static let identifier = "SearchViewHelper"
    
    private lazy var bgLine: UIView = {
        $0.backgroundColor = AppColors.bgUpperSearchViewView
        $0.layer.masksToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())
    
    private let circleLabel: UILabel = {
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let nameLabel: UILabel = {
        $0.text = "Уральские авиалини"
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont(name: "SF Pro Display", size: 14)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.font = UIFont.italicSystemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.text = "08:05  09:55   16:35  18:55"
        $0.textColor = AppColors.blockChooseCellColorSecondtext
        $0.textAlignment = .left
        $0.font = UIFont(name: "SF Pro Display", size: 14)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UILabel())
    
    private let costLabel: UILabel = {
        $0.text = "2 390 ₽"
        $0.textColor = AppColors.textColorSecondSectionInCollection
        $0.textAlignment = .left
        $0.font = UIFont(name: "SF Pro Display", size: 14)
        $0.font = UIFont.italicSystemFont(ofSize: 14)
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
    
    func setUp(data: TicketsOffer, colorCircle: UIColor){
        changesCircleLabel(color: colorCircle)
        nameLabel.text = data.title
        descriptionLabel.text = data.timeRange?.joined(separator: " ")
        guard let price = data.price?.value else { return }
        costLabel.text = String(price) + " ₽"
    }
    
    private func setView(){
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
    }
    
    private func changesCircleLabel(color: UIColor){
        circleLabel.backgroundColor = color
    }
    
    private func setConstraints(){
        [circleLabel,
         nameLabel,
         descriptionLabel,
         bgLine,
         costLabel
        ].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            circleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            circleLabel.heightAnchor.constraint(equalToConstant: 24),
            circleLabel.widthAnchor.constraint(equalToConstant: 24),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: circleLabel.trailingAnchor , constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 19),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: circleLabel.trailingAnchor , constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 19),
            
            bgLine.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            bgLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 8),
            bgLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bgLine.heightAnchor.constraint(equalToConstant: 2),
            
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            costLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            costLabel.heightAnchor.constraint(equalToConstant: 17),
        ])
    }
}


