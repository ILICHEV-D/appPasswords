import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    fileprivate let name: UILabel = { () -> UILabel in
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        name.textColor = UIColor.systemGray
        name.textAlignment = .left
        name.numberOfLines = 0
        return name
    }()
    
    
    
    fileprivate let login: UILabel = { () -> UILabel in
        let login = UILabel()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.font = UIFont.systemFont(ofSize: 16, weight: .light)
        login.textAlignment = .left
        login.lineBreakMode = .byWordWrapping
        login.numberOfLines = 0
        return login
    }()
    
    fileprivate let image: UIImageView = { ( ) -> UIImageView in
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.layer.borderWidth = 0
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(name)
        contentView.addSubview(login)
        contentView.addSubview(image)
        
        [
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 60),
            image.widthAnchor.constraint(equalToConstant: 60),
            
            name.topAnchor.constraint(equalTo: image.topAnchor, constant: 11),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            name.heightAnchor.constraint(equalToConstant: 15),
            name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            login.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -11),
            login.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            login.heightAnchor.constraint(equalToConstant: 18),
            login.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ].forEach({$0.isActive = true})
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(collectionView: UICollectionView, index: Int, listOfLogins: [LoginAndPassword]) {
        let note = listOfLogins[index]
        let index = Common.listOfIcons.firstIndex(where: {$0.name == note.type})
        
        if let index = index {
            image.image = UIImage(named: "icons/\(Common.listOfIcons[index].name)" )
        }
        else {
            image.image = UIImage(named: "sign1")
        }
        name.text = note.type?.firstUppercased
        login.text = note.login
        self.backgroundColor = UIColor(named: "color1")
    }
}
