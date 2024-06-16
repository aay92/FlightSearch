
import UIKit

protocol SearchViewTagCellProtocol{
    static var identifier: String { get }
    init(frame: CGRect)
}

class SearchViewTagCell: UICollectionViewCell, SearchViewTagCellProtocol {
    static let identifier = "SearchViewTagCell"
    
    private lazy var tagView: UIView = {
        $0.backgroundColor = AppColors.bgSecondSectionInCollection
        $0.layer.cornerRadius = 15
        $0.addSubview(self.tagLabel)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var tagLabel: UILabel = {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tagView)
        setConstraint()
    }
    
    private func setConstraint(){
        NSLayoutConstraint.activate([
            tagView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagView.topAnchor.constraint(equalTo: topAnchor),
            tagView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tagLabel.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 8),
            tagLabel.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -8),
            tagLabel.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 20),
            tagLabel.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -20),
            
        ])
    }
    
    func cellConfigure(tagText: String) {
        self.tagLabel.text = tagText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
