import UIKit


class viewConvo: UIViewController, UICollectionViewDelegate{
        // ...
    @IBOutlet weak var collectionView: UICollectionView!

    var response = ConversationsResponse()
    var conversationSections: [ConversationSection] = []
    
    // MonthHeaderView.swift (Needs to be created and linked to the XIB)



    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "View Conversations"
        setupCollectionView()
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        let nib = UINib(nibName: "ConversationCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "conversationCell")
        
        
        let headerNib = UINib(nibName: "MonthHeaderView", bundle: nil)
                collectionView.register(headerNib,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: "MonthHeaderID")

                loadConversationData()
    }
    func loadConversationData() {
            let response = ConversationsResponse() // This loads your JSON data
            
            // 1. Create the Current Month Section (You'll need to determine the current month dynamically or hardcode it based on your JSON structure)
            // Assuming the first section is "October" based on your data example
            if !response.conversations.isEmpty {
                let currentMonthTitle = "October" // You may need a function to determine this
                let currentMonthSection = ConversationSection(title: currentMonthTitle, conversations: response.conversations)
                conversationSections.append(currentMonthSection)
            }
            
            // 2. Append Previous Month Sections
            for monthData in response.previousMonths {
                let section = ConversationSection(title: monthData.month, conversations: monthData.conversations)
                conversationSections.append(section)
            }
            
            collectionView.reloadData()
        }
}







// In ViewConversationController.swift
struct ConversationSection {
    let title: String // e.g., "October"
    let conversations: [Conversation]
}







extension viewConvo: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return conversationSections.count // Provides the total number of month headings
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conversationSections[section].conversations.count // Provides the number of cards in that month
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // **ADD THIS GUARD STATEMENT**
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conversationCell", for: indexPath) as? ConversationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Access data using both section and row index
        let conversationItem = conversationSections[indexPath.section].conversations[indexPath.row]
        
        // This line assumes your cell class is named ConversationCollectionViewCell
        cell.configure(with: conversationItem)
        
        return cell
    }
    // NEW: Provides the Section Header View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        // Dequeue the MonthHeaderView
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "MonthHeaderID",
            for: indexPath) as? MonthHeaderView else {
            return UICollectionReusableView()
        }
        
        // Set the month title (e.g., "October" or "September")
        let monthTitle = conversationSections[indexPath.section].title
        header.monthLabel.text = monthTitle
        
        return header
    }
}
    // MARK: - UICollectionViewDelegateFlowLayout
    extension viewConvo: UICollectionViewDelegateFlowLayout {
        
        // Defines the size of the Section Header (Critical for headers to appear)
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            
            let width = collectionView.bounds.width
            // Use the height you designed in the XIB
            return CGSize(width: width, height: 40)
        }
        
        // Defines the size of the cell (Critical for self-sizing cells)
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let width = collectionView.bounds.width
            // This tells the flow layout to calculate the height based on constraints
            return CGSize(width: width, height: 120)
        }
    }

