import UIKit

class BlockChooseCell: UICollectionViewCell {
    
    static let identifier = "BlockChooseCell"
    
    private lazy var bgLine: UIView = {
        $0.backgroundColor = AppColors.bgUpperSearchViewView
        $0.layer.masksToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())
    
    private let imageStars: UIImageView = {
        $0.image = .hard
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.text = "Стамбул"
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont(name: "SF Pro Display", size: 14)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.text = "Популярное направление"
        $0.textColor = AppColors.blockChooseCellColorSecondtext
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
    
    func setUp(data: DataForSearchViewCell){
        let img = data.images.resize(40, 40)
        imageStars.image = img.withRoundedCorners(radius: 8)
        nameLabel.text = data.titleLabel
        descriptionLabel.text = data.descriptionLabel
    }
    
    private func setView(){
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
    }
        
    private func setConstraints(){
        [imageStars,
         nameLabel,
         descriptionLabel,
         bgLine
        ].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            imageStars.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageStars.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageStars.heightAnchor.constraint(equalToConstant: 40),
            imageStars.widthAnchor.constraint(equalToConstant: 40),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageStars.trailingAnchor , constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 19),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageStars.trailingAnchor , constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 19),
            
            bgLine.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            bgLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 8),
            bgLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bgLine.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}


