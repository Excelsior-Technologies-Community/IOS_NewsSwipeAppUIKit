//
//  ViewController.swift
//  NewsSwipeAppUIKit
//
//  Created by Noman belim on 07/01/26.
//
 
import UIKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var newsList: [NewsItem] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            loadData()
        }

        private func setupCollectionView() {
            // Apply the custom StackedCardLayout
            let layout = StackedCardLayout()
            collectionView.collectionViewLayout = layout
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            // Paging must be enabled for the "snap" effect
            collectionView.isPagingEnabled = true
            collectionView.showsVerticalScrollIndicator = false
            
            // Allows the image to go behind the status bar / notch
            collectionView.contentInsetAdjustmentBehavior = .never

            collectionView.register(
                NewsCollectionViewCell.self,
                forCellWithReuseIdentifier: NewsCollectionViewCell.identifier
            )
        }

        private func loadData() {
            newsList = [
                NewsItem(title: "As Deepinder Goyal generates buzz with ‘Temple’ device on forehead, experts advice caution: ‘The biggest worry is that", content: "Deepinder Goyal’s recent appearance on a podcast drew public attention and sparked curiosity, as he was seen wearing a small device — named Temple — fixed near the temple region of the head. According to several reports, the experimental wearable health gadget, developed by a private research initiative backed by the Zomato founder and CEO, continuously measures brain oxygenation, which indirectly reflects blood flow to the brain when the person is upright and moving, or sitting for long durations.", imageName: "Dipendar" , tapToKnow: "Lockheed Martin Agreement"),
                NewsItem(title: "I spent a week with Motorola’s Edge 70, an absolutely thin smartphone that is too hard to ignore ", content: "The Motorola Edge 70 focuses on sleek design and comfort while still delivering all-day battery life. Priced at Rs 29,999, it offers a premium build, bright display, reliable everyday performance, and strong durability, but compromises on camera quality and flagship-level power.", imageName: "Moto" , tapToKnow: "noman"),
                NewsItem(title: "Foreign tourist dances around ‘protective’ circle on New Year’s Eve in Shillong, video wins hearts: ‘the respect for personal space and dignity’", content: "Amid several incidents of concern over women’s safety in India, a video of a foreign tourist dancing in Shillong during New Year celebrations has caught the Internet’s attention, drawing widespread appreciation on social media.", imageName: "Dance" , tapToKnow: "noman")
            ]
            // IMPORTANT: Refresh the collection view after loading data
            collectionView.reloadData()
        }
    }

    extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return newsList.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as! NewsCollectionViewCell
            cell.configure(with: newsList[indexPath.item])
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Ensures each news card takes up the full screen
            return collectionView.bounds.size
        }
    }
