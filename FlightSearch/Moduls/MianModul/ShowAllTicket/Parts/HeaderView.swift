import UIKit

final class HeaderView: UIView {
    
    lazy var imageView: UIButton = {
        $0.setImage(UIImage(systemName: "arrow.left"),for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private lazy var upLabel: UILabel = {
        $0.text = "Москва-Сочи"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = AppColors.textColorTFFrom
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var downLabel: UILabel = {
        $0.text = "23 февраля, 1 пассажиp"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = AppColors.textColorDown
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    init(){
        super.init(frame: .zero)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint(){
        backgroundColor = AppColors.bgHeaderView
        [imageView,
         upLabel,
         downLabel,
        ].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            upLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            upLabel.leadingAnchor.constraint(equalTo:  imageView.trailingAnchor, constant: 8),
            upLabel.heightAnchor.constraint(equalToConstant: 19),
            
            downLabel.topAnchor.constraint(equalTo: upLabel.bottomAnchor,constant: 4),
            downLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            downLabel.leadingAnchor.constraint(equalTo:  imageView.trailingAnchor, constant: 8),
        ])
    }
}
