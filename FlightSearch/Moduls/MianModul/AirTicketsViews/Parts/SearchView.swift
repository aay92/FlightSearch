import UIKit

final class SearchView: UIView {

    private lazy var bgView: UIView = {
        $0.backgroundColor = AppColors.bgUpperSearchViewView
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = false
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = .init(width: 0, height: 5)
        $0.layer.shadowOpacity = 5.0
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())
    
    private let imageSearch: UIImageView = {
        $0.image = .search
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var fromCountry: UILabel = {
        $0.text = "Минск"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = AppColors.textColorTFFrom
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var viewBetweenViews: UIView = {
        $0.backgroundColor = AppColors.lineBetweenTextField
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())
    
    private lazy var whatCountry: UILabel = {
        $0.text = "Куда - Турция"
        $0.textColor = AppColors.textColorTFWhere
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 16, weight: .regular)
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
        backgroundColor = AppColors.bgSearchView
        [bgView,
         imageSearch,
         fromCountry,
         viewBetweenViews,
         whatCountry,
        ].forEach(addSubview(_:))
 
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            imageSearch.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            imageSearch.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            imageSearch.heightAnchor.constraint(equalToConstant: 24),
            imageSearch.widthAnchor.constraint(equalToConstant: 24),
            
            fromCountry.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            fromCountry.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 49),
            fromCountry.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -49),
            fromCountry.heightAnchor.constraint(equalToConstant: 21),
            
            viewBetweenViews.topAnchor.constraint(equalTo: fromCountry.bottomAnchor, constant: 8),
            viewBetweenViews.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 49),
            viewBetweenViews.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -49),
            viewBetweenViews.heightAnchor.constraint(equalToConstant: 1),
            
            whatCountry.topAnchor.constraint(equalTo: viewBetweenViews.bottomAnchor, constant: 8),
            whatCountry.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 49),
            whatCountry.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -49),
            whatCountry.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
        ])
    }
}
