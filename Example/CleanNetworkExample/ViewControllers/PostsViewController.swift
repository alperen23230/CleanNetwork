//
//  PostsViewController.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 11.06.2022.
//

import UIKit
import CleanNetwork

final class PostsViewController: UIViewController, AlertingController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        Task {
            await fetchPosts()
        }
    }
    
    private func configureContents() {
        title = "Posts"
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(UINib(nibName: PostTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource
extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.setCell(with: post)
        return cell
    }
}

// MARK: - Networking
extension PostsViewController {
    private func fetchPosts() async {
        let request = PostsRequest()
        tableView.startLoading()
        do {
            posts = try await CLNetworkService.shared.fetch(request)
            await MainActor.run {
                tableView.stopLoading()
                tableView.reloadData()
            }
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
                    await self?.fetchPosts()
                }
            }
        }
    }
}
