//
//  FavouritePostsRepository.swift
//  Navigation
//
//  Created by Николай Казанин on 05.10.2022.
//

import Foundation
import StorageService
import CoreData
import Combine

final class FavouritePostsRepository {
    // MARK: - Properties
    private lazy var persistentContainer = NSPersistentContainer(name: "DataModel")
        .with {
            $0.loadPersistentStores { _, error in
                if let error = error { fatalError()  }
            }
        }
    
    static let shared = FavouritePostsRepository()
    
    // MARK: - Private Init
    private init() {}
    
    // MARK: - Methods
    func save(_ post: Post) {
        PostCoreDataModel.create(with: post, using: persistentContainer.viewContext)
    }
    
    func getAllPosts() -> [Post] {
        let request = NSFetchRequest<PostCoreDataModel>(entityName: "PostCoreDataModel")
        guard let fetchRequestResult = try? persistentContainer.viewContext.fetch(request) else { return [] }
        return fetchRequestResult.map { $0.toPost() }
    }
    
    func favouritePostsChangesPublisher() -> AnyPublisher<Void, Never> {

      let notification = NSManagedObjectContext.didSaveObjectsNotification
        return NotificationCenter.default.publisher(for: notification, object: persistentContainer.viewContext)
            .compactMap { _ in Void() }
        .eraseToAnyPublisher()
    }
}
