//
// Created by Masoud Heydari on 2019-07-23.
// Copyright (c) 2019 Masoud Heydari. All rights reserved.
//

import UIKit

struct Model {
    static let shared = Model()

    public func getAllData() -> [String]{
        let descriptionList: [String] = {

            let description1 = "Often times when using a UITableVie"
            let description2 = "If your collection view is created programmatically, you would have had to instantiate a UICollectionViewFlowLayout so you can just set the property on that."
            let description3 = "Remember that a constraint is simply a mathematical equation relating one dimension to another."
            let description4 = "If your collection view is created by a XIB, you will need to create a property with an IBOutlet and connect it to your collection view’s layout in order to set estimatedItemSize. There should be a Layout placeholder available in Interface Builder for you to control+drag to."
            let description5 = "For UICollectionView however, the solution is a little less obvious. When I was trying to figure it out, a Google search turned up several different solutions, some of which seemed hackier than others. It wasn’t clear to me what the “right” or cleanest way to accomplish dynamically sized cells was, or whether this was even a thing supported by Apple (spoiler alert: it is.)"
            return [description1, description2, description5, description3, description4]
        }()

        return descriptionList
    }
}