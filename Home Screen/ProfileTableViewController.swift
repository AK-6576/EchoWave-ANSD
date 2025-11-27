import UIKit

class ProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // New Outlets for Profile Picture and Text Fields
        @IBOutlet weak var profileImageView: UIImageView!
        @IBOutlet weak var firstNameTextField: UITextField!
        @IBOutlet weak var lastNameTextField: UITextField!
    // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupGenderMenu()
            setupProfileDesign()
        }
        
        func setupProfileDesign() {
            // Make the profile image circular
            // Note: This assumes your Image View is square (e.g. 100x100)
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            profileImageView.clipsToBounds = true
        }
        
        // MARK: - Gender Menu Logic
        func setupGenderMenu() {
            let male = UIAction(title: "Male", handler: { _ in self.updateGenderTitle("Male") })
            let female = UIAction(title: "Female", handler: { _ in self.updateGenderTitle("Female") })
            let other = UIAction(title: "Prefer not to say", handler: { _ in self.updateGenderTitle("Prefer not to say") })
            
            genderButton.menu = UIMenu(children: [male, female, other])
            genderButton.showsMenuAsPrimaryAction = true
        }
        
        func updateGenderTitle(_ title: String) {
            genderButton.setTitle(title, for: .normal)
        }

        // MARK: - Button Actions
        
        // 1. Close the Modal ("X" Button)
        @IBAction func closeButtonTapped(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
        
        // 2. Open Photo Gallery
        @IBAction func setProfilePictureTapped(_ sender: Any) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true // Lets user crop to a square
            present(picker, animated: true)
        }
        
        // MARK: - Image Picker Delegate (Handles the photo selection)
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Get the image the user edited/cropped
            if let image = info[.editedImage] as? UIImage {
                profileImageView.image = image
            } else if let image = info[.originalImage] as? UIImage {
                profileImageView.image = image
            }
            
            // Close the gallery
            dismiss(animated: true)
        }
    }
