//
//  HomeViewController.swift
//  Group_4-ANSD_App
//
//  Created by Daiwiik on 26/11/25.
//

import UIKit

// MARK: - 1. New Header View Class
// (You can put this here or in a separate file named SectionHeaderView.swift)
class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"

    let titleLabel = UILabel()
    let detailLabel = UILabel() // For the "3 >" or "10 >"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(titleLabel)
        addSubview(detailLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false

        // Styling
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label

        detailLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        detailLabel.textColor = .secondaryLabel

        // Constraints
        NSLayoutConstraint.activate([
            // Title on the left
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0), // Aligned with cell content
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Detail on the right
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

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
    // MARK: Data Sources
        var routineItems: [RoutineConversation] = []
        var viewItems: [ConversationHistoryItem] = [] // <--- New Array for JSON Data
              
        override func viewDidLoad() {
            super.viewDidLoad()

            // 1. Load Data
            loadRoutineData()
            viewItems = loadJsonData() // <--- Load from view.json
                      
            // 2. Configure Collection View
            collectionView.collectionViewLayout = createLayout()
            collectionView.dataSource = self
            collectionView.delegate = self
                      
            // 3. Register Cells
            let routineNib = UINib(nibName: "RoutineCollectionViewCell", bundle: nil)
            collectionView.register(routineNib, forCellWithReuseIdentifier: "routineCell")
            
            let viewNib = UINib(nibName: "ViewCell", bundle: nil) // Ensure XIB name is "ViewCell"
            collectionView.register(viewNib, forCellWithReuseIdentifier: "viewCell") // reuseIdentifier must match XIB
            
            // 4. Register Header
            collectionView.register(SectionHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        }
        
        // MARK: - Data Loading Functions
        
        func loadRoutineData() {
            routineItems = [
                RoutineConversation(id: "1", iconName: "message.fill", categoryTitle: "Office", status: "Upcoming", conversationTopic: "Daily Check-In", timeRange: "09:30 - 10:30 AM"),
                RoutineConversation(id: "2", iconName: "figure.2.and.child.holdinghands", categoryTitle: "Family", status: "Scheduled", conversationTopic: "Dinner", timeRange: "09:30 - 10:30 PM"),
                RoutineConversation(id: "3", iconName: "person.3.fill", categoryTitle: "Friends", status: "Scheduled", conversationTopic: "Cafeteria", timeRange: "12:30 - 01:30 PM"),
                RoutineConversation(id: "4", iconName: "briefcase.fill", categoryTitle: "Team", status: "Upcoming", conversationTopic: "Project Sync", timeRange: "02:00 - 03:00 PM"),
                RoutineConversation(id: "5", iconName: "heart.fill", categoryTitle: "Personal", status: "Scheduled", conversationTopic: "Therapy Session", timeRange: "05:00 - 06:00 PM")
            ]
        }

        func loadJsonData() -> [ConversationHistoryItem] {
            // Look for view.json in the bundle
            guard let url = Bundle.main.url(forResource: "view", withExtension: "json") else {
                print("Error: view.json not found")
                return []
            }
            
            do {
                let data = try Data(contentsOf: url)
                let items = try JSONDecoder().decode([ConversationHistoryItem].self, from: data)
                return items
            } catch {
                print("Error decoding view.json: \(error)")
                return []
            }
        }
    }

    // MARK: - DataSource & Delegate
    extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return Section.allCases.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard let sectionType = Section(rawValue: section) else { return 0 }
            
            switch sectionType {
            case .routineConversations:
                return routineItems.count
            case .viewConversations:
                return viewItems.count // <--- Use real count from JSON
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let sectionType = Section(rawValue: indexPath.section) else {
                fatalError("Invalid section type")
            }
            
            switch sectionType {
            case .routineConversations:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routineCell", for: indexPath) as! RoutineCell
                let item = routineItems[indexPath.item]
                cell.configure(with: item)
                return cell
                
            case .viewConversations:
                // reuseIdentifier should match what you set in XIB and register
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewCell", for: indexPath) as! ViewCell
                
                let item = viewItems[indexPath.item] // <--- Get Item
                cell.configure(with: item)           // <--- Configure Cell
                
                return cell
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }
            
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as! SectionHeaderView
            
            guard let sectionType = Section(rawValue: indexPath.section) else { return headerView }
            
            // Customize text based on section
            switch sectionType {
            case .routineConversations:
                headerView.titleLabel.text = "Routine Conversations"
                headerView.detailLabel.text = "\(routineItems.count) >"
            case .viewConversations:
                headerView.titleLabel.text = "View Conversations"
                // Show real count from JSON
                headerView.detailLabel.text = "\(viewItems.count) >"
            }
            
            return headerView
        }
    }

    // MARK: - Compositional Layout
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
        
        private func createRoutineConversationsLayout() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.85),
                heightDimension: .absolute(165)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 15
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 20, trailing: 20)
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(44)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
        private func createViewConversationsLayout() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // NOTE: Adjusted height to 140 to fit more content (Date/Time/Tags)
            // You can change this back to 100 if you prefer smaller cards.
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(140)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 12
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 20, trailing: 20)
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(44)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
    }
