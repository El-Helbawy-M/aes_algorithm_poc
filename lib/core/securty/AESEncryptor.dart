import 'package:encrypt/encrypt.dart';
import 'encrypted_value.dart';
import 'encryptor_interface.dart';


///This class, `AESEncryptor`, provides a secure way to encrypt and decrypt data using the Advanced Encryption Standard (AES) algorithm. It follows a singleton pattern to ensure only one instance of the encryptor exists.
///
/// **Properties:**
///
/// * `_instance`: This static variable holds the single instance of `AESEncryptor`.
/// * `_encryptor`: This late-initialized variable stores the internal encryption object used for AES operations.
///
/// **Methods:**
///
/// * `init()`: This factory constructor is responsible for creating the singleton instance. It checks if an instance already exists and returns it if so. Otherwise, it creates a new instance and assigns it to the `_instance` variable.
/// * `encrypt(value)`: This method encrypts a provided string value using AES. It:
///     * Generates a random initialization vector (IV) of 16 bytes.
///     * Creates an `Encrypter` object with the AES algorithm and a key derived from the `getKey` method (assumed to be implemented elsewhere and provide the encryption key).
///     * Encrypts the input string using the `Encrypter` object and the random IV.
///     * Returns an `EncryptedValue` object containing the base64 encoded ciphertext, the value's original type, and the base64 encoded IV.
/// * `decrypt(encryptedValue)`: This method decrypts a previously encrypted value using the provided `EncryptedValue` object. It:
///     * Creates an `Encrypter` object with the AES algorithm and a key derived from the `getKey` method.
///     * Decodes the base64 encoded ciphertext and IV from the `EncryptedValue` object.
///     * Decrypts the ciphertext using the `Encrypter` object and the IV.
///     * Returns the decrypted data.
///
/// **Important Notes:**
///
/// * This class relies on the `Encrypter` and `IV` classes from an external library (not shown here) for the encryption operations.
/// * The `getKey` method is assumed to be implemented elsewhere and provide the secret key for encryption/decryption.
///
/// **Security Considerations:**
///
/// * This class uses a random IV for each encryption, which is a good security practice.
/// * The security of this implementation depends entirely on the strength of the encryption key. Make sure to use a strong, cryptographically random key for optimal security.



class AESEncryptor extends KeyEncryptor{
  static AESEncryptor? _instance;
  static AESEncryptor get instance => _instance??AESEncryptor.init();
  AESEncryptor._ins();
  factory AESEncryptor.init(){
    _instance ??= AESEncryptor._ins();
    return _instance!;
  }
  //==============================================
  //============================================== Variables
  //==============================================
  late Encrypter _encryptor;

  @override
  EncryptedValue encrypt(String value){
    IV randomIV = IV.fromLength(16);
    _encryptor = Encrypter(AES(Key.fromUtf8(getKey)));
    final encrypted = _encryptor.encrypt(value.toString(), iv: randomIV);
    return EncryptedValue(encryptedValue: encrypted.base64,valueType: value.runtimeType, ivKey: randomIV.base64);
  }

  @override
  dynamic decrypt(EncryptedValue encryptedValue){
    _encryptor = Encrypter(AES(Key.fromUtf8(getKey)));
    final decrypted = _encryptor.decrypt(Encrypted.from64(encryptedValue.encryptedValue), iv: IV.fromBase64(encryptedValue.ivKey));
    return decrypted;
  }
}



