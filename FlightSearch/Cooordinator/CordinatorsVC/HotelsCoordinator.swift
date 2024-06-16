import UIKit

class HotelsViewCoordinator: Coordinator {
    
    override func start() {
       let vc = HotelsVC()
        vc.view.backgroundColor = .systemTeal
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("appCoordinator finish")
    }
    
    func openModalView(){
        let vc = HotelsVC()
        vc.view.backgroundColor = .systemTeal
        vc.modalPresentationStyle = .popover
        vc.present(vc, animated: true)
    }
}
