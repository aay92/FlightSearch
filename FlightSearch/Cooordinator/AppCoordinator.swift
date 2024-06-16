import UIKit

class AppCoordinator: Coordinator {
    
    private let factory = SceneFactory.self
    override func start() {
        showMainFlow()
    }
}

//MARK: - Navigation methods
private extension AppCoordinator {
    
    func showMainFlow(){
        guard let navigationController = navigationController else { return }
        let tabBarController = factory.makeMainFlow(appCoordinator: self, finishDelegate: self)
        navigationController.pushViewController(
            tabBarController, animated: true)
    }
}

extension AppCoordinator:CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinators: any CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator: childCoordinators)
        switch childCoordinators.type {
            
        case .app:
            return
        case .profile:
            navigationController?.viewControllers.removeAll()
            showMainFlow()
        case .mainScreen:
            break
        case .allTicket:
            break
        case .list:
            break
        }
    }
}
