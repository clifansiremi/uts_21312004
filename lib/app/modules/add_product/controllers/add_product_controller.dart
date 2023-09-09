import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController cAlamat;
  late TextEditingController cNama;
  late TextEditingController cJk;
  late TextEditingController cNpm;
  late TextEditingController cProgram_studi;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMahasiswa(String alamat, String nama, String jk, String npm,
      String program_studi) async {
    CollectionReference products = firestore.collection("mahasiswa");

    try {
      await products.add({
        "alamat": alamat,
        "nama": nama,
        "jk": jk,
        "npm": npm,
        "program_studi": program_studi,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data mahasiswa.",
          onConfirm: () {
            cAlamat.clear();
            cNama.clear();
            cJk.clear();
            cNpm.clear();
            cProgram_studi.clear();
            Get.back();
            Get.back();
            textConfirm:
            "OK";
          });
    } catch (e) {}
  }

  @override
  void onInit() {
    // TODO: implement onInit
    cAlamat = TextEditingController();
    cNama = TextEditingController();
    cJk = TextEditingController();
    cNpm = TextEditingController();
    cProgram_studi = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cAlamat.dispose();
    cNama.dispose();
    cJk.dispose();
    cNpm.dispose();
    cProgram_studi.dispose();
    super.onClose();
  }
}
