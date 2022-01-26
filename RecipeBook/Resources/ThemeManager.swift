//
//  ThemeManager.swift
//  RecipeBook
//
//  Created by Admin on 26.12.2021.
//

import Foundation
import UIKit

enum Theme: String {
    case orange
    
    var backgroundColor: UIColor {
        switch self {
        case .orange:
            return .systemOrange
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .orange:
            return .white
        }
    }
}

struct ThemeManager {
    ///получение текущей темы из локальной БД
    static func currentTheme() -> Theme {
            return .orange
    }
    ///применение темы
    static func applyTheme(theme: Theme) {
        ///UINavigationBar
        UINavigationBar.appearance().backgroundColor = theme.backgroundColor
        UINavigationBar.appearance().barTintColor = theme.backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = theme.textColor
        UINavigationBar.appearance().shadowImage = nil
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backItem?.title = ""
        
        UITabBar.appearance().backgroundColor = theme.backgroundColor
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().shadowImage = UIImage()
        
        UIImageView.appearance().image = UIImage(systemName: "photo")
        
        UIActivityIndicatorView.appearance().color = theme.textColor
    }
}
