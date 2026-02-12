import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "Data Model")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error: \(error.localizedDescription)")
            }
        }
    }
}
