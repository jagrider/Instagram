//
//  PostViewController.swift
//  Instagram
//
//  Created by Jonathan Grider on 2/4/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var postTextField: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if postImageView.image == nil {
      createImagePicker()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func createImagePicker() {
    let isCameraAvailable =
      UIImagePickerController.isSourceTypeAvailable(.camera)
    
    // Limit to PhotoLibrary if no camera available
    let sourceType = isCameraAvailable ?
      UIImagePickerControllerSourceType.camera :
      UIImagePickerControllerSourceType.photoLibrary
    
    let vc = UIImagePickerController()
    vc.delegate = self
    vc.sourceType = sourceType
    
    self.present(vc, animated: true, completion: nil)
  }
  
  @IBAction func sharePressed(_ sender: Any) {
    // Share the photo
    Post.postUserImage(image: postImageView.image, withCaption: postTextField.text) { (success: Bool, error: Error?) in
      if success {
        self.postImageView.image = nil
        self.tabBarController?.selectedIndex = 0
        print("POSTING SUCCEEDED! 😁")
      } else {
        print("error: \(String(describing: error))")
        print("POSTING FAILED!!!! 😡")
      }
    }
  }
  
  
  @IBAction func cancelPressed(_ sender: Any) {
    // Go back to the feed tab
    postImageView.image = nil
    self.tabBarController?.selectedIndex = 0
  }
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    // Get the image captured by the UIImagePickerController
    let image: UIImage!
    if (info[UIImagePickerControllerEditedImage] as? UIImage) != nil {
      image = info[UIImagePickerControllerEditedImage] as! UIImage
    } else {
      image = info[UIImagePickerControllerOriginalImage] as! UIImage
    }
    
    // Update the image view
    postImageView.image = image
    
    // Dismiss UIImagePickerController to go back to your original view controller
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.tabBarController?.selectedIndex = 0
    dismiss(animated: true, completion: nil)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
