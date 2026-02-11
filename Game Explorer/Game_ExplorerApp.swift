import SwiftUI
import FirebaseCore

@main
struct Game_ExplorerApp: App {
    
    @StateObject private var container = AppContainer()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(container)
        }
    }
}
