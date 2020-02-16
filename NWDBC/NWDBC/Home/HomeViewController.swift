//
//  HomeViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/11/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIDocumentInteractionControllerDelegate {
    
    let speakerManager = SpeakerManager.sharedInstance
    
    var stackView: UIStackView?
    let backgroundColor = UIColor.init(red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Welcome"
        self.tabBarItem = UITabBarItem.init(title: NSLocalizedString("tabLabel.home", comment: "Home"), image: UIImage.init(named: "home-icon"), selectedImage: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView.init(frame: CGRect.zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = backgroundColor
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let guide = self.view.safeAreaLayoutGuide
        scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
        
        let stackView = UIStackView.init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = backgroundColor
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.init(item: stackView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: stackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        stackView.addArrangedSubview(createHeaderWithString("Explore The Conference"))
        stackView.addArrangedSubview(createTopSection())
        stackView.addArrangedSubview(createHeaderWithString("This Year's Theme"))
        stackView.addArrangedSubview(createThemeSection())
        stackView.addArrangedSubview(createHeaderWithString("Greetings"))
        stackView.addArrangedSubview(createGreetingsSection())
        
    }
    
    private func createHeaderWithString(_ title: String) -> UIView {
        let view = UIView.init()
        view.backgroundColor = backgroundColor
        
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.text = title
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(label)
        
        NSLayoutConstraint.init(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint.init(item: label, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: label, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -5).isActive = true
        NSLayoutConstraint.init(item: label, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10).isActive = true
        
        
        return view
    }
    
    private func createCustomButton(title: String, imageName: String, action: Selector) -> UIView {
        let view = UIView.init()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        let backgroundImage = UIImageView.init(image: UIImage.init(named: imageName))
        backgroundImage.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = view.bounds
        view.addSubview(backgroundImage)
        
        let button = UIButton.init(type: .custom)
        button.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.frame = view.bounds
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.addSubview(button)
        
        return view
    }
    
    private func createTopSection() -> UIView {
        let view = UIView.init()
        view.backgroundColor = backgroundColor
        
        let ministerButton = createCustomButton(title: "Ministers &\nSpeakers", imageName: "buddha", action:#selector(ministersTapped))
        ministerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ministerButton)
        
        let workshopButton = createCustomButton(title: "Workshops", imageName: "workshop", action:#selector(workshopsTapped))
        workshopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(workshopButton)
        
        let keyNoteSpeakerButton = createCustomButton(title: "Keynote\nSpeaker", imageName: "keynote", action:#selector(keynoteSpeakerTapped))
        keyNoteSpeakerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyNoteSpeakerButton)
        
        
        let spacing: CGFloat = 15
        NSLayoutConstraint.init(item: workshopButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: workshopButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: spacing).isActive = true
        NSLayoutConstraint.init(item: workshopButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint.init(item: workshopButton, attribute: .height, relatedBy: .equal, toItem: workshopButton, attribute: .width, multiplier: 1.3, constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: ministerButton, attribute: .left, relatedBy: .equal, toItem: workshopButton, attribute: .right, multiplier: 1.0, constant: spacing).isActive = true
        NSLayoutConstraint.init(item: ministerButton, attribute: .centerY, relatedBy: .equal, toItem: workshopButton, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: ministerButton, attribute: .height, relatedBy: .equal, toItem: workshopButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: ministerButton, attribute: .width, relatedBy: .equal, toItem: workshopButton, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: keyNoteSpeakerButton, attribute: .left, relatedBy: .equal, toItem: ministerButton, attribute: .right, multiplier: 1.0, constant: spacing).isActive = true
        NSLayoutConstraint.init(item: keyNoteSpeakerButton, attribute: .centerY, relatedBy: .equal, toItem: workshopButton, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: keyNoteSpeakerButton, attribute: .height, relatedBy: .equal, toItem: workshopButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: keyNoteSpeakerButton, attribute: .width, relatedBy: .equal, toItem: workshopButton, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: keyNoteSpeakerButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -spacing).isActive = true
        
        return view
    }
    
    

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
      return true
     }
    
    
    private func createThemeSection() -> UIView {
        let contentView = UIView.init()
        contentView.backgroundColor = UIColor.white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 5
        
        let title = UILabel.init()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor.black
        title.text = "Dana for World Peace"
        title.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(title)
        
        let content = UITextView.init()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.textColor = UIColor.black
        content.text = NSLocalizedString("theme.content", comment: "Description of theme")
        content.attributedText = NSAttributedString(string: "https://pollev.com/sbetsuin717")
        content.isEditable = false
        content.isSelectable = true
        content.dataDetectorTypes = UIDataDetectorTypes.all
        
            
        //content.u
        //content.numberOfLines = 4
        //content.lineBreakMode = .byTruncatingTail
        content.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(content)
        
        let readMore = UIButton.init()
        readMore.translatesAutoresizingMaskIntoConstraints = false
        readMore.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        readMore.setTitleColor(AppTheme.mainColor, for: .normal)
        readMore.setTitle("Read More", for: .normal)
        readMore.addTarget(self, action: #selector(launchThemeDescription), for: .touchUpInside)
        contentView.addSubview(readMore)
        
        NSLayoutConstraint.init(item: title, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: title, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: title, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -10).isActive = true
        
        NSLayoutConstraint.init(item: content, attribute: .top, relatedBy: .equal, toItem: title, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: content, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: content, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -10).isActive = true
        
        NSLayoutConstraint.init(item: readMore, attribute: .top, relatedBy: .equal, toItem: content, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: readMore, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: readMore, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        
        let view = UIView.init()
        view.addSubview(contentView)
        view.backgroundColor = backgroundColor
        
        NSLayoutConstraint.init(item: contentView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: contentView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint.init(item: contentView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -15).isActive = true
        NSLayoutConstraint.init(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        
        
        return view
    }
    
    private func createGreetingsSection() -> UIView {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = backgroundColor
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GreetingsCell.self, forCellWithReuseIdentifier: "Cell")
        
        NSLayoutConstraint.init(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 180).isActive = true
        
        return collectionView
    }
    
    @objc private func workshopsTapped() {
        self.tabBarController?.selectedIndex = 1
        if self.tabBarController?.selectedViewController is UINavigationController {
            (self.tabBarController?.selectedViewController as! UINavigationController).popToRootViewController(animated: false)
            (self.tabBarController?.selectedViewController as! UINavigationController).pushViewController(ScheduleViewController.init(isWorkshops: true), animated: false)
        }
    }
    
    @objc private func ministersTapped() {
        let viewController = MinisterProfilesViewController.init()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func keynoteSpeakerTapped() {
        guard let speakerInfo = speakerManager.speakerWithId(16) else { return }
        let vc = ProfileViewController.init(speakerInfo: speakerInfo)
        vc.title = "Keynote Speakers"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func launchThemeDescription() {
        let viewController = TextViewDetailsViewController.init()
        viewController.setupViewController("Theme", text: NSLocalizedString("theme.content", comment: "Theme Description"))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK - UICollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: GreetingsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GreetingsCell
        
        switch indexPath.row {
        case 0:
            cell.setupCellWithName("Kodo Umezu\nBishop", imageName: "umezu.jpg")
            break
        case 1:
            cell.setupCellWithName("Iwagami Chiko\nGovernor General", imageName: "wisteria.jpg")
            break
        case 2:
            cell.setupCellWithName("Yuki Suguhara\nReverend OBT", imageName: "revyuki.jpg")
            break
        case 3:
            cell.setupCellWithName("Katsuya Kusunoki\nRinban SBT", imageName: "Kusunoki.jpg")
            break
        case 4:
            cell.setupCellWithName("Rick Stambul\nPresident BCA", imageName: "Stambul.jpg")
            break
        case 5:
            cell.setupCellWithName("Ken Garner\nNorthwest District", imageName:"wisteria.jpg")
            break
        case 6:
            cell.setupCellWithName("Convention Chairs\nSBT", imageName:"wisteria.jpg")
            break
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        var fileName: String?
        switch indexPath.row {
        case 0:
            fileName = "welcome_umezu2020"
            break
        case 1:
            fileName = "welcome_IwagamiChiko2020"
            break
        case 2:
            fileName = "welcome_suguhara2020"
            break
        case 3:
            fileName = "welcome_kusunoki2020"
            break
        case 4:
            fileName = "welcome_nwdbca2020"
            break
        case 5:
            fileName = "welcome_nwdistrict2020"
            break
        case 6:
            fileName = "welcome_seattle2020"
            break
        default:
            break
        }
        
        if fileName != nil {
            let path = Bundle.main.path(forResource: fileName!, ofType: "pdf")!
            let documentController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: path))
            documentController.delegate = self
            documentController.presentPreview(animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 120, height: 160)
    }

    // MARK - UIDocumentInteractionControllerDelegate Methods
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
