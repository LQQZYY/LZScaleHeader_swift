//
//  LZScaleHeader.swift
//  LZScaleHeader
//
//  Created by Artron_LQQ on 16/8/1.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit


var LZScaleHeaderHeight: CGFloat = 200.0;
let screenWidth = UIScreen.mainScreen().bounds.size.width
var __coverView: UIView?
var __scaleHeaderView: LZScaleHeaderView?

extension UIScrollView {
    
    // MARK: - UIScrollView的扩展
    var scaleHeaderView: LZScaleHeaderView? {
        
        set {
            __scaleHeaderView = newValue
        }
        
        get {
            return __scaleHeaderView
        }
    }
    
    var headerHeight: CGFloat {
        
        set {
            
            LZScaleHeaderHeight = newValue
        }
        
        get {
            
            return LZScaleHeaderHeight
        }
    }
    /**
     添加视图图片方法,只包含一个图片
     
     - author: LQQ
     - date: 16-08-01 14:08:14
     
     - parameter image: 需要显示的图片
     */
    func addScaleHeaderWithImage(image: UIImage) {
        
        let header = LZScaleHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: LZScaleHeaderHeight))
        
        if self.isKindOfClass(UITableView) {
            let table = self as! UITableView
            
            let bgView = UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: LZScaleHeaderHeight))
            table.tableHeaderView = bgView
        }
        
        header.backgroundColor = UIColor.clearColor()
        header.image = image
        header.scrollView = self
        
        [self .addSubview(header)];
        self.scaleHeaderView = header
    }
    /**
     添加头视图,含有背景图和自定义视图
     
     - author: LQQ
     - date: 16-08-01 14:08:49
     
     - parameter image: 显示的图片
     - parameter coverView: 自定义视图
     */
    func addScaleHeaderView(image: UIImage, coverView: UIView) {
        self.addScaleHeaderWithImage(image)
        
        coverView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: LZScaleHeaderHeight)
    
        self.addSubview(coverView)
        __coverView = coverView
    }
    
    /**
     移除头视图的方法
     
     - author: LQQ
     - date: 16-08-01 14:08:38
     */
    func removeScaleHeaderView() {
        
        self.scaleHeaderView?.removeFromSuperview()
        self.scaleHeaderView = nil
        
        if __coverView != nil {
            __coverView?.removeFromSuperview()
            __coverView = nil
        }
    }
}


class LZScaleHeaderView: UIImageView {
    // MARK: - 自定义背景视图
    var scrollView: UIScrollView? {
        
        didSet {
            
            scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = nil
        self.contentMode = .ScaleAspectFill
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        self.setNeedsLayout()
    }
    
    override func removeFromSuperview() {
        
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let offSetY = self.scrollView?.contentOffset.y
        
        if offSetY < 0 {
            
            let rect = self.frame
            let orginY = -offSetY!
            let orginX = orginY/rect.size.height*rect.size.width*0.6
            let newRect = CGRect(x: -orginX, y: -orginY, width: screenWidth + 2*orginX, height: LZScaleHeaderHeight + orginY)
            
            self.frame = newRect
        }
    }
}