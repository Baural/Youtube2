//
//  VideoCell.swift
//  youtube
//
//  Created by Baur on 6/10/18.
//  Copyright © 2018 Baur. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoCell: BaseCell {
 
    var video: Video?{
        didSet{
            titleLable.text = video?.title
            setupThumbnailImage()

            setupProfileImage()
          
            
            if  let channelName = video?.channel?.name, let numbersOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subtitleText = "\(channelName ) · \(numberFormatter.string(from: numbersOfViews)!) · 2 years ago "
                subtitleTextView.text = subtitleText
            }
            //measure title text
            if let title = video?.title{
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options =  NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titlelabelHeightConstraint?.constant = 44
                } else {
                    titlelabelHeightConstraint?.constant = 20
                }
                
            }
            
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName{
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView ()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO · 1,604,684,607 views · 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titlelabelHeightConstraint: NSLayoutConstraint?
    
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLable)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImageView)
        //        vertical constraint
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //        top constraint
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //        left constraint
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //        right constraint
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView , attribute: .right, multiplier: 1, constant: 0 ))
        //        height constraint
        titlelabelHeightConstraint = NSLayoutConstraint(item: titleLable,  attribute: .height, relatedBy: .equal, toItem: self , attribute: .height, multiplier: 0 , constant: 44  )
        addConstraint(titlelabelHeightConstraint!)
        
        
        //        top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLable, attribute: .bottom, multiplier: 1, constant: 4))
        //        left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //        right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView , attribute: .right, multiplier: 1, constant: 0 ))
        //        height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self , attribute: .height, multiplier: 0 , constant: 30 ))
        
        //        addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLable)
        //        addConstraintsWithFormat(format: "H:|[v0]|", views: titleLable)
    }
    
    
}
