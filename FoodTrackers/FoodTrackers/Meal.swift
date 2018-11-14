//
//  Meal.swift
//  FoodTrackers
//
//  Created by Admin on 11/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
// Để mã hoá và giải mã chính nó , các bữa ăn cần phải tuân theo NSCoding
// Để phù hợp với NSCoding, Meal cần kế thừa NSObject. NSObject được coi là một lớp cơ sở đình nghĩa một giao diện cơ bản cho hệ thống runtime
class Meal: NSObject, NSCoding {
    // Properties
    var nameMeal: String
    var photo: UIImage?
    var rating: Int
    
    // Archiving paths
    
//    DocumentsDirectory sử dụng các url của trình quản lý tệp để tra cứu URL cho thư mục tài liệu của ứng dụng.
//    đây là thư mực mà ứng dụng có thể lưu trữ giữ liệu cho người dùng. Phương thức này trả về một mảng các URL
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    // Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    // Initialization
    init?(nameMeal: String, photo: UIImage?, rating: Int) {
        guard !nameMeal.isEmpty else {
            return nil
        }
        
        guard rating > 0 && rating <= 5 else {
            return nil
        }
        
        self.nameMeal = nameMeal
        self.photo = photo
        self.rating = rating
    }
    
//  Phương thức mà bất kì lớp nào sử dụng NSCoding cần phải thực hiện sao cho các cá thể của lớp đó có thể được mã hoá và giải mã
    // chuẩn bị thông tin của lớp được lưu trữ và trình khởi tạo huỷ lưu trữ dữ liệu khi lớp được tao
    // cần triển khai cả phương thức mã hoá và trình khỏi tạo cho dữ liệu để lưu và tải đúng cách
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nameMeal, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
//   triển khai một bộ khởi tạo để mã hoá dữ liệu được mã hoá
    required convenience init?(coder aDecoder: NSCoder) {
//   decodeObject la phương thức giải mã thông tin được mã hoá
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            fatalError("khong the ma hoa nam cua doi tuong Meal")
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
//        Phải gọi bộ khởi tạo được chi định
        self.init(nameMeal: name, photo: photo, rating: rating)
    }
}


