//
//  ServiceRequestingImageView.swift
//  Recipe Book
//
//  Created by Chase on 4/5/23.
//

import UIKit

class ServiceRequestingImageView: UIImageView {
    
    func fetchImage(using url: URL) {
        let service = APIService()
        let request = URLRequest(url: url)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
}
