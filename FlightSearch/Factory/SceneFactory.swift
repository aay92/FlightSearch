import UIKit

struct SceneFactory {
    
    static func makeMainFlow(appCoordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate) -> TabBarController {
        
        let airTicketsViewNavigationController = UINavigationController()
        let airTicketsViewCoordinator = AirTicketsViewCoordinator(
            type: .mainScreen,
            navigationController: airTicketsViewNavigationController)
        airTicketsViewNavigationController.tabBarItem = UITabBarItem(
            title: "Авиабилеты",
            image: UIImage(named: "tickets"),
            tag: 0)
        airTicketsViewCoordinator.finishDelegate = finishDelegate
        airTicketsViewCoordinator.start()
        
        let hotelsViewNavigationController = UINavigationController()
        let hotelsViewCoordinator = HotelsViewCoordinator(
            type: .allTicket,
            navigationController: hotelsViewNavigationController)
        hotelsViewNavigationController.tabBarItem = UITabBarItem(
            title: "Отели",
            image:  UIImage(named: "hotels"),
            tag: 1)
        hotelsViewCoordinator.finishDelegate = finishDelegate
        hotelsViewCoordinator.start()
        
        let quickNavigationController = UINavigationController()
        let quickCoordinator = QuickCoordinator(
            type: .list,
            navigationController: quickNavigationController)
        quickNavigationController.tabBarItem = UITabBarItem(
            title: "Короче",
            image:  UIImage(named: "place"),
            tag: 2)
        quickCoordinator.finishDelegate = finishDelegate
        quickCoordinator.start()
        
        let subscriptionNavigationController = UINavigationController()
        let subscriptionCoordinator = SubscriptionCoordinator(
            type: .profile,
            navigationController: subscriptionNavigationController)
        subscriptionNavigationController.tabBarItem = UITabBarItem(
            title: "Подписки",
            image:  UIImage(named: "subs"),
            tag: 3)
        subscriptionCoordinator.finishDelegate = finishDelegate
        subscriptionCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(
            type: .profile,
            navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image:  UIImage(named: "profile"),
            tag: 3)
        profileCoordinator.finishDelegate = finishDelegate
        profileCoordinator.start()
        
        [airTicketsViewCoordinator,
         hotelsViewCoordinator,
         quickCoordinator,
         subscriptionCoordinator,
         profileCoordinator
        ].forEach(appCoordinator.addChildCoordinator(childCoordinator:))
        
        let tabBatControllers = [
            airTicketsViewNavigationController,
            hotelsViewNavigationController,
            quickNavigationController,
            subscriptionNavigationController,
            profileNavigationController
        ]
        
        let tabBarController = TabBarController(
            tabBarControllers: tabBatControllers)
        
        return tabBarController
    }
    
    static func makeSearchViewModel(nav: UINavigationController){
        let searchViewCoordinator = SearchViewCoordinator(type: .mainScreen, navigationController: nav)
        searchViewCoordinator.addChildCoordinator(childCoordinator: searchViewCoordinator)
        searchViewCoordinator.start()
    }
    
    static func makeSearchChooseCountry(nav: UINavigationController, text: String){
        let searchWhenCountrySelectedCoordinator = SearchWhenCountrySelectedCoordinator(
            type: .list,
            navigationController: nav)
        searchWhenCountrySelectedCoordinator.text = text
        searchWhenCountrySelectedCoordinator.addChildCoordinator(childCoordinator: searchWhenCountrySelectedCoordinator)
        searchWhenCountrySelectedCoordinator.start()
    }
    
    static func makeShowAllTicketVC(nav: UINavigationController){
        let showAllTicketCoordinator = ShowAllTicketCoordinator(type: .allTicket, navigationController: nav)
        showAllTicketCoordinator.addChildCoordinator(childCoordinator: showAllTicketCoordinator)
        showAllTicketCoordinator.start()
    }
}
