//
//  Course.swift
//  LearningFetching
//
//  Created by Rong Xiao on 7/18/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import Foundation


struct Course: Decodable{
    let id: Int?
    let name: String?
    let imageUrl: String?
    let number_of_lessons: Int?
}
