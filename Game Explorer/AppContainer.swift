import Foundation
import Combine

final class AppContainer: ObservableObject {
    
    // MARK: Services
    
    lazy var apiService: APIServiceProtocol = APIService()
    lazy var persistenceService: PersistenceServiceProtocol = PersistenceService()
    lazy var firebaseService: FirebaseServiceProtocol = FirebaseService()
    
    // MARK: Repositories
    
    lazy var gameRepository: GameRepositoryProtocol = GameRepository(
        apiService: apiService,
        persistenceService: persistenceService
    )
}
