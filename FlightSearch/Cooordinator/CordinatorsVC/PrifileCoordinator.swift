import UIKit

class ProfileCoordinator: Coordinator {
    override func start() {
       let vc = ProfileVC()
        vc.view.backgroundColor = .systemBlue
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("appCoordinator finish")
    }
}
