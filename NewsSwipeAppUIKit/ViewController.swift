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
                NewsItem(title: "Foreign tourist dances around ‘protective’ circle on New Year’s Eve in Shillong, video wins hearts: ‘the respect for personal space and dignity’", content: "Amid several incidents of concern over women’s safety in India, a video of a foreign tourist dancing in Shillong during New Year celebrations has caught the Internet’s attention, drawing widespread appreciation on social media.", imageName: "Dance" , tapToKnow: "noman"),
                NewsItem(title: "Can govt freeze bank account forever? Uttarakhand High Court ends 6-year ordeal for non-accused in corruption probe", content: "Written by Ashish ShajiNew Delhi | Updated: January 7, 2026 06:27 PM IST clock_logo 3 min read google-preferred-btn Uttarakhand High Court held that mere pendency of a criminal trial cannot justify indefinite freezing of property belonging to a person who is not facing trial.Uttarakhand High Court held that mere pendency of a criminal trial cannot justify indefinite freezing of property belonging to a person who is not facing trial. The Uttarakhand High Court recently ordered the unfreezing of a man’s bank account that had remained frozen since 2018 owing to a corruption probe and said that the mere pendency of a criminal trial doesn’t justify the indefinite freezing of property of someone not facing trial. ", imageName: "Lock" , tapToKnow: "see more for freeze accounts"),
                NewsItem(title: "Vicky Kaushal and Katrina Kaif name their son Vihaan (it has an URI connect), share first pic: ‘Our Ray of Light", content: "Vicky Kaushal and Katrina Kaif have announced the name of their newborn baby boy in their latest Instagram post. Katrina and Vicky, in a joint post, revealed that their son’s name is Vihaan Kaushal. The actors also shared the first glimpse of their little munchkin along with the announcement. The name Vihaan is of Sanskrit origin and means “dawn,” “sunrise,” “morning” or “beginning of a new era.”", imageName: "Kaif" , tapToKnow: "see more for kaif "),
                NewsItem(title: "Fund manager, 47, dies of sudden cardiac arrest while on holiday", content: "Maverick fund manager Siddhartha Bhaiya, who passed away due to cardiac arrest on December 31 while on holiday in New Zealand, not only points to the growing statistics of sudden deaths among young Indians but also prods us to look beyond other aspects of heart health than just heart attacks. Death caused by a sudden cardiac arrest, a condition when the heart stops because of an electrical malfunction and irregularity of its rhythms, accounts for approximately four to five million deaths annually worldwide and nearly 10 per cent of all cardiac deaths in India, according to the European Journal of Cardiovascular Medicine.", imageName: "Attack" , tapToKnow: "see more for Attack "),
                NewsItem(title: "Thalapathy Vijay’s Jana Nayagan to be reviewed by fresh CBFC committee", content: "From “what all box office records will Vijay’s Jana Nayagan smash?” the conversation has suddenly veered to “will the political actioner hit the screens on the scheduled date?” owing to an inordinate delay in the movie getting a green signal from the Central Board of Film Certification (CBFC). Although Jana Nayagan’s makers moved the Madras High Court on Tuesday, January 6, they did not receive relief, and the hearing was adjourned until Wednesday afternoon.", imageName: "Vijay" , tapToKnow: "see more for Attack ")
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
