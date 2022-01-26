//
//  CategoryCreationViewController.swift
//  RecipeBook
//
//  Created by Admin on 19.10.2021.
//

import UIKit
import YPImagePicker
import RealmSwift

class CategoryCreationViewController: ViewControllerWithKeyboard {
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var tfCategoryName: UITextField!
    
    var category: CategoryObjectModel?/*{
        didSet{
            if let data = category?.imageData {
                
                self.categoryImage.image = UIImage(data: data)
            }
            self.tfCategoryName.text = category?.name
        }
    }*/
    
    var image: UIImage?{
        didSet{
            self.categoryImage.image = image
        }
    }
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Новая категория"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnImage))
        if let category = self.category {
            if let data = category.imageData {
                
                self.categoryImage.image = UIImage(data: data)
            }
            self.tfCategoryName.text = category.name
        }
        categoryImage.addGestureRecognizer(tapGestureRecognizer)
        categoryImage.layer.cornerRadius = 15
    }
    
    @IBAction func addCategoryBtn(_ sender: Any) {       
        if tfCategoryName.text == "" {
            self.showAlert(title: "", message: "Заполните неоходимые данные")
        } else {
            try! realm.write {
                let category = self.category ?? CategoryObjectModel()
                ///проверка на существование, т.k. у существующего объекта нельзя менять id
                if self.category == nil {
                    category.id = UUID().uuidString
                }
                
                category.name = tfCategoryName.text
                let quality : CGFloat = 0.93
                category.imageData = image?.jpegData(compressionQuality: quality)
                realm.add(category)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapOnImage() {
        let configuration = getImagePickerConfiguration(screen: .library)
        
        let picker = YPImagePicker(configuration: configuration)
        picker.didFinishPicking {
            [unowned picker] items, _ in
            
            if let photo = items.singlePhoto {
                self.image = photo.image
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    
    private func getImagePickerConfiguration(screen: YPPickerScreen) -> YPImagePickerConfiguration {
        var configuration = YPImagePickerConfiguration()
        
        #if targetEnvironment(simulator)
        configuration.screens = [.library]
        configuration.startOnScreen = .library
        #else
        configuration.screens = [screen]
        configuration.startOnScreen = screen
        #endif
        
        configuration.library.mediaType = .photo
        configuration.showsPhotoFilters = false
        configuration.isScrollToChangeModesEnabled = false
        configuration.onlySquareImagesFromCamera = false
        configuration.shouldSaveNewPicturesToAlbum = false
        configuration.hidesStatusBar = false
        
        //UINavigationBar.appearance().tintColor = .darkRed
        //configuration.colors.tintColor = .darkRed
        return configuration
    }

}
