//
// Created by Masoud Heydari on 2019-07-23.
// Copyright (c) 2019 Masoud Heydari. All rights reserved.
//

import Foundation


import UIKit

import UIKit

class MyCell: UICollectionViewCell {

    private var imgBannerHeightAnchor: NSLayoutConstraint?
    private var imgBannerWidthAnchor: NSLayoutConstraint?

    public var descriptionTxt: String? {
        didSet {
            if let description = descriptionTxt {
                self.descTextView.text = description
            }
        }
    }

    // this is necessary for self sizing
    private lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()

    let imgProfile: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        img.layer.cornerRadius = 34
        img.translatesAutoresizingMaskIntoConstraints = false
        img.widthAnchor.constraint(equalToConstant: 68).isActive = true
        img.heightAnchor.constraint(equalToConstant: 68).isActive = true
        return img
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Masoud Heydari"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.sizeToFit()
        label.backgroundColor = UIColor.red.withAlphaComponent(0.075)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.text = "I am a iOS Developer with over 1 year experience."
        label.textAlignment = .left
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()

    let descTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.boldSystemFont(ofSize: 14)
        tv.textAlignment = .left
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        tv.isSelectable = false
        return tv
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "4 hours ago"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.red.withAlphaComponent(0.25)
        return label
    }()

    let imgBanner: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        img.layer.cornerRadius = 8
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    let btnMore: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return btn
    }()

    let btnLike: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()

    let btnComment: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()

    let buttomButtonsSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        return sv
    }()

    let topBtnAndLabelsSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommonStackViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = frame.width
        print("size \(contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1)))")
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }

    private func setupCommonStackViews() {
        let nameAndBioSV = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        nameAndBioSV.spacing = 4
        nameAndBioSV.axis = .vertical

        [imgProfile, nameAndBioSV, btnMore].forEach{topBtnAndLabelsSV.addArrangedSubview($0)}
        topBtnAndLabelsSV.spacing = 8

        [btnLike, btnComment, UIView(), dateLabel].forEach{buttomButtonsSV.addArrangedSubview($0)}
        buttomButtonsSV.spacing = 4
    }

    private func setupInPortraite() {
        cleanContentView()

        let bannerWidth = Const.imgBannerWidth
        let bannerHeight = bannerWidth * 0.5652
        setupImgBanner(bannerHeight: bannerHeight, bannerWidth: bannerWidth)

        let descriptionAndImgBannerSV = setupMainStackView(arrangedSubviews: [descTextView, imgBanner])
        let mainSV = setupMainStackView(arrangedSubviews: [topBtnAndLabelsSV, descriptionAndImgBannerSV, buttomButtonsSV])
        let mainContainer = setupMainContainer()
        setupMainVSAndMainContainer(mainSV: mainSV, mainContainer: mainContainer)
    }

    private func setupInLandscape() {
        cleanContentView()

        let bannerWidth = Const.imgBannerWidth - (8 + 8 + 4)
        let bannerHeight = bannerWidth * 0.5652
        setupImgBanner(bannerHeight: bannerHeight, bannerWidth: bannerWidth)

        let topAndMiddleAndBottomSV = setupMainStackView(arrangedSubviews: [topBtnAndLabelsSV, descTextView, buttomButtonsSV])

        // main StackView
        let mainSV = setupMainStackView(arrangedSubviews: [topAndMiddleAndBottomSV, imgBanner], axis: .horizontal)
        mainSV.distribution = .fillEqually

        let mainContainer = setupMainContainer()

        setupMainVSAndMainContainer(mainSV: mainSV, mainContainer: mainContainer)
    }

    func setupMainContainer() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func setupMainStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .vertical) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: arrangedSubviews)
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = axis
        return sv
    }

    private func setupMainVSAndMainContainer(mainSV: UIStackView, mainContainer: UIView) {
        mainContainer.addSubview(mainSV)
        contentView.addSubview(mainContainer)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        mainSV.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 8).isActive = true
        mainSV.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -8).isActive = true
        mainSV.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 8).isActive = true
        mainSV.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -8).isActive = true

        mainContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mainContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        mainContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func cleanContentView() {
        contentView.removeAllConstraints()
        contentView.removeAllSubviews()
    }

    private func setupImgBanner(bannerHeight: CGFloat, bannerWidth: CGFloat) {
        if self.imgBannerHeightAnchor == nil {

            self.imgBannerHeightAnchor = imgBanner.heightAnchor.constraint(equalToConstant: bannerHeight)
            self.imgBannerWidthAnchor = imgBanner.widthAnchor.constraint(equalToConstant: bannerWidth)

            self.imgBannerHeightAnchor?.isActive = true
            self.imgBannerWidthAnchor?.isActive = true

        } else {
            self.imgBannerHeightAnchor?.constant = bannerHeight
            self.imgBannerWidthAnchor?.constant = bannerWidth
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            setupInPortraite()
        } else {
            setupInLandscape()
        }

    }

}
