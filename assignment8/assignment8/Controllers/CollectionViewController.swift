//
//  CollectionViewController.swift
//  assignment8
//
//  Created by Yusuke Ishihara on 2022-05-30.
//

import UIKit


class CollectionViewController: UICollectionViewController {

    enum Section: Hashable {
        case category
        case menu
    }
    
    var filteredCategory = [String]()
    var filteredMenu: [Item] = Item.defaultMenu
    var sections = [Section]()
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var filteredMenuSnapshot: NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.category])
        snapshot.appendSections([.menu])
        snapshot.appendItems(Item.categories, toSection: .category)
        snapshot.appendItems(filteredMenu, toSection: .menu)
        sections = snapshot.sectionIdentifiers

        return snapshot
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        collectionView.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: FoodCollectionViewCell.reuseIdentifier)
        configureDatasource()
    }

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            
            let space = 16.0
            switch section {
            case .category:
                
                let col: CGFloat = 4
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/col),
                    heightDimension: .absolute(44)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize, subitems: [item]
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: space/2, bottom: 0, trailing: space/2)
                // group.interItemSpacing = .fixed(space)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case .menu:
                let pictureWidth = self.view.frame.width
                let pictureHeight = pictureWidth/2
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: space/2, leading: space/2, bottom: space/2, trailing: space/2)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(pictureHeight)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: space/2, leading: 0, bottom: space/2, trailing: 0)
                
                return section
            }
        }
        
        return layout
    }
    
    func configureDatasource() {
        dataSource = .init(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section {
            case .category:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
                cell.configureCell(item.category!)
                
                return cell
                
            case .menu:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.reuseIdentifier, for: indexPath) as! FoodCollectionViewCell
                cell.configureCell(item.food!)
                
                return cell
            }
        })
        
        dataSource.apply(filteredMenuSnapshot)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        
        cell.toggleButton()
        
        let selectedCategory = cell.nameButton.titleLabel!.text!
        var selectedCategoryIndex = -1
        if let index = filteredCategory.firstIndex(of: selectedCategory) {
            selectedCategoryIndex = index
        }
        
        if selectedCategoryIndex != -1 {
            filteredCategory.remove(at: selectedCategoryIndex)
        } else {
            filteredCategory.append(selectedCategory)
        }
        
        filteredMenu = Item.defaultMenu.filter { (item) in
            return filteredCategory.contains(item.food!.country)
        }
        
        dataSource.apply(filteredMenuSnapshot)
    }
}
