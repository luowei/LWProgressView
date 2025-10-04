//
// LWMaskProgressView.swift
// Created by Luo Wei on 2025/10/04.
// Copyright (c) 2025 luowei. All rights reserved.
//

import SwiftUI

/// SwiftUI view for displaying a masked progress view with circular progress indicator
@available(iOS 13.0, *)
public struct LWMaskProgressViewSwiftUI: View {
    @Binding var progress: CGFloat
    var text: String
    var onDismiss: (() -> Void)?

    public init(
        progress: Binding<CGFloat>,
        text: String = "",
        onDismiss: (() -> Void)? = nil
    ) {
        self._progress = progress
        self.text = text
        self.onDismiss = onDismiss
    }

    public var body: some View {
        ZStack {
            // Semi-transparent background
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                // Circular progress bar
                CircleProgressBar(
                    progress: $progress,
                    progressColor: .white,
                    trackColor: .gray,
                    lineWidth: 4
                )
                .frame(width: 50, height: 50)

                // Dismiss button with text
                if !text.isEmpty {
                    Button(action: {
                        onDismiss?()
                    }) {
                        Text(text)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color(red: 0xC8/255, green: 0xC8/255, blue: 0xC8/255))
                            .cornerRadius(2)
                    }
                }
            }
        }
    }
}

/// UIKit-based mask progress view for backward compatibility
@available(iOS 13.0, *)
public class LWMaskProgressView: UIView {

    // MARK: - Properties

    public var textBtn: UIButton!
    private var circleProgressBar: CircleProgressBarView!
    private var dismissBlock: (() -> Void)?

    public var progress: CGFloat = 0 {
        didSet {
            circleProgressBar?.setProgress(progress, animated: false)
        }
    }

    // MARK: - Color Helpers

    private static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

    private static func rgbaHexColor(_ hexValue: Int, _ alphaValue: CGFloat) -> UIColor {
        let r = CGFloat((hexValue & 0xFF0000) >> 16)
        let g = CGFloat((hexValue & 0xFF00) >> 8)
        let b = CGFloat(hexValue & 0xFF)
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alphaValue)
    }

    private static func rgbHexColor(_ hexValue: Int) -> UIColor {
        return rgbaHexColor(hexValue, 1.0)
    }

    // MARK: - Initializers

    public init(text: String, progress: CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = LWMaskProgressView.rgbaHexColor(0x000000, 0.5)
        self.progress = progress
        setupViews()
        show(withText: text, progress: progress)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Setup

    private func setupViews() {
        // Setup circle progress bar
        circleProgressBar = CircleProgressBarView()
        circleProgressBar.backgroundColor = .clear
        circleProgressBar.progressBarProgressColor = .white
        circleProgressBar.progressBarTrackColor = .gray
        circleProgressBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleProgressBar)

        // Setup text button
        textBtn = UIButton(type: .custom)
        textBtn.clipsToBounds = true
        textBtn.titleLabel?.textAlignment = .center
        textBtn.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        textBtn.setTitleColor(.white, for: .normal)
        textBtn.backgroundColor = LWMaskProgressView.rgbHexColor(0xC8C8C8)
        textBtn.layer.cornerRadius = 2
        textBtn.titleLabel?.font = .systemFont(ofSize: 12)
        textBtn.addTarget(self, action: #selector(textBtnAction(_:)), for: .touchUpInside)
        textBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textBtn)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Circle progress bar constraints
            circleProgressBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleProgressBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleProgressBar.widthAnchor.constraint(equalToConstant: 50),
            circleProgressBar.heightAnchor.constraint(equalToConstant: 50),

            // Text button constraints
            textBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            textBtn.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 60)
        ])
    }

    // MARK: - Layout

    public override func layoutSubviews() {
        super.layoutSubviews()
        if let superview = superview {
            frame = superview.bounds
        }
    }

    // MARK: - Public Methods

    public class func showMaskProgressView(
        in view: UIView?,
        withText text: String,
        progress: CGFloat,
        dismissBlock: (() -> Void)? = nil
    ) {
        guard let view = view else { return }

        var maskProgressView: LWMaskProgressView? = nil

        // Check if mask progress view already exists
        for subView in view.subviews {
            if let existingView = subView as? LWMaskProgressView {
                maskProgressView = existingView
                view.bringSubviewToFront(existingView)
                break
            }
        }

        // Create new mask progress view if it doesn't exist
        if maskProgressView == nil {
            maskProgressView = LWMaskProgressView(text: text, progress: progress)
            maskProgressView?.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(maskProgressView!)

            // Add constraints to fill the superview
            NSLayoutConstraint.activate([
                maskProgressView!.topAnchor.constraint(equalTo: view.topAnchor),
                maskProgressView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                maskProgressView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                maskProgressView!.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            view.bringSubviewToFront(maskProgressView!)
        } else {
            maskProgressView?.show(withText: text, progress: progress)
        }

        maskProgressView?.dismissBlock = dismissBlock
    }

    public class func dismissMaskProgressView(in view: UIView?) {
        guard let view = view else { return }

        for subView in view.subviews {
            if subView is LWMaskProgressView {
                subView.removeFromSuperview()
                break
            }
        }
    }

    public func show(withText text: String, progress: CGFloat) {
        textBtn.setTitle(text, for: .normal)
        circleProgressBar.isHidden = false
        bringSubviewToFront(circleProgressBar)
        circleProgressBar.setProgress(progress, animated: false)
    }

    // MARK: - Actions

    @objc private func textBtnAction(_ btn: UIButton) {
        dismissBlock?()
        removeFromSuperview()
    }
}

// MARK: - SwiftUI Preview

@available(iOS 13.0, *)
struct LWMaskProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LWMaskProgressViewSwiftUI(
            progress: .constant(0.6),
            text: "Dismiss",
            onDismiss: {
                print("Dismissed")
            }
        )
    }
}
