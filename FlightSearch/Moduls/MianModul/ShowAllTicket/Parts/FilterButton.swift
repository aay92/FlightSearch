import UIKit

final class FilterButton: UIView {
    
    private lazy var bgView: UIView = {
        $0.backgroundColor = AppColors.filterButtonBG
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let filterImage: UIImageView = {
        $0.image = .grafik
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 16
        $0.tintColor = AppColors.textColorTFFrom
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let grafikImage: UIImageView = {
        $0.image = .grafik1
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 16
        $0.tintColor = AppColors.textColorTFFrom
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var filterLabel: UILabel = {
        $0.text = "Фильтр"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = AppColors.textColorTFFrom
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.font = .italicSystemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var grafikLabel: UILabel = {
        $0.text = "График цен"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = AppColors.textColorTFFrom
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.font = .italicSystemFont(ofSize: 14)
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
        [bgView,
         filterImage,
         filterLabel,
         grafikImage,
         grafikLabel
        ].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            filterImage.heightAnchor.constraint(equalToConstant: 24),
            
            filterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: filterImage.trailingAnchor, constant: 4),
            filterLabel.heightAnchor.constraint(equalToConstant: 17),
            
            grafikImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            grafikImage.trailingAnchor.constraint(equalTo: grafikLabel.leadingAnchor, constant: -4),
            grafikImage.heightAnchor.constraint(equalToConstant: 24),
            
            grafikLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            grafikLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            grafikLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
