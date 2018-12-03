//
//  ListMeal.swift
//  FoodTrackers
//
//  Created by Admin on 11/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

class ListMeal: UIViewController {
    var listMeal = [Meal]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test sourceTree")
        print("test tiep sourceTreeß")
        print("test tiep phat nua sourceTree")
        if let saveMeals = loadMeal() {
            listMeal += saveMeals
        }
    }
        // show segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "addItem":
            print("Add new item meal")
            tableView.setEditing(false, animated: true)
        case "showDetail":
            guard let mealDetailViewController = segue.destination as? SetMeal else {
                fatalError("destinatination khong phai la mot SetMeal")
            }
            
            guard let selectedMealCell = sender as? tableViewCellTableViewCell else {
                fatalError("cell selected khong phai la mot tableViewCellTableViewCell")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
               fatalError("")
            }
            
            let selectedMeal = listMeal[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            print(" ")
        }
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SetMeal,
            let meal = sourceViewController.meal {
            if let selectedIndexpath = tableView.indexPathForSelectedRow {
                listMeal[selectedIndexpath.row] = meal
                tableView.reloadRows(at: [selectedIndexpath], with: .none)
            } else {
                listMeal.append(meal)
                tableView.reloadData()
            }
            saveMeals()
        }
    }
    
    func saveMeals() {
//        phương pháp này cố gắng lưu trữ mảng bữa ăn tới một vị trí cụ thể và trả về true nếu lưu thành công
//        nó sử dụng Meal.ArchiveURL để xác đinh nơi lưu thông tin
        let queue = DispatchQueue(label: "queue")
        queue.async {
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.listMeal, toFile: Meal.ArchiveURL.path)
            if isSuccessfulSave {
                print("true")
            } else {
                print("false")
            }
        }
    }
//    phương thức này cố gắng huỷ lưu trữ đối tượng được lưu trữ tại đường dẫn Meal.ArchiveURL.path và downcast đối tượng đó
//    về một mảng đối tượng Meal
    func loadMeal() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
    
    @IBAction func edit(_ sender: Any) {
        if tableView.isEditing == false {
            tableView.setEditing(true, animated: true)
        } else {
            tableView.setEditing(false, animated: true)
        }
    }
    
}

extension ListMeal: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tableViewCellTableViewCell
        cell.photoImage.image = listMeal[indexPath.row].photo
        cell.mealName.text = listMeal[indexPath.row].nameMeal
        cell.ratingControl.rating = listMeal[indexPath.row].rating
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listMeal.remove(at: indexPath.row)
            saveMeals()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let newLocation = listMeal[sourceIndexPath.row]
        listMeal.remove(at: sourceIndexPath.row)
        listMeal.insert(newLocation, at: destinationIndexPath.row)
    }
}

