import UIKit

final class SwitchBoxView: UIView {
    
    private let imageView: UIImageView = {
        $0.image = UIImage(systemName: "bell.fill")
        $0.tintColor = AppColors.colorBellFill
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var subscribeLabel: UILabel = {
        $0.text = "Подписка на цену"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = AppColors.textColorTFFrom
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
   
    private lazy var switchBox: UISwitch = {
        $0.onTintColor = AppColors.onSwitchColor
        $0.thumbTintColor = AppColors.switchColorTint
        $0.addTarget(self, action: #selector(tapSwitch), for: .valueChanged)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UISwitch())

    init(){
        super.init(frame: .zero)
        setConstraint()
    }
    
    @objc func tapSwitch(){
        switchBox.isOn
        ? (switchBox.thumbTintColor = AppColors.switchColorTintOn)
        : (switchBox.thumbTintColor = AppColors.switchColorTint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint(){
        backgroundColor = AppColors.bgSwitchView
        [imageView,
         subscribeLabel,
         switchBox,
        ].forEach(addSubview(_:))

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            subscribeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            subscribeLabel.leadingAnchor.constraint(equalTo:  imageView.trailingAnchor, constant: 8),
            subscribeLabel.heightAnchor.constraint(equalToConstant: 21),

            switchBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            switchBox.widthAnchor.constraint(equalToConstant: 50),
            switchBox.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
