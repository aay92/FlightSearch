import UIKit

class SearchWhenCountrySelectedCoordinator: Coordinator {
    
    var text: String = ""
    
    override func start() {
        if navigationController != nil {
            guard let nav = navigationController else { return }
            let vc = SearchWhenCountrySelectedVC()
            vc.blockInputFields.updateText(text: text)
            vc.searchWhenCountrySelectedCoordinator = self
            vc.view.backgroundColor = AppColors.bgView
            nav.pushViewController(vc, animated: true)
            nav.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override func finish() {
        print("appCoordinator finish")
    }
    
    func backPopViewController(){
        if navigationController != nil {
            guard let nav = navigationController else { return }
            nav.popToRootViewController(animated: true)
        }
    }
    
    func goOnLookAllTicket(){
        if navigationController != nil {
            guard let nav = navigationController else { return }
            SceneFactory.makeShowAllTicketVC(nav: nav)
        }
    }
}
