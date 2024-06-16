import UIKit

enum CoordinatorType {
    case app
    case profile
    case mainScreen
    case allTicket
    case list
}

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    var navigationController: UINavigationController? { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    func addChildCoordinator(childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(childCoordinator: CoordinatorProtocol){
        childCoordinators = childCoordinators.filter {$0 !== childCoordinator }
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinators: CoordinatorProtocol)
}

protocol TabBarCoordinator: AnyObject, CoordinatorProtocol {
    var tabBarControllerL: UITabBarController? { get set }
}

class Coordinator: CoordinatorProtocol {
    var childCoordinators: [any CoordinatorProtocol]
    var type: CoordinatorType
    var navigationController: UINavigationController?
    var finishDelegate: (any CoordinatorFinishDelegate)?
    
    init(childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](),
         type: CoordinatorType,
         navigationController: UINavigationController,
         finishDelegate: CoordinatorFinishDelegate? = nil) {
        self.childCoordinators = childCoordinators
        self.type = type
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
    }
    
    deinit {
        print("coordinator deinited \(type)")
        childCoordinators.forEach { $0.finishDelegate = nil
            childCoordinators.removeAll()
        }
    }
    
    func start(){
        print("coordinator start")
    }
    
    func finish(){
        print("coordinator finish")
    }
}
