import UIKit

open class TextFieldAdapter {
    /// Used textField for current TextFieldAdapter
    private(set) public var textField: UITextField
    
    // MARK: - Properties
    private var textFieldAdapterDelegate: TextFieldAdapterDelegate!
    /// Default value for delegate method 'textFieldShouldReturn'
    public var shouldReturn: Bool
    
    // MARK: - Closure types
    /// Closure for delegate method 'textFieldShouldReturn'
    public typealias DidReturn = (UITextField) -> Bool
    /// Closure for delegate methods 'textFieldDidBeginEditing' and 'textFieldDidEndEditing'
    public typealias DidBeginEndEditing = (UITextField) -> Void
    /// Closure for target action '.editingChanged'
    public typealias DidTextChanged = (_ textField: UITextField, _ text: String) -> Void
    /// Closure for delegate method 'textField(:, shouldChangeCharactersIn:, replacementString:)'
    public typealias ShouldChangeCharacters = (_ textField: UITextField, _ shouldChangeCharactersIn: NSRange, _ replacementString: String) -> Bool
    
    // MARK: - Callbacks closures
    private(set) var didReturn: DidReturn?
    private(set) var didBeginEditing: DidBeginEndEditing?
    private(set) var didEndEditing: DidBeginEndEditing?
    private(set) var didTextChanged: DidTextChanged?
    private(set) var shouldChangeCharacters: ShouldChangeCharacters?
    
    // MARK: - Init
    public init(textField: UITextField = UITextField()) {
        self.textField = textField
        shouldReturn = true
        
        textFieldAdapterDelegate = TextFieldAdapterDelegate(holder: self)
        
        self.textField.delegate = textFieldAdapterDelegate
        self.textField.addTarget(self, action: #selector(TextFieldAdapter.textFieldDidChangeText(_:)), for: .editingChanged)
    }
    
    // MARK: - Setters
    public func setDidReturn(_ block: DidReturn?) {
        didReturn = block
    }
    
    public func setDidBeginEditing(_ block: DidBeginEndEditing?) {
        didBeginEditing = block
    }
    
    public func setDidEndEditing(_ block: DidBeginEndEditing?) {
        didEndEditing = block
    }
    
    public func setDidTextChanged(_ block: DidTextChanged?) {
        didTextChanged = block
    }

    public func setShouldChangeCharacters(_ block: ShouldChangeCharacters?) {
        shouldChangeCharacters = block
    }
    
    // MARK: - Actions
    @objc
    func textFieldDidChangeText(_ textField: UITextField) {
        didTextChanged?(textField, textField.text ?? "")
    }
}

private class TextFieldAdapterDelegate: NSObject, UITextFieldDelegate {
    unowned var holder: TextFieldAdapter
    
    init(holder: TextFieldAdapter) {
        self.holder = holder
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        holder.didBeginEditing?(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        holder.didEndEditing?(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return holder.didReturn?(textField) ?? holder.shouldReturn
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return holder.shouldChangeCharacters?(textField, range, string) ?? true
    }
}
