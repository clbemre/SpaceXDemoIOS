//
//  Swinject+Extensions.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import Moya
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension Container {

    func registerAuthAllComponents() {

        self.register(MoyaProvider<SpaceXService>.self) { (resolver) in
            return createMoyaProvider2(targetType: SpaceXService.self)
        }.inObjectScope(.container)

        self.autoregister(SpaceXRepository.self, initializer: SpaceXRepository.init(provider:))

        // List View Controller
        self.autoregister(ListViewModel.self, initializer: ListViewModel.init(repository:))
        
        self.register(ListViewController.self) { (resolver) -> ListViewController in
            let vc = ListViewController()
            vc.viewModel = resolver.resolve(ListViewModel.self)
            return vc
        }

        // LaunchDetailViewController
        self.autoregister(LaunchDetailViewModel.self, initializer: LaunchDetailViewModel.init(repository:))
        
        self.register(LaunchDetailViewController.self) { (resolver) -> LaunchDetailViewController in
            let vc = LaunchDetailViewController()
            vc.viewModel = resolver.resolve(LaunchDetailViewModel.self)
            return vc
        }
    }
}
