//
//  AutoAutoLayout.swift
//  Pods
//
//  Created by Wilhelm Van Der Walt on 1/7/16.
//
//

import Foundation
import UIKit
import ObjectiveC


extension UIView {
    
    public class func withAutoLayout() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    public func addSubviews(views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
	
	public func stackViews(
		stackedViews: [UIView],
		horizontalAttributes: [[NSLayoutAttribute]]? = nil,
		horizontalRelations: [[NSLayoutRelation]]? = nil,
		horizontalPaddings: [[CGFloat]]? = nil,
		gapPadding: CGFloat = 8.0,
		topPadding: CGFloat = 0.0,
		bottomPadding: CGFloat = 0.0
		) {
			var lastView: UIView?
			let hAttributes: [[NSLayoutAttribute]] = self.getHorizontalAttributes(forStackViews: stackedViews, horizontalAttributes: horizontalAttributes)
			let hRelations: [[NSLayoutRelation]] = self.getHorizontalRelations(forStackViews: stackedViews, horizontalRelations: horizontalRelations)
			let hPadding: [[CGFloat]] = self.getHorizontalPadding(forStackViews: stackedViews, horizontalPadding: horizontalPaddings)
			
			for index in 0...(stackedViews.count - 1) {
				if let nLastView = lastView {
                    
					stackedViews[index].addCustomConstraints(inView: self, toViews: [nLastView, self, self], selfAttributes: [NSLayoutAttribute.Top] + hAttributes[index], otherViewAttributes: [NSLayoutAttribute.Bottom] + hAttributes[index], relations: [NSLayoutRelation.Equal] + hRelations[index], padding: [gapPadding] + hPadding[index])
                    
				} else {
                    stackedViews[index].addCustomConstraints(inView: self, selfAttributes: [NSLayoutAttribute.Top] + hAttributes[index], otherViewAttributes: [NSLayoutAttribute.Top] + hAttributes[index], relations: [NSLayoutRelation.Equal] + hRelations[index], padding: [topPadding] + hPadding[index])
				}
				lastView = stackedViews[index]
			}
			
			if let nLastView = lastView {
				nLastView.addCustomConstraints(inView: self, selfAttributes: [.Bottom], otherViewAttributes: [.Bottom], relations: [.Equal], padding: [-bottomPadding])
			}

			
	}
	

	func getHorizontalAttributes(forStackViews stackViews: [UIView], horizontalAttributes: [[NSLayoutAttribute]]?) -> [[NSLayoutAttribute]]{
		if let hAttributes = horizontalAttributes {
			self.validateHorizontalAttributes(forStackViews: stackViews, horizontalAttributes: hAttributes)
			return hAttributes
		}
		else {
            return  stackViews.map({ (view: UIView) -> [NSLayoutAttribute] in
                return [NSLayoutAttribute.CenterX]
            })
		}
	}
	
	func validateHorizontalAttributes(forStackViews stackViews: [UIView], horizontalAttributes: [[NSLayoutAttribute]]) -> Bool {
        let isValid = horizontalAttributes.count == stackViews.count
        if !isValid {
            self.abortWithMessage("The number of views to stack to should equal the number of horizontal attribute sets provided. At the moment you have provided \(stackViews.count) views to stack and \(horizontalAttributes.count) horizontal attribute sets")
        }
        return isValid
	}
	
	func getHorizontalRelations(forStackViews stackViews: [UIView], horizontalRelations: [[NSLayoutRelation]]?) -> [[NSLayoutRelation]]{
		if let hRelations = horizontalRelations {
			self.validateHorizontalRelations(forStackViews: stackViews, horizontalRelations: hRelations)
			return hRelations
		}
		else {
            return  stackViews.map({ (view: UIView) -> [NSLayoutRelation] in
                return [NSLayoutRelation.Equal]
            })
		}
	}
	
	func validateHorizontalRelations(forStackViews stackViews: [UIView], horizontalRelations: [[NSLayoutRelation]]) -> Bool {
        let isValid = horizontalRelations.count == stackViews.count
        if !isValid {
            self.abortWithMessage("The number of views to stack to should equal the number of horizontal relation sets provided. At the moment you have provided \(stackViews.count) views to stack and \(horizontalRelations.count) horizontal relation sets")
        }
        return isValid
	}
    
	
	func getHorizontalPadding(forStackViews stackViews: [UIView], horizontalPadding: [[CGFloat]]?) -> [[CGFloat]]{
		if let hPadding = horizontalPadding {
			self.validateHorizontalPadding(forStackViews: stackViews, horizontalPadding: hPadding)
			return hPadding
		}
		else {
            return  stackViews.map({ (view: UIView) -> [CGFloat] in
                return [0.0]
            })
		}
	}
	
	func validateHorizontalPadding(forStackViews stackViews: [UIView], horizontalPadding: [[CGFloat]]) -> Bool {
        let isValid = horizontalPadding.count == stackViews.count
        if !isValid {
            self.abortWithMessage("The number of views to stack to should equal the number of padding sets provided. At the moment you have provided \(stackViews.count) views to stack and \(horizontalPadding.count) padding sets")
        }
        return isValid
	}
    
    public func addCustomConstraints(
        inView superView: UIView,
        toViews views: [UIView]? = nil,
        selfAttributes: [NSLayoutAttribute],
        otherViewAttributes: [NSLayoutAttribute]? = nil,
        relations: [NSLayoutRelation]? = nil,
        padding: [CGFloat]? = nil )
        -> [NSLayoutConstraint]
    {
        
        let nRelations: [NSLayoutRelation] = (relations != nil && relations?.count == selfAttributes.count) ? relations! : selfAttributes.map{_ in NSLayoutRelation.Equal}
        let nPadding: [CGFloat] = (padding != nil && padding?.count == selfAttributes.count) ? padding! : selfAttributes.map{_ in 0.0}
        let nOtherViewAttributes: [NSLayoutAttribute] = (otherViewAttributes != nil && otherViewAttributes?.count == selfAttributes.count) ? otherViewAttributes! : selfAttributes
        let otherViews: [UIView] = self.getviews(forAttributes: selfAttributes, views: views, superView: superView)
        var constraints: [NSLayoutConstraint] = []
        
        for index in 0...(selfAttributes.count - 1) {
                constraints.append(NSLayoutConstraint(item: self, attribute: selfAttributes[index], relatedBy: nRelations[index], toItem: otherViews[index], attribute: nOtherViewAttributes[index], multiplier: 1.0, constant: nPadding[index]))
            
            
        }
        
        superView.addConstraints(constraints)
        self.addedLayoutConstraints += constraints
        return constraints
    }
    
    func getviews(forAttributes attributes: [NSLayoutAttribute], views: [UIView]?, superView: UIView) -> [UIView]{
        if let nViews = views {
            self.validateViews(forAttributes: attributes, views: nViews)
            return nViews
        }
        else {
            return  attributes.map{_ in superView}
        }
    }
    
    func validateViews(forAttributes attributes: [NSLayoutAttribute], views: [UIView]) -> Bool {
        let isValid = attributes.count <= views.count
        if !isValid {
            self.abortWithMessage("The number of views to constrain to should equal the number of attributes provided. At the moment you have provided \(attributes.count) attributes and \(views.count) views")
        }
        return isValid
    }
    
    public func addConstraintToTopLayoutGuide(
        inView superView: UIView,
        topLayoutGuide: UILayoutSupport,
        selfAttribute: NSLayoutAttribute,
        topLayoutAttribute: NSLayoutAttribute = .Bottom,
        relation: NSLayoutRelation = .Equal,
        padding: CGFloat = 0.0 )
        -> [NSLayoutConstraint]
    {
        let constraints = [NSLayoutConstraint(item: self, attribute: selfAttribute, relatedBy: relation, toItem: topLayoutGuide, attribute: topLayoutAttribute, multiplier: 1.0, constant: padding)]
        superView.addConstraints(constraints)
        self.addedLayoutConstraints.appendContentsOf(constraints)
        return constraints
        
    }
    
    public func addDimensions(width width: CGFloat? = nil, height: CGFloat? = nil, widthRelation: NSLayoutRelation = .Equal, heightRelation: NSLayoutRelation = .Equal) {
        if let w : CGFloat = width {
            let constraints: [NSLayoutConstraint] = [
                NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: widthRelation, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: w),
            ];
            
            self.addConstraints(constraints);
            self.addedDimensionConstraints.appendContentsOf(constraints)
        }
        if let h: CGFloat = height {
            let constraints: [NSLayoutConstraint] = [
                NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: heightRelation, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: h)
            ];
            
            self.addConstraints(constraints);
            self.addedDimensionConstraints.appendContentsOf(constraints)
        }
        
    }
    
    func abortWithMessage(message: String) {
        assertionFailure(message)
    }
    
    
    //MARK: Animation methods
    
    private struct AssociatedKey {
        static var kAddedLayoutConstraints: String = "kAddedLayoutConstraints"
        static var kAddedDimensionsConstraints: String = "kAddedDimensionConstraints"

    }
    
    public var addedLayoutConstraints: [NSLayoutConstraint] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.kAddedLayoutConstraints) as? [NSLayoutConstraint] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.kAddedLayoutConstraints, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var addedDimensionConstraints: [NSLayoutConstraint] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.kAddedDimensionsConstraints) as? [NSLayoutConstraint] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.kAddedDimensionsConstraints, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func animateView(timeInterval: NSTimeInterval, delay: NSTimeInterval = 0.0, options: UIViewAnimationOptions = [], ignoreDimensions: Bool = true, newConstraintsClosure: (() -> ()), completion: (() -> ()) = {}) {
        //This ensures that the constraints are set http://corsarus.com/2015/auto-layout-and-constraints-animation/
        UIView.animateWithDuration(0.0) { () -> Void in
            self.superview?.layoutIfNeeded()
        }
        
        self.superview?.removeConstraints( ignoreDimensions ? self.addedLayoutConstraints: self.addedLayoutConstraints + self.addedDimensionConstraints)
        newConstraintsClosure()
        
        UIView.animateWithDuration(timeInterval, delay: delay, options: options, animations: {[weak self] () -> Void in
            self?.superview?.layoutIfNeeded()
        }) { (success:Bool) -> Void in
            completion()
        }
        
    }
    
   
    
    
}

public extension UITextField {
    override class func withAutoLayout() -> UITextField {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
}

public extension UIScrollView {
    override class func withAutoLayout() -> UIScrollView {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    
}

public extension UITableView {
    override class func withAutoLayout() -> UITableView {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    
}

public extension UILabel {
    override class func withAutoLayout() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    public func multiLine() {
        self.numberOfLines = 0
        self.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
    
}

public extension UIControl {
    override class func withAutoLayout() -> UIControl {
        let control = UIControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
    
    
}


public extension UIButton {
    override class func withAutoLayout() -> UIButton {
        let control = UIButton(type: UIButtonType.Custom)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
}



