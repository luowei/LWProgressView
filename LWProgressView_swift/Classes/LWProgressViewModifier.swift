//
// LWProgressViewModifier.swift
// Created by Luo Wei on 2025/10/04.
// Copyright (c) 2025 luowei. All rights reserved.
//

import SwiftUI

/// ViewModifier for easily adding progress overlay to any SwiftUI view
@available(iOS 13.0, *)
public struct LWProgressViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var progress: CGFloat
    var text: String
    var onDismiss: (() -> Void)?

    public func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                LWMaskProgressViewSwiftUI(
                    progress: $progress,
                    text: text,
                    onDismiss: {
                        isPresented = false
                        onDismiss?()
                    }
                )
                .transition(.opacity)
            }
        }
    }
}

/// SwiftUI View extension for convenient progress overlay
@available(iOS 13.0, *)
public extension View {
    /// Adds a progress overlay to the view
    /// - Parameters:
    ///   - isPresented: Binding to control visibility
    ///   - progress: Binding to progress value (0.0 to 1.0)
    ///   - text: Text to display on the dismiss button
    ///   - onDismiss: Closure to execute when dismissed
    func progressOverlay(
        isPresented: Binding<Bool>,
        progress: Binding<CGFloat>,
        text: String = "Dismiss",
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        modifier(LWProgressViewModifier(
            isPresented: isPresented,
            progress: progress,
            text: text,
            onDismiss: onDismiss
        ))
    }
}

/// Environment key for progress state
@available(iOS 13.0, *)
public struct ProgressStateKey: EnvironmentKey {
    public static let defaultValue: ProgressState = ProgressState()
}

@available(iOS 13.0, *)
public extension EnvironmentValues {
    var progressState: ProgressState {
        get { self[ProgressStateKey.self] }
        set { self[ProgressStateKey.self] = newValue }
    }
}

/// Observable object for managing progress state
@available(iOS 13.0, *)
public class ProgressState: ObservableObject {
    @Published public var isPresented: Bool = false
    @Published public var progress: CGFloat = 0.0
    @Published public var text: String = ""

    public init() {}

    public func show(text: String = "", progress: CGFloat = 0.0) {
        self.text = text
        self.progress = progress
        self.isPresented = true
    }

    public func update(progress: CGFloat) {
        self.progress = progress
    }

    public func dismiss() {
        self.isPresented = false
    }
}
