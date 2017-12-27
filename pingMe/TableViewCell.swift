//
//  TableViewCell.swift
//  pingMe
//
//  Created by Dion Boles on 12/27/17.
//  Copyright © 2017 Dion Boles. All rights reserved.
//

import UIKit
protocol TableViewCellDelegate {
    func toDoItemDeleted(todoItem: ToDoItem)
}
class TableViewCell: UITableViewCell {
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    var delegate: TableViewCellDelegate?
    var toDoItem: ToDoItem?
   
    let gradinetLayer = CAGradientLayer()
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        gradinetLayer.frame = bounds
        let color1 = UIColor(white:1.0,alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(white:1.0,alpha: 0.1).cgColor as CGColor
        let color3 = UIColor.clear.cgColor as CGColor
        let color4 = UIColor(white:0.0,alpha: 0.0).cgColor as CGColor
        gradinetLayer.colors = [color1,color2,color3,color4]
        gradinetLayer.locations = [0.0,0.01,0.95,1.0]
        layer.insertSublayer(gradinetLayer, at: 0)
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(TableViewCell.handlePan(recognizer:)))
        recognizer.delegate = self
        addGestureRecognizer(recognizer)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradinetLayer.frame = bounds
    }
    @objc func handlePan(recognizer: UIPanGestureRecognizer){
        if recognizer.state == .began{
            originalCenter = center
        }
        if recognizer.state == .changed{
            let translation = recognizer.translation(in: self)
            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
        }
      
        if recognizer.state == .ended{
            let originalFrame = CGRect(x: 0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)
            if !deleteOnDragRelease{
                UIView.animate(withDuration: 0.2, animations: {self.frame = originalFrame});
            }
            if deleteOnDragRelease{
                if delegate != nil && toDoItem != nil{
                    delegate!.toDoItemDeleted(todoItem: toDoItem!);
                }
            }
            
        }
    }
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognize = gestureRecognizer as? UIPanGestureRecognizer{
            let translation = panGestureRecognize.translation(in: superview!)
            if fabs(translation.x) > fabs(translation.y){
                return true
            }
            return false
        }
        return false
    }
}
