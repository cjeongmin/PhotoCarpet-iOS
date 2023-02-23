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
        NavigationView {
            List {
                NavigationLink {
                    EnrollView(isEdit: .constant(false))
                } label: {
                    Text("등록")
                }
                .isDetailLink(false)
                
                NavigationLink {
                    ExhibitionMainView()
                        .onAppear {
                            // TODO: request data from server
                            exhibitionData.setDummyData()
                        }
                } label: {
                    Text("전시회 클릭시")
                }
                .isDetailLink(false)
            }
        }
        .navigationViewStyle(.stack)
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
