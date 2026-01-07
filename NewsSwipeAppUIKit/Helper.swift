import UIKit

// 1. DATA MODEL
struct NewsItem {
    let title: String
    let content: String
    let imageName: String
    let tapToKnow: String
}

// 2. STACKED LAYOUT LOGIC
class StackedCardLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        let contentOffset = collectionView?.contentOffset.y ?? 0
        
        attributes?.forEach { attr in
            if attr.frame.origin.y > contentOffset {
                attr.frame.origin.y = contentOffset
            }
            attr.zIndex = -attr.indexPath.item
        }
        return attributes
    }
}

// 3. CELL WITH SCROLLABLE CONTENT
class NewsCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewsCollectionViewCell"

    private let newsImageView = UIImageView()
    private let textScrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let footerView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    private let footerLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        
        // Image
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        contentView.addSubview(newsImageView)

        // Scrollable Area
        textScrollView.showsVerticalScrollIndicator = false
        contentView.addSubview(textScrollView)

        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        contentLabel.font = .systemFont(ofSize: 18)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = .secondaryLabel
        contentLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        let contentStack = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
        contentStack.axis = .vertical
        contentStack.spacing = 15
        textScrollView.addSubview(contentStack)

        // Footer
        footerLabel.font = .boldSystemFont(ofSize: 14)
        footerLabel.textAlignment = .center
        footerView.contentView.addSubview(footerLabel)
        contentView.addSubview(footerView)

        [newsImageView, textScrollView, contentStack, footerView, footerLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.45),

            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 60),

            textScrollView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            textScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textScrollView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -10),

            // Critical for showing full content:
            contentStack.topAnchor.constraint(equalTo: textScrollView.contentLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: textScrollView.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: textScrollView.contentLayoutGuide.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: textScrollView.contentLayoutGuide.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: textScrollView.frameLayoutGuide.widthAnchor),

            footerLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            footerLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
    }

    func configure(with news: NewsItem) {
        newsImageView.image = UIImage(named: news.imageName) ?? UIImage(systemName: "photo")
        titleLabel.text = news.title
        contentLabel.text = news.content
        footerLabel.text = news.tapToKnow
        textScrollView.setContentOffset(.zero, animated: false)
    }
}
