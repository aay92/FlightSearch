import UIKit

class SearchViewCoordinator: Coordinator {
    
    override func start() {
        if navigationController != nil {
            guard let nav = navigationController else { return }
            let vc = SearchVC( navigation: nav )
            nav.modalPresentationStyle = .popover
            nav.present(vc, animated: true)
        }
    }
    
    override func finish() {
        print("appCoordinator finish")
    }
    
    func openSearchChoseCountry(text: String){
        if navigationController != nil {
            guard let nav = navigationController else { return }
            SceneFactory.makeSearchChooseCountry(nav: nav, text: text)
        }
    }
    
    func backPopViewController(){
        if navigationController != nil {
            guard let nav = navigationController else { return }
            nav.dismiss(animated: true)
        }
    }
}
