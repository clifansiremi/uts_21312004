import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProductController extends GetxController {
  late TextEditingController cAlamat;
  late TextEditingController cNama;
  late TextEditingController cJk;
  late TextEditingController cNpm;
  late TextEditingController cProgram_studi;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("mahasiswa").doc(id);
    return docRef.get();
  }

  void updateProduct(String alamat, String nama, String jk, String npm,
      String program_studi, String id) async {
    DocumentReference productById = firestore.collection("mahasiswa").doc('id');
    try {
      await productById.update({
        "alamat": alamat,
        "nama": nama,
        "jk": jk,
        "npm": npm,
        "program_studi": program_studi,
      });
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data mahasiswa.",
        onConfirm: () {
          cAlamat.clear();
          cNama.clear();
          cJk.clear();
          cNpm.clear();
          cProgram_studi.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Data Mahasiswa.",
      );
    }
  }

  @override
  void onInit() {
    cAlamat = TextEditingController();
    cNama = TextEditingController();
    cJk = TextEditingController();
    cNpm = TextEditingController();
    cProgram_studi = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    cAlamat.dispose();
    cNama.dispose();
    cJk.dispose();
    cNpm.dispose();
    cProgram_studi.dispose();
    super.onClose();
  }
}
