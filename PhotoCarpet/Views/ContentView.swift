//
//  ContentView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var exhibitionData: ExhibitionData
    
    var body: some View {
        MainHome()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ExhibitionData())
    }
}

struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
    
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        return nil
    }
}
