import Cocoa

class MainView: NSView {
    var onPerformDragOperation: ((_ sender: NSDraggingInfo) -> Void)?
    var onDraggingEnteredHandler: ((_ sender: NSDraggingInfo) -> Void)?
    var onDraggingExitedHandler: ((_ sender: NSDraggingInfo) -> Void)?
    var onDraggingEndedHandler: ((_ sender: NSDraggingInfo) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerForDraggedTypes([.fileURL])
    }
}

extension MainView {
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        guard let char = event.charactersIgnoringModifiers else {
            return
        }
        
        if event.modifierFlags.contains(.command) && char == "w" {
            window?.performClose(event)
        }
    }
}

extension MainView {
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        onPerformDragOperation?(sender)
        return true
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation  {
        onDraggingEnteredHandler?(sender)
        return NSDragOperation.generic
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        onDraggingExitedHandler?(sender!)
    }

    override func draggingEnded(_ sender: NSDraggingInfo) {
        onDraggingEndedHandler?(sender)
    }
}
