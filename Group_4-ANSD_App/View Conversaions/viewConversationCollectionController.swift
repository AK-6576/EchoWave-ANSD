import UIKit

class viewConvo: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var response = ConversationsResponse()

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
    }
}

extension viewConvo: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // October + September
    } 

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return response.conversations.count
        } else {
            return response.previousMonths.first?.conversations.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "conversationCell", for: indexPath
        ) as! ConversationCollectionViewCell

        let item = (indexPath.section == 0)
            ? response.conversations[indexPath.row]
            : response.previousMonths.first!.conversations[indexPath.row]

        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        cell.dateLabel.text = item.date
        cell.timeLabel.text = "\(item.startTime) - \(item.endTime)"
        cell.categoryLabel.text = item.category.capitalized

        return cell
    }

    // Size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 140)
    }
}
