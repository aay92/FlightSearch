import UIKit

final class BlockChoose: UIView {
    
    var data: [ItemData] = ItemDataArray.data

    private lazy var labelStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 5
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private lazy var imagesStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 20
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    init(){
        super.init(frame: .zero)
        setConstraint()
//        tapGestureDate()
        data.forEach {
            let str = getUILabels(tag: $0.tag, text: $0.name)
            let img = getImages(tag: $0.tag, image: $0.images)
            labelStack.addArrangedSubview(str)
            imagesStack.addArrangedSubview(img)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint(){
        [
            labelStack,
            imagesStack
        ].forEach(addSubview(_:))
        
        NSLayoutConstraint.activate([
            imagesStack.topAnchor.constraint(equalTo: topAnchor),
            imagesStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  16),
            imagesStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            labelStack.topAnchor.constraint(equalTo: imagesStack.bottomAnchor, constant: 8),
            labelStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension BlockChoose {
    private func getUILabels(tag:Int, text: String) -> UILabel {
        return {
            $0.tag = tag
            $0.text = text
            $0.textColor = .white
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.font = UIFont(name: "SF Pro Display", size: 14)
            $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UILabel())
    }
    
    private func getImages(tag:Int, image: UIImage) -> UIImageView {
        return {
            $0.tag = tag
            $0.image = image
            $0.layer.cornerRadius = 16
            $0.widthAnchor.constraint(equalToConstant: 48).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UIImageView())
    }
}

////MARK: - Tap Gesture called model vc
//extension BlockChoose {
//    func tapGestureDate(){
//        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(didTapAction))
//        imagesStack.isUserInteractionEnabled = true
//        imagesStack.addGestureRecognizer(tapGestureDate)
//    }
//    
//    @objc func didTapAction(){
//        print("tap from BlockChoose item \(imagesStack)")
//    }
//}
