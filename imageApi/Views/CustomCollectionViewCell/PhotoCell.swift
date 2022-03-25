//
//  PhotoCell.swift
//  imageApi
//
//  Created by Amir Bakhshi on 2022-03-24.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotoCell"
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        containerView.backgroundColor = .secondarySystemBackground
    }

    override func prepareForReuse() {
        imgView.image = nil
    }
    
    func configure(with photo: JsonResult) {
        let imageUrl = photo.urls.small
        let profileImage = photo.user.profile_image.small
        let name = photo.user.name
        let likes = photo.likes
        
        ImageProvider.instance.fetchImage(url: imageUrl, completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.imgView.image = image
            }
        })

        ImageProvider.instance.fetchImage(url: profileImage, completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.profileImage.image = image
                self?.name.text = name
                self?.likes.text = "\(likes)"
            }
        })
    }
}
