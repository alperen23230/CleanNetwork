//
//  CreatePostViewController.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 3.07.2022.
//

import UIKit
import CleanNetwork

final class CreatePostViewController: UIViewController, AlertingController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextField: UITextField!
    
    private let networkService = CLNetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Actions
extension CreatePostViewController {
    @IBAction func createPostButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
              let body = bodyTextField.text else { return }
        Task { [weak self] in
            await self?.createPost(title: title, body: body)
        }
    }
}

// MARK: - Networking
extension CreatePostViewController {
    private func createPost(title: String, body: String) async {
        let requestBody = CreatePostRequestBody(userId: 1, title: title, body: body)
        let request = CreatePostRequest(requestBody: requestBody)
        do {
            let response = try await networkService.fetch(request)
            showSimpleAlert(title: "Successfull", message: "Post added with id: \(response.id)")
        } catch {
            var errorMessage = ""
            if let error = error as? CLError {
                switch error {
                case .errorMessage(let message):
                    errorMessage = message.rawValue
                case .apiError(let data, let statusCode):
                    if let statusCode = statusCode {
                        print(statusCode)
                    }
                    // If you have a API error type handle here with 'data'
                    if let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                        errorMessage = apiError.errorMessage
                    }
                }
            } else {
                errorMessage = error.localizedDescription
            }
            
            showSimpleAlert(title: "Error", message: errorMessage, actionTitle: "Retry") {
                Task { [weak self] in
                    await self?.createPost(title: title, body: body)
                }
            }
        }
    }
}
