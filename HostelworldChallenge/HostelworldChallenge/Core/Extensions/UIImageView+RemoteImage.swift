//
//  UIImageView+RemoteImage.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func setRemoteImage(imageURL: String, success: ((UIImage) -> Void)? = nil) {
        NetworkLayer.request(imageUrl: imageURL) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
                        guard let self else { return }
                        self.backgroundColor = .clear
                        self.image = image
                    }, completion: { _ in
                        success?(image)
                })
            }
        }
    }
}
