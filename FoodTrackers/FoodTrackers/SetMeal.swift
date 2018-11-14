//
//  ViewController.swift
//  FoodTrackers
//
//  Created by Admin on 11/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

class SetMeal: UIViewController, UINavigationControllerDelegate {
    var meal: Meal?
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var ratingControl: ratingControl!
    @IBOutlet weak var selecterImage: UIImageView!
    @IBOutlet weak var saveMeal: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldName.delegate = self
        // Khi nguoi dung edit mon an, xet lai value trong phân cảnh SetMeal
        if let meal = meal {
            mealName.text = meal.nameMeal
            selecterImage.image = meal.photo
            ratingControl.rating = meal.rating
        }
    }
        // ImagePicker từ photoLibrary
    @IBAction func selectedImageFromPhotoLibrary(_ sender: UIGestureRecognizer) {
        textFieldName.resignFirstResponder()
        let selectedImage = UIImagePickerController()
        selectedImage.sourceType = .photoLibrary
        selectedImage.delegate = self
        present(selectedImage, animated: true)
    }
        // unwin segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem,
            button === saveMeal else {
                fatalError("Button khong duoc xac thuc")
        }
        
        let nameMeal = textFieldName.text ?? ""
        let photo = selecterImage.image
        let rating = ratingControl.rating
        
        meal = Meal(nameMeal: nameMeal, photo: photo, rating: rating)
        print("save")
    }
        // vô hiệu hoá Save khi textFieldName la trống
    func updateSaveButtonState() {
        let text = textFieldName.text ?? ""
        saveMeal.isEnabled = !text.isEmpty
    }
        // xét xem cảnh SetMeal được tạo ra khi người dùng edit hay add
    @IBAction func cancel(_ sender: Any) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
    }
}
        //
extension SetMeal: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("khong the truy cap vao photo library")
        }
        selecterImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
        //
extension SetMeal: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealName.text = textFieldName.text
        updateSaveButtonState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveMeal.isEnabled = false
    }
    
}

