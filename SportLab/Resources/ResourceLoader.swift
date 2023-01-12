//
//  ResourceLoader.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Синглтон. Фасад для работы с БД.

import UIKit

protocol ResourceLoaderProvider {
    var resourceLoader: ResourceLoader { get }
}

protocol ResourceLoaderProtocol {
    
}

class ResourceLoader: ResourceLoaderProtocol {
    static let shared = ResourceLoader()
    
    //MARK: - Public
    var bigPosts = [Post]()
    var smallArticles = [Post]()
    var exercises: [Exercise]?
    var userData: UserData?
    var training: [Training]?
    
    func loadAppData() {
        coreDataManager.whereIsDB()
        
        let jsonParser = JSONParser()
        taskGroup.enter()
        jsonParser.getExercises { exercises in
            self.exercises = exercises
            self.taskGroup.leave()
        }
        taskGroup.enter()
        jsonParser.getPosts(type: .bigPost) { posts in
            self.bigPosts = posts
            self.taskGroup.leave()
        }
        taskGroup.enter()
        jsonParser.getPosts(type: .smallArticle) { posts in
            self.smallArticles = posts
            self.taskGroup.leave()
        }
        taskGroup.wait()
        taskGroup.notify(queue: .main) {
            NotificationCenter.default.post(name: Notification.Name.successLoadingAppData, object: nil)
        }
    }
    
    func loadUserData() {
        loadTraining()
    }
    
    func loadTraining() {
        coreDataManager.loadTraining { training in
            self.training = training
        }
    }
    
    func save(userTraining: Training) {
        coreDataManager.save(training: userTraining)
    }
    
    //MARK: - Private
    private let coreDataManager = CoreDataManager()
    
    private let taskGroup = DispatchGroup()
}
