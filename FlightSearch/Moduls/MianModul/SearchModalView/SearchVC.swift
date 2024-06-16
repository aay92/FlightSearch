import UIKit

class SearchVC: UIViewController {

    var searchViewCoordinator: SearchViewCoordinator?
    var viewModel: SearchViewModel?
    
    private lazy var blockInputFields: BlockInputFields = {
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(BlockInputFields())   
    
    ///После того как сделал этот блок понял ,что удобнее было бы использовать коллекцию, исправит данный момент также не успел
    private lazy var blockChoose: BlockChoose = {
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(BlockChoose())
    
    private lazy var blockHelps: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 296, //self.view.bounds.width * 0.305, //131
                                 height: 56)
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = AppColors.bgBlockChooseCell
        $0.bounces = false
        $0.clipsToBounds = false
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(BlockChooseCell.self, forCellWithReuseIdentifier: BlockChooseCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    internal init(searchViewCoordinator: SearchViewCoordinator? = nil, navigation: UINavigationController) {
        super.init(nibName: nil, bundle: nil)
        self.searchViewCoordinator = SearchViewCoordinator(type: .list, navigationController: navigation)
        self.viewModel = SearchViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        tapGestureDate()
    }
    
    private func setConstraint(){
        view.backgroundColor = AppColors.bgSearchVC
        [blockInputFields,
         blockChoose,
         blockHelps
        ].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            blockInputFields.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),
            blockInputFields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockInputFields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            blockInputFields.heightAnchor.constraint(equalToConstant: 96),

            blockChoose.topAnchor.constraint(equalTo: blockInputFields.bottomAnchor, constant: 26),
            blockChoose.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockChoose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            blockChoose.heightAnchor.constraint(equalToConstant: 90),

            blockHelps.topAnchor.constraint(equalTo: blockChoose.bottomAnchor, constant: 26),
            blockHelps.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockHelps.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            blockHelps.heightAnchor.constraint(equalToConstant: 218),
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension SearchVC: UICollectionViewDelegateFlowLayout,
                    UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.dataForSearchViewCellArray.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BlockChooseCell.identifier,
            for: indexPath) as? BlockChooseCell
        else {
            return UICollectionViewCell()
        }
        if let item = viewModel?.dataForSearchViewCellArray[indexPath.row] {
            cell.setUp(data : item)
            cell.backgroundColor = .clear
        } else {  return UICollectionViewCell() }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = viewModel?.dataForSearchViewCellArray[indexPath.row] {
            blockInputFields.inputTextInTextField(text: item.titleLabel)
            removeBlockChoose()
            dismiss(animated: true)
            searchViewCoordinator?.openSearchChoseCountry(
                text: item.titleLabel)
        }
    }
}

//MARK: - Remove BlockChoose from superview
///Удаляем из иерархии блок с выбором хардорных кнопок
extension SearchVC {
    func removeBlockChoose(){
        ///Немного еле заметной анимации
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.blockChoose.alpha = 0
            self?.blockChoose.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: nil)
        blockChoose.removeFromSuperview()
        
        [blockInputFields,
         blockHelps
        ].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            blockInputFields.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),
            blockInputFields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockInputFields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            blockInputFields.heightAnchor.constraint(equalToConstant: 96),

            blockHelps.topAnchor.constraint(equalTo: blockInputFields.bottomAnchor, constant: 26),
            blockHelps.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockHelps.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            blockHelps.heightAnchor.constraint(equalToConstant: 218),
        ])
        view.setNeedsLayout()
    }
}

//MARK: - Tap Gesture called model vc
extension SearchVC {
    private func tapGestureDate(){
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(didTapAction))
        blockChoose.isUserInteractionEnabled = true
        blockChoose.addGestureRecognizer(tapGestureDate)
    }
    
    @objc func didTapAction(){
        searchViewCoordinator?.backPopViewController()
    }
}
