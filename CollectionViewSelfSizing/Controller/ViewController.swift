//
//  ViewController.swift
//  CollectionViewSelfSizing
//
//  Created by Masoud Heydari on 2019-07-23.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let descriptionList: [String] = {

        let description1 = "Often times when using a UITableVie"

        let description2 = "If your collection view is created programmatically, you would have had to instantiate a UICollectionViewFlowLayout so you can just set the property on that."

        let description3 = "Remember that a constraint is simply a mathematical equation relating one dimension to another."

        let description4 = "If your collection view is created by a XIB, you will need to create a property with an IBOutlet and connect it to your collection view’s layout in order to set estimatedItemSize. There should be a Layout placeholder available in Interface Builder for you to control+drag to."

        let description5 = "For UICollectionView however, the solution is a little less obvious. When I was trying to figure it out, a Google search turned up several different solutions, some of which seemed hackier than others. It wasn’t clear to me what the “right” or cleanest way to accomplish dynamically sized cells was, or whether this was even a thing supported by Apple (spoiler alert: it is.)"

        return [description1, description2, description5, description3, description4]
    }()

    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.sectionInsetReference = .fromSafeArea
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.collectionViewLayout = layout
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavBar()
        view.backgroundColor = .white
    }

    private func setupNavBar() {
        navigationItem.title = "CollectionView Self Sizing"
        print("view frame \(view.frame) || Const \(Const.viewWidth)")
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true

        view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            let safeArea = view.safeAreaLayoutGuide
            collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
            collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }

        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cellId")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return descriptionList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MyCell
        cell.descriptionTxt = self.descriptionList[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 10)
        layout.invalidateLayout()
        super.traitCollectionDidChange(previousTraitCollection)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.estimatedItemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 10)
        layout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }

}
