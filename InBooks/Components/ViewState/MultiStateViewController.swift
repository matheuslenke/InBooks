//
//  MultiStateViewController.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit

class MultiStateViewController: UIViewController {
    
    // MARK: UI Elements
    
    lazy var loadingView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.style = .large
        return activityView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func configLoadingView() {
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        loadingView.startAnimating()
    }
    
    private func configErrorView() {
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func configEmptyView() {
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}

// MARK: State management methods

extension MultiStateViewController: MultiStateViewProtocol {
    func setupLoadingState() {
        contentView.isHidden = true
        self.errorView.removeFromSuperview()
        self.emptyView.removeFromSuperview()
        configLoadingView()
    }
    
    func setupNormalState() {
        contentView.isHidden = false
        self.loadingView.removeFromSuperview()
        self.errorView.removeFromSuperview()
        self.emptyView.removeFromSuperview()
    }
    
    func setupErrorState(message: String?) {
        contentView.isHidden = true
        self.loadingView.removeFromSuperview()
        self.emptyView.removeFromSuperview()
        if let message = message {
            errorView.setupErrorText(with: message)
        }
        configErrorView()
    }
    
    func setupEmptyState(message: String?) {
        self.loadingView.removeFromSuperview()
        contentView.isHidden = true
        
        if let message = message {
            emptyView.setupEmptyText(with: message)
        }
        configEmptyView()
    }
}
