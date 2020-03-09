//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class PeopleDetailsView: UIView {

    private var rootFlexContainer = UIView()

    let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        rootFlexContainer.flex.backgroundColor(.white)
                .define { flex in
                    flex.addItem(avatarImageView)
                            .width(100)
                            .height(100)
                }
        addSubview(rootFlexContainer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all()
    }
}
