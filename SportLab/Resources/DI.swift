//
//  DI.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//

extension LauncherViewController: ResourceLoaderProvider {
    var resourceLoader: ResourceLoader {
        return ResourceLoader.shared
    }
}

extension HomePageViewController: ResourceLoaderProvider {
    var resourceLoader: ResourceLoader {
        return ResourceLoader.shared
    }
}
