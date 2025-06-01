import SwiftUI

final class GridWindowController {
    private static var window: NSWindow?

    static func show(model: BingoModel) {
        if let existing = window {
            existing.makeKeyAndOrderFront(nil)
            return
        }

        let view = GridOnlyView(model: model)
        let hosting = NSHostingController(rootView: view)

        let newWindow = NSWindow(
            contentRect: NSRect(x: 200, y: 200, width: 800, height: 600),
            styleMask: [.titled, .resizable, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        newWindow.contentViewController = hosting
        newWindow.title = "Grille des tirages"
        newWindow.isReleasedWhenClosed = false

        if let screen = NSScreen.screens.dropFirst().first {
            newWindow.setFrame(screen.visibleFrame, display: true)
        } else {
            newWindow.center()
        }

        newWindow.makeKeyAndOrderFront(nil)
        window = newWindow
    }

    static func toggleFullScreen() {
        guard let win = window else { return }
        // Important : la rendre key et front sinon toggleFullScreen ne fait rien
        win.makeKeyAndOrderFront(nil)

        // Si déjà en fullscreen, sortir, sinon y aller
        if win.styleMask.contains(.fullScreen) {
            // macOS gère automatiquement le toggle, donc juste appeler une fois suffit
            win.toggleFullScreen(nil)
        } else {
            win.toggleFullScreen(nil)
        }
    }
}
