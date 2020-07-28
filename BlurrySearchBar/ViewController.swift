//
//  ViewController.swift
//  BlurrySearchBar
//
//  Created by Marlon Raskin on 7/27/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

// MARK: - Properties
	let customSearchBar = CustomSearchBar()


// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		layoutSearchBar()
		customSearchBar.placeholder = "Something"
	}


// MARK: - Setup
	private func layoutSearchBar() {
		view.addSubview(customSearchBar)

		NSLayoutConstraint.activate([
			customSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
			customSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			customSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
			customSearchBar.heightAnchor.constraint(equalToConstant: 40),
		])
	}
}

