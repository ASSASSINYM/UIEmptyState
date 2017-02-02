//
//  UIEmptyStateDataSource.swift
//  UIEmptyState
//
//  Created by Luis Padron on 1/31/17.
//  Copyright © 2017 Luis Padron. All rights reserved.
//


/// The data source for the Empty View
public protocol UIEmptyStateDataSource: class {
    /// Determines whether should or should not show the empty view, by default it will count tableView rows to determine
    func shouldShowEmptyStateView(forTableView tableView: UITableView) -> Bool
    /// Determines the view to use for the empty state, by default this is a nice stack view
    func viewForEmptyState() -> UIView
    /// Determines the title for the Empty View, by default this just returns "I'm a Title", override for custom title
    func titleForEmptyStateView() -> NSAttributedString
    /// Determines the image which will be used inside the Empty State View's image view
    func imageForEmptyStateView() -> UIImage?
    /// Determines the title for the button of the Empty State View
    func buttonTitleForEmptyStateView() -> NSAttributedString?
    /// Determines the image for the button
    func buttonImageForEmptyStateView() -> UIImage?
    /// Determines the message which will be displayed in the detail view
    func detailMessageForEmptyStateView() -> NSAttributedString?
    /// Determines the amount of spacing between the views
    func spacingForViewsInEmptyStateView() -> CGFloat
}

/// Extension for the UIEmptyDataSource which adds a default implementation for any UITableViewController
extension UIEmptyStateDataSource where Self: UITableViewController {
    public func shouldShowEmptyStateView(forTableView tableView: UITableView) -> Bool {
        let sections = tableView.numberOfSections
        var rows = 0
        for section in 0..<sections {
            rows += tableView.numberOfRows(inSection: section)
        }
        return rows == 0
    }
    
    public func viewForEmptyState() -> UIView {
        let emptyStateView = UIEmptyStateView(frame: CGRect.zero, title: titleForEmptyStateView())
        if let navBar = self.navigationController?.navigationBar {
            let height = self.view.frame.height - navBar.frame.height
            emptyStateView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
        } else {
            emptyStateView.frame = self.view.frame
        }
        
        emptyStateView.image = imageForEmptyStateView()
        emptyStateView.detailMessage = detailMessageForEmptyStateView()
        emptyStateView.buttonTitle = buttonTitleForEmptyStateView()
        emptyStateView.buttonImage = buttonImageForEmptyStateView()
        emptyStateView.spacing = spacingForViewsInEmptyStateView()

        return emptyStateView
    }
    
    public func titleForEmptyStateView() -> NSAttributedString {
        return NSAttributedString(string: "I'm a Title", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17)])
    }
    
    public func imageForEmptyStateView() -> UIImage? {
        return #imageLiteral(resourceName: "testImage")
    }
    
    public func buttonTitleForEmptyStateView() -> NSAttributedString? {
        return NSAttributedString(string: "Add an item", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)])
    }
    
    public func buttonImageForEmptyStateView() -> UIImage? {
        return nil
    }
    
    public func detailMessageForEmptyStateView() -> NSAttributedString? {
        return NSAttributedString(string: "I'm the detail message, aren't I cool.", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)])
    }
    
    public func spacingForViewsInEmptyStateView() -> CGFloat {
        return 20
    }
}
