//
//  AutoAutoLayout.swift
//  Pods
//
//  Created by Wilhelm Van Der Walt on 1/7/16.
//
//

import Foundation
import UIKit

extension UIView {
	
	func stackViews(
		stackedViews: [UIView],
		horizontalAttributes: [[NSLayoutAttribute]]? = nil,
		horizontalRelations: [[NSLayoutRelation]]? = nil,
		horizontalPadding: [[CGFloat]]? = nil,
		gapPadding: CGFloat = 8.0,
		topPadding: CGFloat = 0.0,
		bottomPadding: CGFloat = 0.0
		) {
			var lastView: UIView?
			let hAttributes: [[NSLayoutAttribute]] = self.getHorizontalAttributes(forStackViews: stackedViews, horizontalAttributes: horizontalAttributes)
			let hRelations: [[NSLayoutRelation]] = self.getHorizontalRelations(forStackViews: stackedViews, horizontalRelations: horizontalRelations)
			let hPadding: [[CGFloat]] = self.getHorizontalPadding(forStackViews: stackedViews, horizontalPadding: horizontalPadding)
			
			
			for index in 0...(stackedViews.count - 1) {
				if let nLastView = lastView {
					stackedViews[index].constrainToBottom(ofView: nLastView, inView: self, center: true, topPadding: spacing, leadingRelation: leadingRelation, trailingRelation: trailingRelation, leadingPadding: leadingPadding, trailingPadding: trailingPadding)
				} else {
					view.constrainToTop(ofSuperView: self, topLayoutGuide: topLayoutGuide, center: true, topPadding: topPadding, leadingRelation: leadingRelation, trailingRelation: trailingRelation, leadingPadding: leadingPadding, trailingPadding: trailingPadding)
				}
				lastView = view
			}
			
			if let nLastView = lastView {
				nLastView.addBottomConstraint(inView: self, padding: bottomPadding)
			}
			
	}
	

	func getHorizontalAttributes(forStackViews stackViews: [UIView], horizontalAttributes: [[NSLayoutAttribute]]?) -> [[NSLayoutAttribute]]{
		if let hAttributes = horizontalAttributes {
			self.validateHorizontalAttributes(forStackViews: stackViews, horizontalAttributes: hAttributes)
			return hAttributes
		}
		else {
			return  [[]]
		}
	}
	
	func validateHorizontalAttributes(forStackViews stackViews: [UIView], horizontalAttributes: [[NSLayoutAttribute]]) {
		
	}
	
	func getHorizontalRelations(forStackViews stackViews: [UIView], horizontalRelations: [[NSLayoutRelation]]?) -> [[NSLayoutRelation]]{
		if let hRelations = horizontalRelations {
			self.validateHorizontalRelations(forStackViews: stackViews, horizontalRelations: hRelations)
			return hRelations
		}
		else {
			return  [[]]
		}
	}
	
	func validateHorizontalRelations(forStackViews stackViews: [UIView], horizontalRelations: [[NSLayoutRelation]]) {
		
	}
	
	func getHorizontalPadding(forStackViews stackViews: [UIView], horizontalPadding: [[CGFloat]]?) -> [[CGFloat]]{
		if let hPadding = horizontalPadding {
			self.validateHorizontalPadding(forStackViews: stackViews, horizontalPadding: hPadding)
			return hPadding
		}
		else {
			return  [[]]
		}
	}
	
	func validateHorizontalPadding(forStackViews stackViews: [UIView], horizontalPadding: [[CGFloat]]) {
		
	}
}

