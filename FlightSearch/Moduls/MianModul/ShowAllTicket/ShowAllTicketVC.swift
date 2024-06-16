import UIKit

class ShowAllTicketVC: UIViewController {
    
    var showAllTicketCoordinator: ShowAllTicketCoordinator?
    var viewModel: ShowAllTicketViewModel?
    
    private lazy var bgViewNavigationBar: HeaderView = {
        $0.backgroundColor = AppColors.bgSecondSectionInCollection
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(HeaderView())
    
    private lazy var tableView: UITableView = {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(ShowAllTicketCell.self, forCellReuseIdentifier: ShowAllTicketCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    private lazy var filterButton: FilterButton = {
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(FilterButton())
    
    internal init(showAllTicketCoordinator: ShowAllTicketCoordinator? = nil, navigation: UINavigationController) {
        super.init(nibName: nil, bundle: nil)
        self.showAllTicketCoordinator = ShowAllTicketCoordinator(type: .list, navigationController: navigation)
        self.viewModel = ShowAllTicketViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ((viewModel?.dataItem) != nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.reloadData()
            }
        } else { self.tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        setNavigationBarBack()
    }
    
    @objc func backFromHeaderView(){
        showAllTicketCoordinator?.backPopViewController()
    }
    
    private func setNavigationBarBack(){
        bgViewNavigationBar.imageView.addTarget(self, action: #selector(backFromHeaderView), for: .touchUpInside)
    }
    
    private func setConstraint(){
        [bgViewNavigationBar,
         tableView,
         filterButton
        ].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            bgViewNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgViewNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgViewNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgViewNavigationBar.heightAnchor.constraint(equalToConstant: 56),
            
            tableView.topAnchor.constraint(equalTo: bgViewNavigationBar.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            filterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -96),
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 78),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -78),
            filterButton.heightAnchor.constraint(equalToConstant: 37),
        ])
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ShowAllTicketVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  ShowAllTicketCell.identifier, for: indexPath) as! ShowAllTicketCell
        let item = viewModel?.dataItem[indexPath.section]
        cell.setConfigure(data: (item ?? viewModel?.ticketCap)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 150 }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.dataItem.count ?? 0 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 10 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}
