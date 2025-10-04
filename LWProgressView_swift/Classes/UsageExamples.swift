//
// UsageExamples.swift
// Created by Luo Wei on 2025/10/04.
// Copyright (c) 2025 luowei. All rights reserved.
//
// This file demonstrates how to use LWProgressViewSwift in both UIKit and SwiftUI contexts

import SwiftUI
import UIKit

// MARK: - UIKit Usage Examples

@available(iOS 13.0, *)
class UIKitViewController: UIViewController {

    func example1_showProgressView() {
        // Show progress view with text and initial progress
        LWMaskProgressView.showMaskProgressView(
            in: self.view,
            withText: "Loading...",
            progress: 0.0,
            dismissBlock: {
                print("Progress view dismissed")
            }
        )

        // Simulate progress updates
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateProgress(0.3)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.updateProgress(0.6)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.updateProgress(1.0)
            // Auto dismiss after completion
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                LWMaskProgressView.dismissMaskProgressView(in: self.view)
            }
        }
    }

    func updateProgress(_ progress: CGFloat) {
        // Find and update existing progress view
        for subView in view.subviews {
            if let progressView = subView as? LWMaskProgressView {
                progressView.progress = progress
                break
            }
        }
    }

    func example2_dismissProgressView() {
        // Dismiss the progress view programmatically
        LWMaskProgressView.dismissMaskProgressView(in: self.view)
    }

    func example3_createDirectly() {
        // Create progress view directly
        let progressView = LWMaskProgressView(text: "Processing...", progress: 0.5)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - SwiftUI Usage Examples

@available(iOS 13.0, *)
struct SwiftUIExampleView1: View {
    @State private var showProgress = false
    @State private var progress: CGFloat = 0.0

    var body: some View {
        VStack {
            Button("Show Progress") {
                showProgress = true
                simulateProgress()
            }
        }
        .progressOverlay(
            isPresented: $showProgress,
            progress: $progress,
            text: "Cancel",
            onDismiss: {
                print("Progress dismissed")
            }
        )
    }

    private func simulateProgress() {
        progress = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            progress += 0.1
            if progress >= 1.0 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showProgress = false
                }
            }
        }
    }
}

@available(iOS 13.0, *)
struct SwiftUIExampleView2: View {
    @StateObject private var progressState = ProgressState()

    var body: some View {
        VStack(spacing: 20) {
            Button("Start Download") {
                progressState.show(text: "Downloading...", progress: 0.0)
                simulateDownload()
            }

            if progressState.isPresented {
                LWMaskProgressViewSwiftUI(
                    progress: $progressState.progress,
                    text: progressState.text,
                    onDismiss: {
                        progressState.dismiss()
                    }
                )
            }
        }
    }

    private func simulateDownload() {
        var currentProgress: CGFloat = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            currentProgress += 0.05
            progressState.update(progress: currentProgress)

            if currentProgress >= 1.0 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    progressState.dismiss()
                }
            }
        }
    }
}

@available(iOS 13.0, *)
struct SwiftUIExampleView3: View {
    @State private var showProgress = false
    @State private var progress: CGFloat = 0.65

    var body: some View {
        ZStack {
            VStack {
                Text("Main Content")
                Button("Toggle Progress") {
                    showProgress.toggle()
                }
            }

            if showProgress {
                LWMaskProgressViewSwiftUI(
                    progress: $progress,
                    text: "Dismiss",
                    onDismiss: {
                        showProgress = false
                    }
                )
                .transition(.opacity)
            }
        }
    }
}

// MARK: - Standalone CircleProgressBar Usage

@available(iOS 13.0, *)
struct CircleProgressBarExample: View {
    @State private var progress: CGFloat = 0.0

    var body: some View {
        VStack(spacing: 30) {
            CircleProgressBar(
                progress: $progress,
                progressColor: .blue,
                trackColor: .gray.opacity(0.3),
                lineWidth: 6
            )
            .frame(width: 100, height: 100)

            Slider(value: $progress, in: 0...1)
                .padding()

            Text("Progress: \(Int(progress * 100))%")
        }
        .padding()
    }
}

// MARK: - UIKit CircleProgressBar Usage

@available(iOS 13.0, *)
class CircleProgressBarUIKitExample: UIViewController {

    func example_circleProgressBar() {
        let circleProgressBar = CircleProgressBarView()
        circleProgressBar.translatesAutoresizingMaskIntoConstraints = false
        circleProgressBar.progressBarProgressColor = .systemBlue
        circleProgressBar.progressBarTrackColor = .systemGray

        view.addSubview(circleProgressBar)

        NSLayoutConstraint.activate([
            circleProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleProgressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleProgressBar.widthAnchor.constraint(equalToConstant: 100),
            circleProgressBar.heightAnchor.constraint(equalToConstant: 100)
        ])

        // Animate progress
        circleProgressBar.setProgress(0.75, animated: true)
    }
}
