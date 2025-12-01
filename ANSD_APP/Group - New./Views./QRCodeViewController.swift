//
//  QRCodeViewController.swift
//  ANSD_APP
//
//  Created by Anshul Kumaria on 01/12/25.
//

import UIKit
import CoreImage.CIFilterBuiltins

class QRCodeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var shareLinkButton: UIButton!
    
    // Data passed in
    var inviteCode: String = ""
    
    // Callback to tell parent "I am finished"
    var onDismiss: (() -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        generateAndShowQR()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Button Styling
        shareLinkButton.layer.cornerRadius = 25
        shareLinkButton.backgroundColor = .black
        shareLinkButton.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - QR Generation
    func generateAndShowQR() {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        // Create Data
        let data = inviteCode.data(using: .ascii)
        filter.setValue(data, forKey: "inputMessage")
        
        // Scale Up
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        if let output = filter.outputImage?.transformed(by: transform) {
            if let cgImage = context.createCGImage(output, from: output.extent) {
                qrImageView.image = UIImage(cgImage: cgImage)
            }
        }
    }

    // MARK: - Actions
    
    // "Share Link" inside the QR Screen
    @IBAction func shareLinkTapped(_ sender: Any) {
        let textToShare = "Join my Quick Caption conversation! Code: \(inviteCode)"
        
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        // When sharing finishes, dismiss QR screen -> which triggers onDismiss -> which opens Chat
        activityVC.completionWithItemsHandler = { _, _, _, _ in
            self.dismiss(animated: true) {
                self.onDismiss?()
            }
        }
        
        present(activityVC, animated: true)
    }
    
    // Handle Swipe Down Dismissal
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // If the view was dragged down to close, we still want to go to the chat
        if isBeingDismissed {
            onDismiss?()
        }
    }
}
