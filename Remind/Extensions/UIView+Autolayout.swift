//
//  UIView+Autolayout.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import Foundation

import UIKit

enum UIEdge: CaseIterable {
    case top
    case right
    case left
    case bottom
    
    var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top
        case .right:
            return .right
        case .left:
            return .left
        case .bottom:
            return .bottom
        }
    }
    
    static var sideEdges: [UIEdge] {
        return [.left, .right]
    }
    
}

enum UIAxis: CaseIterable {
    case x
    case y
    
    var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .x:
            return .centerX
        case .y:
            return .centerY
        }
    }
}

extension UIView {
    
    // MARK: - High level
    
    // MARK: Safe Area
    
    func autopinEdgesToSafeAreaEdges() {
        autopinAllEdges(to: superview?.safeAreaLayoutGuide)
    }
    
    func autopinEdgesToSafeAreaEdges(excluding edge: UIEdge) {
        autopinAllEdges(to: superview?.safeAreaLayoutGuide, excluding: edge)
    }
    
    // MARK: Superview
    
    func autopinEdgesToSuperviewEdges() {
        autopinAllEdges(to: superview)
    }
    
    func autopinEdgesToSuperviewEdges(excluding edge: UIEdge) {
        autopinAllEdges(to: superview, excluding: edge)
    }
    
    func autopinSideEdgesToSuperviewEdges() {
        autopinSideEdges(to: superview)
    }
    
    func autopinEdgeToSuperviewEdge(_ edge: UIEdge, constant: CGFloat = 0) {
        autopinEdge(edge: edge, to: superview)
    }
    
    func autocenterInSuperview(xConstant: CGFloat = 0, yConstant: CGFloat = 0) {
        autocenter(in: superview, xConstant: xConstant, yConstant: yConstant)
    }
    
    func autosetAspectRatio(_ aspectRatio: CGFloat = 1) {
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal,
                           toItem: self, attribute: .width, multiplier: aspectRatio, constant: 0).isActive = true
    }
    
    // MARK: - Mid level
    
    func autocenter(in view: UIView?, xConstant: CGFloat = 0, yConstant: CGFloat = 0) {
        autoalign(axis: .x, to: view, constant: xConstant)
        autoalign(axis: .y, to: view, constant: yConstant)
    }
    
    func autopinAllEdges(to view: Any?) {
        autopinEdges(edges: UIEdge.allCases, to: view)
    }
    
    func autopinAllEdges(to view: Any?, excluding edge: UIEdge, constant: CGFloat = 0) {
        UIEdge.allCases.forEach {
            guard $0 != edge else { return }
            autopinEdge(edge: $0, to: view)
        }
    }
    
    func autopinSideEdges(to view: Any?) {
        autopinEdges(edges: UIEdge.sideEdges, to: view)
    }
    
    func autopinEdges(edges: [UIEdge], to view: Any?, constant: CGFloat = 0) {
        edges.forEach {
            autopinEdge(edge: $0, to: view)
        }
    }
    
    func autopinEdge(edge: UIEdge, to view: Any?, constant: CGFloat = 0) {
        autopinEdge(edge: edge, toEdge: edge, of: view, constant: constant)
    }
    
    // MARK: - Low level
    
    func autopinEdge(edge: UIEdge, toEdge: UIEdge, of view: Any?,
                     constant: CGFloat = 0, relatedBy: NSLayoutConstraint.Relation = .equal) {
        NSLayoutConstraint(item: self, attribute: edge.attribute,
                           relatedBy: relatedBy,
                           toItem: view, attribute: toEdge.attribute,
                           multiplier: 1, constant: constant).isActive = true
    }
    
    func autoalign(axis: UIAxis, to view: UIView?, constant: CGFloat = 0) {
        NSLayoutConstraint(item: self, attribute: axis.attribute,
                           relatedBy: .equal,
                           toItem: view, attribute: axis.attribute,
                           multiplier: 1, constant: 0).isActive = true
    }
    
    func autosetHeight(_ height: CGFloat) -> NSLayoutConstraint {
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute,
                                                  multiplier: 1, constant: height)
        heightConstraint.isActive = true
        return heightConstraint
    }
    
    func autosetWidth(_ width: CGFloat) -> NSLayoutConstraint {
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute,
                                                 multiplier: 1, constant: width)
        widthConstraint.isActive = true
        return widthConstraint
    }
    
}

// MARK: - Custom Autolayout

extension UIView {
    
    class func initForAutoLayout() -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func autoplaceOnRightEdgeOfView(_ view: UIView, padding: CGFloat = 0) {
        NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal,
                           toItem: view, attribute: .centerY, multiplier: 1, constant: padding).isActive = true
        NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal,
                           toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
    
    func autoplaceInRightBottomEdgeOfSuperview() {
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                           toItem: superview, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal,
                           toItem: superview, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
    
    func autosetProportionalWidth(to view: UIView, proportion: CGFloat) {
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal,
                           toItem: view, attribute: .width, multiplier: proportion, constant: 0).isActive = true
    }
    
    func autoplaceOnTopOfView(_ view: UIView, padding: CGFloat = 0) {
        NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal,
                           toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                           toItem: view, attribute: .top, multiplier: 1, constant: -padding).isActive = true
        NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal,
                           toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal,
                           toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
    
}
