//
//  CustomSearchBar.swift
//  BlurrySearchBar
//
//  Created by Marlon Raskin on 7/27/20.
//

import UIKit

class CustomSearchBar: UIView, UITextFieldDelegate {

	// MARK: - Properties

	var placeholder: String {
		get { searchTextField.placeholder ?? "" }
		set { searchTextField.placeholder = newValue }
	}

	var text: String { get { searchTextField.text ?? "" } }

	fileprivate let searchImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.tintColor = .secondaryLabel
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	fileprivate let searchTextField: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.backgroundColor = .clear
		tf.tintColor = .label
		tf.placeholder = "Search.."
		tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
		return tf
	}()

	fileprivate let clearButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
		button.tintColor = UIColor.secondaryLabel.withAlphaComponent(0.5)
		button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
		button.alpha = 0.0
		return button
	}()

	fileprivate let elementStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 8
		stackView.alignment = .center
		stackView.distribution = .fill
		stackView.axis = .horizontal
		return stackView
	}()

	fileprivate let blurEffectView: UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		return blurEffectView
	}()


	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .clear
		layer.cornerRadius = 12
		layer.cornerCurve = .continuous
		layer.masksToBounds = true
		layoutSearchBar()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - Setup
	private func layoutSearchBar() {
		addSubview(blurEffectView)

		searchTextField.delegate = self
		searchTextField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

		elementStackView.addArrangedSubview(searchImageView)
		elementStackView.addArrangedSubview(searchTextField)
		elementStackView.addArrangedSubview(clearButton)
		addSubview(elementStackView)

		NSLayoutConstraint.activate([
			searchImageView.heightAnchor.constraint(equalToConstant: 25),
			searchImageView.widthAnchor.constraint(equalToConstant: 25),

			clearButton.widthAnchor.constraint(equalToConstant: 25),
			clearButton.heightAnchor.constraint(equalToConstant: 25),

			blurEffectView.topAnchor.constraint(equalTo: topAnchor),
			blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
			blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
			blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),

			elementStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			elementStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			elementStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
			elementStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8)
		])
	}


	// MARK: - Target Methods
	@objc private func clearText() {
		searchTextField.text = ""
	}

	@objc private func textDidChange() {
		guard let text = searchTextField.text else { return }
		UIView.animate(withDuration: 0.2) {
			if text != "" {
				self.clearButton.alpha = 1.0
			} else {
				self.clearButton.alpha = 0.0
			}
		}
	}


	// MARK: - TextField Delegate Methods
	func textFieldDidBeginEditing(_ textField: UITextField) {
		guard searchTextField.text != "" else { return }
		UIView.animate(withDuration: 0.2) {
			self.clearButton.alpha = 1.0
		}
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		UIView.animate(withDuration: 0.2) {
			self.clearButton.alpha = 0.0
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return textField.resignFirstResponder()
	}
}
