import UIKit

class SearchWhenCountrySelectedVC: UIViewController {
    
    var viewModel: SearchWhenCountrySelectedViewModel?
    var searchWhenCountrySelectedCoordinator: SearchWhenCountrySelectedCoordinator?
    
    var calendarView = UICalendarView()
    
    lazy var blockInputFields: BlockInputCountry = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(BlockInputCountry())
    
    private lazy var bgViewOnPlaneSection: UIView = {
        $0.backgroundColor = AppColors.bgSecondSectionInCollection
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var blockHelps: UICollectionView = {
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(SearchViewTagCell.self, forCellWithReuseIdentifier: SearchViewTagCell.identifier)
        $0.register(SearchCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchCellHeader.identifier)
        $0.register(SearchViewHelper.self, forCellWithReuseIdentifier: SearchViewHelper.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: getCompositionLayout()))
    
    private lazy var showAllButton: UIButton = {
        $0.setTitle("Показать все", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.titleLabel?.textColor = AppColors.textColorSecondSectionInCollection
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private lazy var lookAllTicketButton: UIButton = {
        $0.tintColor = .white
        $0.setTitle("Посмотреть все билеты", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.titleLabel?.font = UIFont(name: "SF Pro Display", size: 16)
        $0.titleLabel?.font = UIFont.italicSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = AppColors.textColorSecondSectionInCollection
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: showAllAction))
    
    private lazy var switchBoxView: SwitchBoxView = {
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(SwitchBoxView())
    
    lazy var showAllAction = UIAction {[weak self] _ in
        self?.searchWhenCountrySelectedCoordinator?.goOnLookAllTicket()
    }
    internal init() {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = SearchWhenCountrySelectedViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ((viewModel?.dataItem) != nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.blockHelps.reloadData()
            }
        } else {
            self.blockHelps.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
    }
    
    private func setConstraint(){
        blockInputFieldsBackButtonAction()
        view.backgroundColor = AppColors.bgSearchVC
        [blockInputFields,
         bgViewOnPlaneSection,
         blockHelps,
         showAllButton,
         lookAllTicketButton,
         switchBoxView
        ].forEach(view.addSubview(_:))

        NSLayoutConstraint.activate([
            blockInputFields.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),
            blockInputFields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockInputFields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            blockInputFields.heightAnchor.constraint(equalToConstant: 96),
            
            bgViewOnPlaneSection.topAnchor.constraint(equalTo: blockHelps.topAnchor, constant: 60),
            bgViewOnPlaneSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgViewOnPlaneSection .trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgViewOnPlaneSection.heightAnchor.constraint(equalToConstant: 288),
            
            blockHelps.topAnchor.constraint(equalTo: blockInputFields.bottomAnchor, constant: 15),
            blockHelps.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockHelps.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            blockHelps.heightAnchor.constraint(equalToConstant: 310),
            
            showAllButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            showAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            showAllButton.heightAnchor.constraint(equalToConstant: 42),
            showAllButton.bottomAnchor.constraint(equalTo: blockHelps.bottomAnchor, constant: 30),
            
            lookAllTicketButton.topAnchor.constraint(equalTo: bgViewOnPlaneSection.bottomAnchor, constant: 18),
            lookAllTicketButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lookAllTicketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lookAllTicketButton.heightAnchor.constraint(equalToConstant: 42),
            
            switchBoxView.topAnchor.constraint(equalTo: lookAllTicketButton.bottomAnchor, constant: 34),
            switchBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            switchBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            switchBoxView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension SearchWhenCountrySelectedVC {
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch section {
            case 0:
                return self?.createTagSection()
            case 1:
                return self?.createAvailableFlightsSection()
            default:
                return nil
            }
        }
    }
    
    private func createAvailableFlightsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(56))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: nil, top: nil, trailing: nil, bottom: .fixed(8))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(210))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    private func createTagSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(110), heightDimension: .estimated(33))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [.init(layoutSize: groupSize)])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(10), top: nil, trailing: .fixed(0), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize:.init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}

extension SearchWhenCountrySelectedVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel?.items[indexPath.row]
        
        if item == self.viewModel?.items[0] {
            setupCalendarView()
        } else if item == self.viewModel?.items[1] {
            setupCalendarView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel?.items.count ?? 0
        case 1:
            return viewModel?.dataItem.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel?.items
        
        switch indexPath.section {
        case 0:
            let cell = blockHelps.dequeueReusableCell(withReuseIdentifier: SearchViewTagCell.identifier, for: indexPath) as! SearchViewTagCell
            cell.cellConfigure(tagText: item![indexPath.row])
            return cell
            
        case 1:
            let cell = blockHelps.dequeueReusableCell(withReuseIdentifier: SearchViewHelper.identifier, for: indexPath) as! SearchViewHelper
            if let item = viewModel?.dataItem[indexPath.row] {
                let itemColor = viewModel?.colorArrays[indexPath.row]
                cell.setUp(data: item,
                           colorCircle: itemColor ?? UIColor.red)
            } else {self.showAlert(withTitle: "Ошибка", withMessage: "Проверьте подключение к интернету :-)")}
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchCellHeader.identifier, for: indexPath) as! SearchCellHeader
        
        header.setHeaderText(header: "Прямые рейсы")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width - 60, height: 40)
    }
    
}
//MARK: - Button action back on popViewController
extension SearchWhenCountrySelectedVC {
    private func blockInputFieldsBackButtonAction(){
        blockInputFields.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    @objc private func backAction(){
        self.searchWhenCountrySelectedCoordinator?.backPopViewController()
    }
}

//MARK: - Настройка окна с календарем
extension SearchWhenCountrySelectedVC {
    private func setupCalendarView() {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ru_RU")
        calendarView.fontDesign = .rounded
        calendarView.backgroundColor = .secondarySystemBackground
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 10.0
        calendarView.tintColor = UIColor.systemTeal
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        calendarView.delegate = self
        calendarView.wantsDateDecorations = true
        calendarView.availableDateRange = DateInterval.init(start: Date.now, end: Date.distantFuture)
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            calendarView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}
//MARK: - UICalendarViewDelegate
extension SearchWhenCountrySelectedVC: UICalendarViewDelegate {}

//MARK: - UICalendarSelectionSingleDateDelegate
extension SearchWhenCountrySelectedVC: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let componentsDay = dateComponents?.day else { return }
        getDayFromCalendar(day: componentsDay)
        calendarView.removeFromSuperview()
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
}
///Метод по замене тэга на данные из календаря
extension SearchWhenCountrySelectedVC {
    private func getDayFromCalendar(day: Int){
        viewModel?.items[1] = String(day)
        self.blockHelps.reloadData()
    }
}
