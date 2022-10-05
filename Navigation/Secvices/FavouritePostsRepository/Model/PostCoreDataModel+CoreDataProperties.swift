//
//  PostCoreDataModel+CoreDataProperties.swift
//  Navigation
//
//  Created by Николай Казанин on 05.10.2022.
//

import StorageService
import CoreData

extension PostCoreDataModel {
    @NSManaged var author: String
    @NSManaged var body: String
    @NSManaged var image: String
    @NSManaged var likes: Int64
    @NSManaged var views: Int64
    
    static func create(with post: Post, using context: NSManagedObjectContext) {
        PostCoreDataModel(context: context)
            .with {
                $0.author = post.author
                $0.body = post.description
                $0.image = post.image
                $0.likes = Int64(post.likes)
                $0.views = Int64(post.views)
            }
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    func toPost() -> Post {
        Post(
            author: author,
            description: body,
            image: image,
            likes: Int(likes),
            views: Int(views)
        )
    }
}
