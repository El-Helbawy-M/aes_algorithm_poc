import 'dart:developer';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'core/securty/AESEncryptor.dart';
import 'core/securty/encrypted_value.dart';

void main() async {
  await AESEncryptor.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  TextEditingController _controller = TextEditingController();
  EncryptedValue? encryptedValue;
  bool isDecrypted = false;
  @override
  void initState() {
    AESEncryptor.instance.setKey = encrypt.Key.fromLength(16).base64;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter the text you want to encrypt",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                log("Encrypting the value : ${_controller.text}");
                encryptedValue = AESEncryptor.instance.encrypt(_controller.text);
                log("Encrypted Value: ${encryptedValue?.encryptedValue}");
                setState(() {});
              },
              child: const Text("Encrypt"),
            ),
            if (encryptedValue != null)
              ElevatedButton(
                onPressed: () async {
                  log("Decrypting the value : ${encryptedValue?.encryptedValue}");
                  String decryptedValue = AESEncryptor.instance.decrypt(encryptedValue!);
                  log("Decrypted Value: $decryptedValue");
                  log("Decrypted Validation: ${decryptedValue == _controller.text}");
                  isDecrypted = true;
                  setState(() {});
                },
                child: const Text("Decrypt"),
              ),
            const SizedBox(height: 24),
            if (encryptedValue != null) Text("Encrypted Value: ${encryptedValue?.encryptedValue}"),
          ],
        ),
      )),
    );
  }
}
