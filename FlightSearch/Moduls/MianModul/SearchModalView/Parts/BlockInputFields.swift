import UIKit

final class BlockInputFields: UIView {

    private lazy var bgView: UIView = {
        $0.backgroundColor = AppColors.bgUpperSearchViewView
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = false
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        $0.layer.shadowOffset = .init(width: 0, height: 5)
        $0.layer.shadowOpacity = 5.0
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())
    
    private lazy var viewBetweenViews: UIView = {
        $0.backgroundColor = AppColors.lineBetweenTextField
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())

    private lazy var fromCountry: UITextField = {
        let label = UITextField()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.keyboardType = .emailAddress
        label.textAlignment = .left
        label.tintColor = .white
        label.layer.cornerRadius = 10
        label.attributedPlaceholder = NSAttributedString(
            string: "Минск",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        label.leftViewMode = UITextField.ViewMode.always
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var whatCountry: UITextField = {
        let label = UITextField()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.keyboardType = .emailAddress
        label.textAlignment = .left
        label.tintColor = .white
        label.layer.cornerRadius = 10
        label.attributedPlaceholder = NSAttributedString(
            string: "Куда - Турция",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.textColorTFWhere])
        label.leftViewMode = UITextField.ViewMode.always
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        $0.setImage(.krest,for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: closeButtonAction))
    
    private let imagePlane: UIImageView = {
        $0.image = .plane
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let imageSearch: UIImageView = {
        $0.image = .search
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    lazy var closeButtonAction = UIAction { [weak self] _ in
        self?.whatCountry.text = ""
        self?.whatCountry.placeholder = ""
    }
    
    func inputTextInTextField(text: String){
        whatCountry.text = text
    }

    init(){
        super.init(frame: .zero)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint(){
        [bgView,
         fromCountry,
         viewBetweenViews,
         whatCountry,
         deleteButton,
         imagePlane,
         imageSearch
        ].forEach(addSubview(_:))

        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            fromCountry.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            fromCountry.leadingAnchor.constraint(equalTo: imagePlane.trailingAnchor, constant: 8),
            fromCountry.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -49),
            fromCountry.heightAnchor.constraint(equalToConstant: 21),
            
            viewBetweenViews.topAnchor.constraint(equalTo: fromCountry.bottomAnchor, constant: 8),
            viewBetweenViews.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 49),
            viewBetweenViews.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -49),
            viewBetweenViews.heightAnchor.constraint(equalToConstant: 1),
            
            whatCountry.topAnchor.constraint(equalTo: viewBetweenViews.bottomAnchor, constant: 8),
            whatCountry.leadingAnchor.constraint(equalTo:  imageSearch.trailingAnchor, constant: 8),
            whatCountry.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -49),
            whatCountry.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),

            deleteButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -24),
            deleteButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -24),
            deleteButton.heightAnchor.constraint(equalToConstant: 9),
            
            imagePlane.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            imagePlane.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            imagePlane.heightAnchor.constraint(equalToConstant: 24),
            imagePlane.widthAnchor.constraint(equalToConstant: 24),

            imageSearch.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            imageSearch.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            imageSearch.heightAnchor.constraint(equalToConstant: 24),
            imageSearch.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
