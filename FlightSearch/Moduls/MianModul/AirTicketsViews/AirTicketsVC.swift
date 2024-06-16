import UIKit

class AirTicketsVC: UIViewController {
 
    var airTicketViewModel: AirTicketViewModel?
    var airTicketsViewCoordinator: AirTicketsViewCoordinator?
        
    private lazy var header: UILabel = {
        $0.text = "Поиск дешёвых авиабилетов"
        $0.numberOfLines = 0
        $0.font = UIFont(name: "SF Pro Display", size: 22)
        $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var searchView: SearchView = {
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(SearchView())
    
    private lazy var musicLabel: UILabel = {
        $0.text = "Музыкально отлететь"
        $0.numberOfLines = 0
        $0.font = UIFont(name: "SF Pro Display", size: 22)
        $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var collectionRecommendView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.view.bounds.width * 0.305, //131
                                 height: 212)
        layout.minimumLineSpacing = 67
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.bounces = false
        $0.clipsToBounds = false
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(AirTicketCell.self, forCellWithReuseIdentifier: AirTicketCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    internal init(airTicketsViewCoordinator: AirTicketsViewCoordinator? = nil, navigation: UINavigationController) {
        super.init(nibName: nil, bundle: nil)
        self.airTicketsViewCoordinator = AirTicketsViewCoordinator(type: .list, navigationController: navigation)
        self.airTicketViewModel = AirTicketViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkItemElement()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        tapGestureDate()
    }
    
    private func setConstraint(){
        [header,
         searchView,
         musicLabel,
         collectionRecommendView
        ].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            header.heightAnchor.constraint(equalToConstant: 70),

            searchView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 38),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchView.heightAnchor.constraint(equalToConstant: 122),
           
            musicLabel.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 32),
            musicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            musicLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            musicLabel.heightAnchor.constraint(equalToConstant: 26),

            collectionRecommendView.topAnchor.constraint(equalTo: musicLabel.bottomAnchor, constant: 26),
            collectionRecommendView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionRecommendView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionRecommendView.heightAnchor.constraint(equalToConstant: 215),
        ])
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AirTicketsVC: UICollectionViewDelegate,
                        UICollectionViewDelegateFlowLayout,
                        UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return airTicketViewModel?.dataItem.count ?? 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AirTicketCell.identifier,
            for: indexPath) as? AirTicketCell
        else {
            return UICollectionViewCell()
        }
        let dataFromServer = airTicketViewModel?.dataItem[indexPath.row]
        let dataFromLocalStorage = airTicketViewModel?.dataFromLocalStorage[indexPath.row]
        cell.setUp(
            data:
                (dataFromLocalStorage ?? airTicketViewModel?.itemDataCap)!,
            dataFromServer:
                (dataFromServer ?? airTicketViewModel?.itemCap)!)
        cell.backgroundColor = .clear
        return cell
    }
}

//MARK: - Tap Gesture called model vc
extension AirTicketsVC {
    func tapGestureDate(){
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(didTapAction))
        searchView.isUserInteractionEnabled = true
        searchView.addGestureRecognizer(tapGestureDate)
    }
    
    @objc func didTapAction(){        
        airTicketsViewCoordinator?.goSearchModelView()
    }
}
//MARK: - Проверяем наличие элементов в массиве
extension AirTicketsVC {
    private func checkItemElement(){
        guard let check = self.airTicketViewModel?.dataItem.isEmpty
        else { return }
        
        check
        ? (DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.collectionRecommendView.reloadData()})
        : (DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.collectionRecommendView.reloadData()})
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let check = self.airTicketViewModel?.dataItem.isEmpty
            else { return }
            if check {
                self.showAlert(withTitle: "Ошибка", withMessage: "Проверьте подключение к интернету :-)")
            }
        }
     }
}

