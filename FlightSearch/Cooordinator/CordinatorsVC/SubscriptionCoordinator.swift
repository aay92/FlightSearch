import UIKit

class SubscriptionCoordinator: Coordinator {
    override func start() {
       let vc = SubscriptionsVC()
        vc.view.backgroundColor = .systemGray
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("appCoordinator finish")
    }
}
