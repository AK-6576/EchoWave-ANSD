//
//  NewButtonViewController.swift
//  ANSD_APP
//
//  Created by Anshul Kumaria on 01/12/25.
//

import UIKit

class NewButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    // Connect this to your "New Conversation" Button
    @IBAction func newConversationTapped(_ sender: UIButton) {
        showInviteMenu()
    }

    // MARK: - Navigation Logic (The Bridge)
    func navigateToChat() {
        // Ensure "Main" matches your Storyboard filename
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Ensure "GroupNewViewController" matches the Storyboard ID of your Chat Screen
        if let chatVC = storyboard.instantiateViewController(withIdentifier: "GroupNewViewController") as? GroupNewViewController {
            
            chatVC.modalPresentationStyle = .fullScreen
            chatVC.modalTransitionStyle = .crossDissolve
            
            self.present(chatVC, animated: true, completion: nil)
        }
    }

    // MARK: - The Menu (Action Sheet)
    func showInviteMenu() {
        
        let actionSheet = UIAlertController(title: "Start New Conversation", message: "Choose an invite method", preferredStyle: .actionSheet)

        // OPTION A: Share Link (Triggers AirDrop/System Share)
        let shareAction = UIAlertAction(title: "Share Invite Link", style: .default) { _ in
            self.shareSystemLink()
        }
        
        // OPTION B: Show QR Code (Triggers Custom Screen)
        let qrAction = UIAlertAction(title: "Show QR Code", style: .default) { _ in
            self.showQRCodeScreen()
        }

        // OPTION C: Cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        actionSheet.addAction(shareAction)
        actionSheet.addAction(qrAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true)
    }
    
    // MARK: - Helper 1: The "AirDrop Thing"
    func shareSystemLink() {
        // 1. Prepare Content
        let code = "QC-\(UUID().uuidString.prefix(6))"
        let textToShare = "Join my Quick Caption conversation! Code: \(code)"
        
        // 2. Open System Share Sheet
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        // 3. Navigate to Chat when done
        activityVC.completionWithItemsHandler = { _, _, _, _ in
            // This runs when the user closes the share sheet or finishes sharing
            self.navigateToChat()
        }
        
        present(activityVC, animated: true)
    }
    
    // MARK: - Helper 2: The QR Code Screen
    func showQRCodeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Ensure "QRCodeViewController" matches the Storyboard ID of your QR Screen
        if let qrVC = storyboard.instantiateViewController(withIdentifier: "QRCodeViewController") as? QRCodeViewController {
            
            qrVC.inviteCode = "QC-\(UUID().uuidString.prefix(6))"
            
            // Callback: When QR screen closes, go to Chat
            qrVC.onDismiss = { [weak self] in
                self?.navigateToChat()
            }
            
            // Show as a Card (iPhone style)
            qrVC.modalPresentationStyle = .pageSheet
            if let sheet = qrVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
            
            present(qrVC, animated: true)
        }
    }
}
