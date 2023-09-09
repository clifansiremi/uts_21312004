import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_product_controller.dart';

class UpdateProductView extends GetView<UpdateProductController> {
  const UpdateProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Mahasiswa View'),
        backgroundColor: const Color.fromARGB(255, 158, 21, 12),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.cAlamat.text = data['alamat'];
            controller.cNama.text = data['nama'];
            controller.cJk.text = data['jk'];
            controller.cNpm.text = data['npm'].toString();
            controller.cProgram_studi.text = data['program_studi'];
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: controller.cNpm,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "NPM"),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: controller.cNama,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Nama"),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: controller.cAlamat,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Alamat"),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: controller.cProgram_studi,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: "Program Studi"),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: controller.cJk,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Jenis Kelamin"),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => controller.updateProduct(
                      controller.cAlamat.text,
                      controller.cNama.text,
                      controller.cJk.text,
                      controller.cNpm.text,
                      controller.cProgram_studi.text,
                      Get.arguments,
                    ),
                    child: Text("Ubah"),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
