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

    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()

    let birthDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
                }
        addSubview(rootFlexContainer)
    }

    func updateFullName(fullName: String) {
        fullNameLabel.text = fullName
        fullNameLabel.flex.markDirty()
        setNeedsLayout()
    }

    func updateBirthDate(birthDate: Date) {
        birthDateLabel.text = birthDate.prettyDate()
        birthDateLabel.flex.markDirty()
        setNeedsLayout()
    }

    func updateAvatar(url: String) {
        let processor = RoundCornerImageProcessor(cornerRadius: 25)
        self.avatarImageView.kf.setImage(with: URL(string: url)!, options: [.processor(processor)])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.flex.layout()
    }
}
