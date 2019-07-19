//
//  ViewController.swift
//  LearningFetching
//
//  Created by Rong Xiao on 7/18/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import UIKit
import BrightFutures

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let courses = [Course]()
        
        var f = Future<[Course], Error>()
        f = fetchCoursesJSON()
        f.onSuccess { (courses) in
            courses.forEach({ (course) in
                print(course.name ?? "No name")
            })
        }
        f.onFailure { (err) in
            print(err)
        }
        
        
//        fetchCoursesJSON { (res) in
//            switch res {
//            case .success(let courses):
//                courses.forEach({ (course) in
//                    print(course.name ?? "No name")
//                })
//                
//            case.failure(let err):
//                print("fetching error ", err)
//            }
//        }
        
//        fetchCoursesJSON { (courses, error) in
//            if let err = error{
//                print("Failed to fetch courses", err)
//            }else{
//                courses?.forEach({ (course) in
//                    print(course.name ?? "No status")
//                })
//            }
//        }
    }

    
    func fetchCoursesJSON() -> Future<[Course], Error> {
        print("swift 5 with Future and Promise")
        //let f : Future<[Course],Error> = Future<[Course],Error>()
        let p = Promise<[Course],Error>()
        let urlString = URL(string: "https://api.letsbuildthatapp.com/jsondecodable/courses")
        
        if let url = urlString{
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    //completion(.failure(err))
                    p.failure(err)
                    return
                }
                do{
                    let courses = try JSONDecoder().decode([Course].self,from: data!)
                    p.success(courses)
                }catch let jsonError{
                    p.failure(jsonError)
                }
            }.resume()
        } else {
            print("error converting url string to url")
        }
        return p.future
    }
    
    
//    func fetchCoursesJSON(completion: @escaping (Result<[Course], Error>)->()){
//        print("swift 5 with Result<[Course], Error>")
//        let urlstring = URL(string: "https://api.letsbuildthatapp.com/jsondecodable/courses")
//        guard let url = urlstring else {
//            print("error converting url string to url")
//            return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let err = error {
//                completion(.failure(err))
//                return
//            }
//            do{
//            let courses = try JSONDecoder().decode([Course].self,from: data!)
//                completion(.success(courses))
//            }catch let jsonError{
//                completion(.failure(jsonError))
//            }
//        }.resume()
//    }
    
//    func fetchCoursesJSON(completion: @escaping ([Course]?,Error?) -> ()){
//    print("swift 4.2 with ([Course]?,Error?)")
//        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let err = error{
//                completion(nil, err)
//            }
//            do{
//                let courses = try JSONDecoder().decode([Course].self, from: data!)
//                completion(courses,nil)
//            }catch let jsonError{
//                completion(nil, jsonError)
//            }
//        }.resume()
//    }

}

