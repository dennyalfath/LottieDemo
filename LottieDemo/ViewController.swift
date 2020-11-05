//
//  ViewController.swift
//  LottieDemo
//
//  Created by Denny Alfath on 18/10/20.
//

import UIKit
import Lottie

struct Slide {
    let title: String
    let animationName: String
    
    static let collection: [Slide] = [
        .init(title: "Practice mindfulness during\n the breaks of your schedule", animationName: "note"),
        .init(title: "Get notified to breathe after\n hectic/busy event/schedule", animationName: "star"),
        .init(title: "Sync your calendar to get the\n most of your breaks", animationName: "calendar")
    ]
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    
    private let slides: [Slide] = Slide.collection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPageControl()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        skipButton.layer.cornerRadius = 10
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = index
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        let slide = slides[indexPath.item]
        cell.configure(with: slide)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with slide: Slide) {
        titleLabel.text = slide.title
        
        let animation = Animation.named(slide.animationName)
        
        animationView.animation = animation
        animationView.loopMode = .loop
        
        if !animationView.isAnimationPlaying {
            animationView.play()
        }
    }
    
}

