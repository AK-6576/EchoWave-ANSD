//
//  HomeViewController.swift
//  Group_4-ANSD_App
//
//  Created by Daiwiik on 26/11/25.
//

import UIKit

// Define the data model (Outside the class, or in its own file)
struct RoutineConversation: Codable, Identifiable {
    let id: String
    let iconName: String
    let categoryTitle: String
    let status: String
    let conversationTopic: String
    let timeRange: String
}

// Enum to manage the sections for the Compositional Layout
enum Section: Int, CaseIterable {
    case routineConversations = 0
    case viewConversations = 1
}

class HomeViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Sample Data Source
        var routineItems: [RoutineConversation] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // 1. Load Data
            loadSampleData()
                    
            // 2. Configure Collection View
            collectionView.collectionViewLayout = createLayout()
            collectionView.dataSource = self
            collectionView.delegate = self
                    
            // 3. Register Cells using the Nib (XIB)
            
            // Register RoutineCell
            // NOTE: Ensure your XIB file is named "RoutineCell.xib"
            let routineNib = UINib(nibName: "RoutineCollectionViewCell", bundle: nil)
            collectionView.register(routineNib, forCellWithReuseIdentifier: "routineCell") // Registered as "routineCell"
            
            // Register ViewCell
            // NOTE: Ensure your XIB file is named "ViewCell.xib"
            let viewNib = UINib(nibName: "ViewCell", bundle: nil)
            collectionView.register(viewNib, forCellWithReuseIdentifier: "viewCell") // Registered as "viewCell"
        }
        
        // Function to simulate loading the data
        func loadSampleData() {
            routineItems = [
                RoutineConversation(id: "1", iconName: "message.fill", categoryTitle: "Office", status: "Upcoming", conversationTopic: "Daily Check-In", timeRange: "09:30 - 10:30 AM"),
                RoutineConversation(id: "2", iconName: "figure.2.and.child.holdinghands", categoryTitle: "Family", status: "Scheduled", conversationTopic: "Dinner", timeRange: "09:30 - 10:30 PM"),
                RoutineConversation(id: "3", iconName: "person.3.fill", categoryTitle: "Friends", status: "Scheduled", conversationTopic: "Cafeteria", timeRange: "12:30 - 01:30 PM"),
                RoutineConversation(id: "4", iconName: "briefcase.fill", categoryTitle: "Team", status: "Upcoming", conversationTopic: "Project Sync", timeRange: "02:00 - 03:00 PM"),
                RoutineConversation(id: "5", iconName: "heart.fill", categoryTitle: "Personal", status: "Scheduled", conversationTopic: "Therapy Session", timeRange: "05:00 - 06:00 PM")
            ]
        }
    }

    // Extend the class for collection view protocols
    extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
        // MARK: UICollectionViewDataSource
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return Section.allCases.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard let sectionType = Section(rawValue: section) else { return 0 }
            
            switch sectionType {
            case .routineConversations:
                return routineItems.count
            case .viewConversations:
                return 2
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let sectionType = Section(rawValue: indexPath.section) else {
                fatalError("Invalid section type")
            }
            
            switch sectionType {
            case .routineConversations:
                // FIXED: Changed identifier to "routineCell" to match registration in viewDidLoad
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routineCell", for: indexPath) as! RoutineCell
                let item = routineItems[indexPath.item]
                cell.configure(with: item)
                return cell
                
            case .viewConversations:
                // FIXED: Changed identifier to "viewCell" to match registration in viewDidLoad
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewCell", for: indexPath) as! ViewCell
                return cell
            }
        }
    }

    // MARK: - Compositional Layout Definition
    extension HomeViewController {
        
        func createLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
                
                guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
                
                switch sectionType {
                case .routineConversations:
                    return self.createRoutineConversationsLayout()
                case .viewConversations:
                    return self.createViewConversationsLayout()
                }
            }
            return layout
        }
        
        // --- Layout for the Horizontal Scroll Section (Routine Conversations) ---
        private func createRoutineConversationsLayout() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.85),
                heightDimension: .absolute(150)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 15
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 20, trailing: 20)
            
            return section
        }
        
        // --- Layout for the Vertical List Section (View Conversations) ---
        private func createViewConversationsLayout() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 20, trailing: 20)
            
            return section
        }
    }
