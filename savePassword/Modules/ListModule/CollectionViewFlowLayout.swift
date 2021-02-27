import UIKit

final class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        scrollDirection = .vertical
        minimumLineSpacing = 15
        minimumInteritemSpacing = 15
        itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
    }
}

