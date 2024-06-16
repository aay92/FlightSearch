import UIKit

class QuickCoordinator: Coordinator {
    override func start() {
       let vc = QuickVC()
        vc.view.backgroundColor = .systemBlue
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("appCoordinator finish")
    }
}
