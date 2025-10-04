//
// CircleProgressBar.swift
// Created by Luo Wei on 2025/10/04.
// Copyright (c) 2025 luowei. All rights reserved.
//

import SwiftUI

/// A circular progress bar view that displays progress as a filled circle
public struct CircleProgressBar: View {
    @Binding var progress: CGFloat
    var progressColor: Color
    var trackColor: Color
    var lineWidth: CGFloat

    public init(
        progress: Binding<CGFloat>,
        progressColor: Color = .white,
        trackColor: Color = .gray,
        lineWidth: CGFloat = 4
    ) {
        self._progress = progress
        self.progressColor = progressColor
        self.trackColor = trackColor
        self.lineWidth = lineWidth
    }

    public var body: some View {
        ZStack {
            // Background track
            Circle()
                .stroke(trackColor, lineWidth: lineWidth)

            // Progress arc
            Circle()
                .trim(from: 0, to: min(progress, 1.0))
                .stroke(progressColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
    }
}

/// UIKit wrapper for CircleProgressBar to maintain compatibility with UIKit-based code
@available(iOS 13.0, *)
public class CircleProgressBarView: UIView {

    private var hostingController: UIHostingController<CircleProgressBar>?

    @Published public var progress: CGFloat = 0 {
        didSet {
            updateProgress()
        }
    }

    public var progressBarProgressColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }

    public var progressBarTrackColor: UIColor = .gray {
        didSet {
            updateColors()
        }
    }

    public var lineWidth: CGFloat = 4 {
        didSet {
            updateLineWidth()
        }
    }

    private var progressBinding: Binding<CGFloat> {
        Binding(
            get: { self.progress },
            set: { self.progress = $0 }
        )
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        let progressBar = CircleProgressBar(
            progress: progressBinding,
            progressColor: Color(progressBarProgressColor),
            trackColor: Color(progressBarTrackColor),
            lineWidth: lineWidth
        )

        hostingController = UIHostingController(rootView: progressBar)

        if let hostingView = hostingController?.view {
            hostingView.backgroundColor = .clear
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(hostingView)

            NSLayoutConstraint.activate([
                hostingView.topAnchor.constraint(equalTo: topAnchor),
                hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
                hostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
                hostingView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }

    public func setProgress(_ progress: CGFloat, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.progress = progress
            }
        } else {
            self.progress = progress
        }
    }

    private func updateProgress() {
        updateView()
    }

    private func updateColors() {
        updateView()
    }

    private func updateLineWidth() {
        updateView()
    }

    private func updateView() {
        let progressBar = CircleProgressBar(
            progress: progressBinding,
            progressColor: Color(progressBarProgressColor),
            trackColor: Color(progressBarTrackColor),
            lineWidth: lineWidth
        )
        hostingController?.rootView = progressBar
    }
}
