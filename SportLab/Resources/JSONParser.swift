//
//  JSONParser.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Парсит JSON файл для ResourceLoader.

import UIKit

class JSONParser {
    
    func getPosts(type: PostType, completion: @escaping ([Post]) -> Void) {
        switch type {
            
        case .bigPost:
            if let path = Bundle.main.path(forResource: "SportLabPosts", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let result = jsonResult as? [String: Any], let postData = result["data"] as? [String:Any] {
                        completion(parseBigPosts(with: postData))
                    }
                } catch {
                    
                }
            }
        case .smallArticle:
            if let path = Bundle.main.path(forResource: "SportLabArticles", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let result = jsonResult as? [String: Any], let postData = result["data"] as? [String:Any] {
                        completion(parseArticles(with: postData))
                    }
                } catch {
                    
                }
            }
        }
        
    }
    
    func getExercises(completion: @escaping ([Exercise]) -> Void) {
        if let path = Bundle.main.path(forResource: "SportLabExercises", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let result = jsonResult as? [String: Any], let exData = result["data"] as? [String:Any] {
                    completion(parseExercises(with: exData))
                }
            } catch {
                
            }
        }
    }
    
    private func parseBigPosts(with data: [String: Any]) -> [Post] {
        guard let postDict = data["posts"] as? [[String: Any]] else {
            return []
        }
        var posts = [Post]()
        for post in postDict {
            if let title = post["title"] as? String,
               let imageName = post["image"] as? String,
               let image = UIImage(named: imageName) {
                let newPost = Post(title: title, image: image)
                posts.append(newPost)
            }
        }
        return posts
    }
    
    private func parseArticles(with data: [String: Any]) -> [Post] {
        guard let postDict = data["articles"] as? [[String: Any]] else {
            return []
        }
        var posts = [Post]()
        for post in postDict {
            if let title = post["title"] as? String,
               let imageName = post["image"] as? String,
               let image = UIImage(named: imageName) {
                let newPost = Post(title: title, image: image)
                posts.append(newPost)
            }
        }
        return posts
    }
    
    private func parseExercises(with data: [String: Any]) -> [Exercise] {
        var exercises = [Exercise]()
        for group in MuscleGroup.allCases {
            if let exDicts = data[group.title] as? [[String:Any]] {
                for exDict in exDicts {
                    if let name = exDict["name"] as? String,
                       let imageName = exDict["image"] as? String {
                        let newExercise = Exercise(name: name, group: group, imageName: imageName)
                        exercises.append(newExercise)
                    }
                }
            }
        }
        return exercises
    }
    
}
