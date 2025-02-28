//
//  ViewController.swift
//  BlogTasarim
//
//  Created by ali hasan on 27.02.2025.
//

import UIKit

// Font için extension - Bunu class'tan önce, en üste ekleyin
extension UIFont {
    static func Oswald(ofSize size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Oswald-Regular", size: size) {
            return font
        }
        return .systemFont(ofSize: size)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var blogYazim: UITextView!
    @IBOutlet weak var githubYazi: UILabel!
    @IBOutlet weak var switchButon: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileImage()
        setupInitialTheme()
        setupSwitch()
       
        // Fontları ayarla
        blogYazim.font = UIFont(name: "Oswald-Regular", size: 20)
       
        
        // Başlangıç metnini kaydet ve animasyonu başlat
        if let originalText = blogYazim.text {
            blogYazim.text = "" // Önce metni temizle
            animateTyping(text: originalText)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Profil resmini yuvarlak yap
        profile.layer.cornerRadius = profile.frame.width / 2
        profile.clipsToBounds = true
        
        // Kenarlık ayarları
        profile.layer.borderWidth = 3.0
        profile.layer.borderColor = UIColor.systemRed.cgColor // Başlangıç rengi
        
        // Kenar animasyonu başlat
        startBorderColorAnimation()
    }

    func setupProfileImage() {
        profile.contentMode = .scaleAspectFill  // Görüntüyü düzgün ölçeklendir
        profile.clipsToBounds = true  // Taşmaları engelle
    }

    func startBorderColorAnimation() {
        let colorAnimation = CAKeyframeAnimation(keyPath: "borderColor")
        colorAnimation.values = [
            UIColor.red.cgColor,
            UIColor.blue.cgColor,
            UIColor.green.cgColor,
            UIColor.purple.cgColor
        ]
        colorAnimation.duration = 3.0
        colorAnimation.repeatCount = .infinity
        profile.layer.add(colorAnimation, forKey: "borderColor")
    }

    func animateTyping(text: String) {
        var charIndex = 0
        let typingSpeed: TimeInterval = 0.05 // Her harf arası bekleme süresi
        
        Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { [weak self] timer in
            if charIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: charIndex)
                self?.blogYazim.text.append(text[index])
                charIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    func setupInitialTheme() {
        // Başlangıçta koyu tema
        view.backgroundColor = .black
        blogYazim.backgroundColor = .black
        blogYazim.textColor = .white
        githubYazi.textColor = .white
    }
    
    func setupSwitch() {
        // Switch renk ayarları
        switchButon.onTintColor = .systemBlue // Açık olduğundaki renk
        switchButon.tintColor = .darkGray // Kapalı olduğundaki arka plan
        
        // Switch event handler
        switchButon.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    @objc func switchChanged() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            
            if self.switchButon.isOn {
                // Açık tema (Light mode)
                self.view.backgroundColor = .white
                self.blogYazim.backgroundColor = .white
                self.blogYazim.textColor = .black
                self.githubYazi.textColor = .black
            } else {
                // Koyu tema (Dark mode)
                self.view.backgroundColor = .black
                self.blogYazim.backgroundColor = .black
                self.blogYazim.textColor = .white
                self.githubYazi.textColor = .white
                
            }
        }
    }
    
   
}




