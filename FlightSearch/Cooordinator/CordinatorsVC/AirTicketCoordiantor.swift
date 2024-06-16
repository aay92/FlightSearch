import UIKit

class AirTicketsViewCoordinator: Coordinator {
    override func start() {
        if navigationController != nil {
            guard let nav = navigationController else { return }
            let vc = AirTicketsVC(navigation: nav)
            vc.view.backgroundColor = AppColors.bgView
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func finish() {
        print("appCoordinator finish")
    }
    
    func goSearchModelView(){
        if navigationController != nil {
            guard let nav = navigationController else { return }
            SceneFactory.makeSearchViewModel(nav: nav)
        }
    }
  
}
