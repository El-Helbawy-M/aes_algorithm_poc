
///This class represents a value that has been encrypted using AES. It stores the following:
///
/// * `encryptedValue`: The base64 encoded ciphertext of the encrypted data.
/// * `ivKey`: The base64 encoded initialization vector (IV) used for encryption (optional).
/// * `valueType`: The original type of the data before encryption.
///
/// **Properties are read-only** to prevent accidental modification of the encrypted data or IV.

class EncryptedValue {
  late String _encryptedValue;
  late String _ivKey;
  Type valueType;
  String get encryptedValue => _encryptedValue;
  String get ivKey => _ivKey;

  EncryptedValue({required String encryptedValue, required this.valueType, String? ivKey}) {
    _encryptedValue = encryptedValue;
    _ivKey = ivKey ?? "";
  }
}
