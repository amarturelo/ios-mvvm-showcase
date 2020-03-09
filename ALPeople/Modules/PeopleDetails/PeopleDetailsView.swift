//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout
import Kingfisher

class PeopleDetailsView: UIView {

    fileprivate let rootFlexContainer = UIView()

    let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = "amarturelo@gmail.com"
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = "+5352950107"
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "amarturelo"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "12345678"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = "cerca"
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()

    let birthDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        rootFlexContainer.flex.backgroundColor(.white)
                .addItem()
                .padding(20)
                .alignItems(.center)
                .define { flex in
                    flex.addItem(avatarImageView)
                            .width(200)
                            .height(200)
                    flex.addItem()
                            .height(20)
                    flex.addItem(fullNameLabel)
                    flex.addItem()
                            .height(10)
                    flex.addItem(birthDateLabel)
                    flex.addItem()
                            .height(20)
                    flex.addItem()
                            .alignSelf(.start)
                            .define { flex in
                                flex.addItem({
                                    let label = UILabel()
                                    label.textColor = .black
                                    label.numberOfLines = 0
                                    label.text = "Contact Info"
                                    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                                    return label
                                }())
                                flex.addItem()
                                        .height(10)
                                flex.addItem()
                                        .direction(.row)
                                        .define { flex in
                                            flex.addItem({
                                                let imageView = UIImageView(image: UIImage(systemName: "envelope"))
                                                return imageView
                                            }())
                                            flex.addItem()
                                                    .width(4)
                                            flex.addItem(emailLabel)
                                        }
                                flex.addItem()
                                        .height(10)
                                flex.addItem()
                                        .direction(.row)
                                        .define { flex in
                                            flex.addItem({
                                                let imageView = UIImageView(image: UIImage(systemName: "phone"))
                                                return imageView
                                            }())
                                            flex.addItem()
                                                    .width(4)
                                            flex.addItem(phoneLabel)
                                        }
                                flex.addItem()
                                        .height(10)
                                flex.addItem()
                                        .direction(.row)
                                        .define { flex in
                                            flex.addItem({
                                                let imageView = UIImageView(image: UIImage(systemName: "location"))
                                                return imageView
                                            }())
                                            flex.addItem()
                                                    .width(4)
                                            flex.addItem(addressLabel)
                                        }
                                flex.addItem()
                                        .height(10)
                                flex.addItem()
                                        .direction(.row)
                                        .define { flex in
                                            flex.addItem({
                                                let imageView = UIImageView(image: UIImage(systemName: "person"))
                                                return imageView
                                            }())
                                            flex.addItem()
                                                    .width(4)
                                            flex.addItem(usernameLabel)

                                        }
                                flex.addItem()
                                        .height(10)

                                flex.addItem()
                                        .direction(.row)
                                        .define { flex in
                                            flex.addItem({
                                                let imageView = UIImageView(image: UIImage(systemName: "lock"))
                                                return imageView
                                            }())
                                            flex.addItem()
                                                    .width(4)
                                            flex.addItem(passwordLabel)

                                        }
                            }
                }
        addSubview(rootFlexContainer)
    }

    func updatePeople(people: People) {
        fullNameLabel.text = people.name.fullName()
        fullNameLabel.flex.markDirty()

        emailLabel.text = people.email
        emailLabel.flex.markDirty()

        phoneLabel.text = people.cell
        phoneLabel.flex.markDirty()

        usernameLabel.text = people.username
        usernameLabel.flex.markDirty()

        passwordLabel.text = people.password
        passwordLabel.flex.markDirty()

        birthDateLabel.text = people.bob.date.prettyDate()
        birthDateLabel.flex.markDirty()

        addressLabel.text = people.location.address()
        addressLabel.flex.markDirty()

        let processor = RoundCornerImageProcessor(cornerRadius: 25)
        self.avatarImageView.kf.setImage(with: URL(string: people.picture.large)!, options: [.processor(processor)])

        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.flex.layout()
    }
}
