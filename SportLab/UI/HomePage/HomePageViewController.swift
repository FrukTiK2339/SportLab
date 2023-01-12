//
//  HomePageViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Главная страница (картинки, статьи, ссылки)

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView?
    private var sections = [HomePageSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
//        title = "SportLab"
        
        configureSections()
        setupCollectionView()
        setupUI()
    }
    
    private func configureSections() {
        sections.append(
            HomePageSection(
                type: .bigPost,
                cells: resourceLoader.bigPosts
            )
        )
        
        sections.append(
            HomePageSection(
                type: .smallArticle,
                cells: resourceLoader.smallArticles
            )
        )
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        
        collectionView.register(BigPostCollectionViewCell.self, forCellWithReuseIdentifier: BigPostCollectionViewCell.identifier)
        collectionView.register(SmallArticleCollectionViewCell.self, forCellWithReuseIdentifier: SmallArticleCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.backgroundColor = ?
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        self.collectionView = collectionView
    }
    
    private func setupUI() {
        collectionView?.frame = view.bounds
        collectionView?.backgroundColor = .secondarySystemBackground
    }
    
    func layout(for section: Int) -> NSCollectionLayoutSection {
        let sectionType = sections[section].type
        
        switch sectionType {
            
        case .bigPost:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                         leading: 8,
                                                         bottom: 8,
                                                         trailing: 8
            )
            
            let width = view.frame.size.width/1.5
            let hight = width*2/3
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .estimated(width),
                    heightDimension: .estimated(hight)),
                subitems: [item])
            
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            
            return sectionLayout
            
        case .smallArticle:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                         leading: 8,
                                                         bottom: 8,
                                                         trailing: 8
            )

            
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(100)
                ),
                subitems: [item]
            )
            
            let sectionLayout = NSCollectionLayoutSection(group: verticalGroup)
            
            return sectionLayout
            
        }
    }
    
    
    
    //MARK: - CollectionView Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postType = sections[indexPath.section].type
        let post = sections[indexPath.section].cells[indexPath.row]
        switch postType {
            
        case .bigPost:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPostCollectionViewCell.identifier, for: indexPath) as? BigPostCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: post)
            return cell
            
        case .smallArticle:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallArticleCollectionViewCell.identifier, for: indexPath) as? SmallArticleCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: post)
            return cell
        }
    }
    
    
}
