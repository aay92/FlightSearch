import UIKit

class ShowAllTicketCoordinator: Coordinator {
    
    override func start() {
        if navigationController != nil {
            guard let nav = navigationController else { return }
            let vc = ShowAllTicketVC(navigation: nav)
            vc.view.backgroundColor = AppColors.bgView
            nav.pushViewController(vc, animated: true)
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
}
