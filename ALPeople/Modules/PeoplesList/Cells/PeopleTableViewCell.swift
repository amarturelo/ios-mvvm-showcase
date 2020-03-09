//
//  PeopleTableViewCell.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout
import Kingfisher

class PeopleTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PeopleCellIdentifier"

    var peopleCover: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.darkText
        return label
    }()

    var birdDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkText.withAlphaComponent(0.8)
        label.numberOfLines = 1
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView
                .flex
                .backgroundColor(.white)
                .padding(8)
                .define { (flex) in
                    flex.direction(.row)
                            .alignItems(.center)
                            .define { flex in
                                flex.addItem(peopleCover)
                                        .width(50)
                                        .height(50)
                                flex.addItem()
                                        .width(8)
                                flex.addItem()
                                        .define { flex in
                                            flex.addItem(fullNameLabel)
                                            flex.addItem()
                                                    .direction(.row)
                                                    .define { flex in
                                                        flex.addItem({
                                                            let label = UILabel()
                                                            label.text = "BirdDay:"
                                                            label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                                                            label.textColor = UIColor.darkText.withAlphaComponent(0.8)
                                                            label.numberOfLines = 1
                                                            return label
                                                        }())
                                                        flex.addItem()
                                                                .width(4)
                                                        flex.addItem(birdDate)
                                                    }
                                        }
                            }
                }
    }

    func configure(people: People) {
        let url = URL(string: people.picture.large)!
        let processor = RoundCornerImageProcessor(cornerRadius: 25)
        peopleCover.kf.setImage(with: url, options: [.processor(processor)])

        fullNameLabel.text = people.name.fullName()
        fullNameLabel.flex.markDirty()

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd, YYYY")

        birdDate.text = dateFormatter.string(from: people.bob.date)
        birdDate.flex.markDirty()

        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }

    private func layout() {
        contentView.pin.horizontally().vertically()
        contentView.flex.layout()
    }
}
