import Foundation
import UIKit


func makeNewLine(name: String, self: NewPasswordViewController, listOfIcons: [Icons]) -> UIStackView {
    let button = UIButton()
    
    let labelMembersTitle = UILabel()
    let stackViewMembers = UIStackView() //название + скролл
    let stackListMembers = UIStackView() //внутренний стэк
    let scrollViewFriends = UIScrollView() //скролл
    let viewForScrollViewFriends = UIView() //view
    let contentView = UIView()
    
    button.addTarget(self, action: #selector(self.pressedButton), for: .touchUpInside)
    
    button.backgroundColor = Styles.Color.appBaseColor
    button.setTitle(NSLocalizedString(Localization.Add.create, comment: ""), for: .normal)
    button.titleLabel?.textColor = .label
    button.layer.cornerRadius = 10
    
    
    scrollViewFriends.alwaysBounceHorizontal = true
    scrollViewFriends.showsHorizontalScrollIndicator = false
    
    
    stackListMembers.axis = .horizontal
    stackListMembers.distribution = .fill
    stackListMembers.alignment = .fill
    stackListMembers.spacing = 10
    
    stackViewMembers.axis = .vertical
    stackViewMembers.spacing = 10
    
    scrollViewFriends.backgroundColor = .systemBackground
    scrollViewFriends.layer.cornerRadius = 15
    
    labelMembersTitle.font = UIFont.boldSystemFont(ofSize: 28)
    labelMembersTitle.textColor = .label
    labelMembersTitle.text = NSLocalizedString(name, comment: "")
    
    
    stackViewMembers.addArrangedSubview(labelMembersTitle)
    stackViewMembers.addArrangedSubview(viewForScrollViewFriends)
    
    viewForScrollViewFriends.addSubview(scrollViewFriends)
    scrollViewFriends.addSubview(contentView)
    contentView.addSubview(stackListMembers)
    stackListMembers.addArrangedSubview(UIImageView())
    
    stackListMembers.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10) //отступы
    stackListMembers.isLayoutMarginsRelativeArrangement = true
    
    
    labelMembersTitle.translatesAutoresizingMaskIntoConstraints = false
    stackViewMembers.translatesAutoresizingMaskIntoConstraints = false
    stackListMembers.translatesAutoresizingMaskIntoConstraints = false
    scrollViewFriends.translatesAutoresizingMaskIntoConstraints = false
    viewForScrollViewFriends.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    [
        
        viewForScrollViewFriends.heightAnchor.constraint(equalToConstant: 95),
        viewForScrollViewFriends.bottomAnchor.constraint(equalTo: stackViewMembers.bottomAnchor),
        viewForScrollViewFriends.leadingAnchor.constraint(equalTo: stackViewMembers.leadingAnchor),
        viewForScrollViewFriends.trailingAnchor.constraint(equalTo: stackViewMembers.trailingAnchor),
        
        scrollViewFriends.topAnchor.constraint(equalTo: viewForScrollViewFriends.topAnchor),
        scrollViewFriends.leadingAnchor.constraint(equalTo: viewForScrollViewFriends.leadingAnchor),
        scrollViewFriends.trailingAnchor.constraint(equalTo: viewForScrollViewFriends.trailingAnchor),
        scrollViewFriends.bottomAnchor.constraint(equalTo: viewForScrollViewFriends.bottomAnchor),
        
        contentView.topAnchor.constraint(equalTo: scrollViewFriends.topAnchor),
        contentView.leadingAnchor.constraint(equalTo: scrollViewFriends.leadingAnchor),
        contentView.trailingAnchor.constraint(equalTo: scrollViewFriends.trailingAnchor),
        contentView.bottomAnchor.constraint(equalTo: scrollViewFriends.bottomAnchor),
        
        //        contentView.heightAnchor.constraint(equalTo: viewForScrollViewFriends.heightAnchor),
        //        contentView.widthAnchor.constraint(equalTo: viewForScrollViewFriends.widthAnchor),
        //
        
        stackListMembers.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
        stackListMembers.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        stackListMembers.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        stackListMembers.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        
    ].forEach({$0.isActive = true})
    
    
    
    
    for i in 0..<listOfIcons.count {
        let viewPerson = UIView()
        let imageView = UIImageView()
        //       let name = UILabel()
        let button = UIButton()
        [viewPerson, imageView, button
        ].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        imageView.image = listOfIcons[i].image
        //        name.text = listOfIcons[i].name
        //        name.font = name.font.withSize(15)
        //        name.textAlignment = .center
        
        viewPerson.addSubview(imageView)
        //      viewPerson.addSubview(name)
        viewPerson.addSubview(button)
        
        //    viewPerson.heightAnchor.constraint(equalToConstant: 110).isActive = true
        viewPerson.heightAnchor.constraint(equalToConstant: 90).isActive = true
        viewPerson.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.topAnchor.constraint(equalTo: viewPerson.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: viewPerson.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: viewPerson.trailingAnchor).isActive = true
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        //        name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        //        name.leadingAnchor.constraint(equalTo: viewPerson.leadingAnchor).isActive = true
        //        name.trailingAnchor.constraint(equalTo: viewPerson.trailingAnchor).isActive = true
        //        name.bottomAnchor.constraint(equalTo: viewPerson.bottomAnchor).isActive = true
        
        button.topAnchor.constraint(equalTo: viewPerson.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: viewPerson.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: viewPerson.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: viewPerson.bottomAnchor).isActive = true
        
        //   button.setTitle(String(name.text!), for: .normal)
        button.setTitle(String(listOfIcons[i].name), for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.addTarget(self, action: #selector(self.pressedMember(_:)), for: .touchUpInside)
        
        self.view.backgroundColor = .systemBackground
        
        
        viewPerson.backgroundColor = .clear
        viewPerson.layer.cornerRadius = 15
        viewPerson.layer.shadowRadius = 4
        viewPerson.layer.shadowOpacity = 0.5
        viewPerson.layer.shadowColor = UIColor.black.cgColor
        viewPerson.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        //       viewPerson.layer.shadowPath = UIBezierPath(roundedRect: viewPerson.layer.bounds, cornerRadius: viewPerson.layer.cornerRadius).cgPath
        
        
        stackListMembers.addArrangedSubview(viewPerson)
    }
    
    return stackViewMembers
}
